import React, { useState } from 'react';
import { 
    View, Text, StyleSheet, useColorScheme, FlatList, SafeAreaView, 
    TouchableOpacity, Modal, TextInput, ActivityIndicator, RefreshControl, 
    KeyboardAvoidingView, Platform, Image, Alert
} from 'react-native';
import * as ImagePicker from 'expo-image-picker';
import { Customer, Complaint, ComplaintType, ComplaintStatus, formatDateTimeDisplay, formatTimeDisplay } from '../../types';
import { ComplaintStatusTag } from './shared/ComplaintStatusTag';
import { Ionicons } from '@expo/vector-icons';
import { API_BASE_URL } from '../../api/config';

type ImagePickerAsset = ImagePicker.ImagePickerAsset;

// Modal for creating a new complaint
interface ComplaintModalProps {
    visible: boolean;
    onClose: () => void;
    onSave: (data: { type: ComplaintType; description: string; photo?: ImagePickerAsset | null }) => Promise<any>;
}

const ComplaintModal: React.FC<ComplaintModalProps> = ({ visible, onClose, onSave }) => {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);
    const [type, setType] = useState<ComplaintType>(ComplaintType.SlowConnection);
    const [description, setDescription] = useState('');
    const [photo, setPhoto] = useState<ImagePickerAsset | null>(null);
    const [isSaving, setIsSaving] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const handlePickImage = async () => {
        const permissionResult = await ImagePicker.requestMediaLibraryPermissionsAsync();
        if (permissionResult.granted === false) {
            Alert.alert("Permission Required", "You've refused to allow this app to access your photos!");
            return;
        }

        const result = await ImagePicker.launchImageLibraryAsync({
            mediaTypes: ImagePicker.MediaTypeOptions.Images,
            allowsEditing: true,
            aspect: [4, 3],
            quality: 0.8,
        });

        if (!result.canceled) {
            setPhoto(result.assets[0]);
        }
    };
    
    const handleSubmit = async () => {
        setError(null);
        if (!description.trim()) {
            setError('Please provide a description of your issue.');
            return;
        }

        setIsSaving(true);
        try {
            const result = await onSave({ type, description, photo });
            if (result?.success) {
                setType(ComplaintType.SlowConnection);
                setDescription('');
                setPhoto(null);
                onClose();
            }
        } catch (e: any) {
            setError(e.message || 'An unknown error occurred.');
        } finally {
            setIsSaving(false);
        }
    };
    
    return (
        <Modal visible={visible} onRequestClose={onClose} transparent animationType="fade">
            <KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"} style={styles.modalBackdrop}>
                <View style={styles.modalContent}>
                    <Text style={styles.modalTitle}>Submit a Complaint</Text>
                    
                    <TextInput
                        style={styles.input}
                        placeholder="Describe your issue in detail..."
                        placeholderTextColor={isDark ? '#9ca3af' : '#6b7280'}
                        value={description}
                        onChangeText={setDescription}
                        multiline
                        numberOfLines={4}
                    />
                    
                    <View style={{ flexDirection: 'row', alignItems: 'center', marginVertical: 10 }}>
                        <TouchableOpacity onPress={handlePickImage} style={styles.attachButton}>
                            <Ionicons name="attach" size={24} color={isDark ? '#9ca3af' : '#6b7280'} />
                            <Text style={styles.attachButtonText}>{photo ? 'Change Photo' : 'Attach Photo'}</Text>
                        </TouchableOpacity>
                        {photo && (
                             <View style={{ position: 'relative', marginLeft: 15 }}>
                                <Image source={{ uri: photo.uri }} style={{ width: 60, height: 60, borderRadius: 8 }} />
                                <TouchableOpacity onPress={() => setPhoto(null)} style={styles.removeImageButton}>
                                    <Ionicons name="close-circle" size={20} color="#ef4444" />
                                </TouchableOpacity>
                            </View>
                        )}
                    </View>

                    {error && <Text style={styles.errorText}>{error}</Text>}
                    
                    <View style={styles.modalActions}>
                        <TouchableOpacity onPress={onClose} style={[styles.modalButton, styles.cancelButton]}><Text style={styles.cancelButtonText}>Cancel</Text></TouchableOpacity>
                        <TouchableOpacity onPress={handleSubmit} disabled={isSaving} style={[styles.modalButton, styles.confirmButton]}>
                             {isSaving ? <ActivityIndicator color="#fff" /> : <Text style={styles.confirmButtonText}>Submit</Text>}
                        </TouchableOpacity>
                    </View>
                </View>
            </KeyboardAvoidingView>
        </Modal>
    );
};


interface Props {
    customer: Customer;
    complaints: Complaint[];
    onSaveComplaint: (data: { type: ComplaintType; description: string; photo?: ImagePickerAsset | null }) => Promise<any>;
    onRefresh: () => void;
    isRefreshing: boolean;
    onSendReply: (complaintId: string, replyText: string, photo?: ImagePickerAsset | null) => Promise<{ success: boolean; message?: string; } | undefined>;
}

export default function CustomerHelpScreen({ customer, complaints, onSaveComplaint, onRefresh, isRefreshing, onSendReply }: Props) {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);
    const [modalVisible, setModalVisible] = useState(false);

    const [replyInputs, setReplyInputs] = useState<Record<string, string>>({});
    const [replyPhotos, setReplyPhotos] = useState<Record<string, ImagePickerAsset | null>>({});
    const [isReplying, setIsReplying] = useState<string | null>(null);
    const [expandedComplaints, setExpandedComplaints] = useState<Set<string>>(new Set());

    const toggleExpansion = (id: string) => {
        setExpandedComplaints(prev => {
            const newSet = new Set(prev);
            if (newSet.has(id)) newSet.delete(id);
            else newSet.add(id);
            return newSet;
        });
    };
    
    const pickReplyImage = async (complaintId: string) => {
        const permissionResult = await ImagePicker.requestMediaLibraryPermissionsAsync();
        if (permissionResult.granted === false) {
            Alert.alert("Permission Required", "You've refused to allow this app to access your photos!");
            return;
        }

        const result = await ImagePicker.launchImageLibraryAsync({
            mediaTypes: ImagePicker.MediaTypeOptions.Images,
            allowsEditing: true,
            aspect: [4, 3],
            quality: 0.8,
        });

        if (!result.canceled) {
            setReplyPhotos(prev => ({
                ...prev,
                [complaintId]: result.assets[0]
            }));
        }
    };

    const handleReply = async (complaintId: string) => {
        const replyText = replyInputs[complaintId] || '';
        const photoAsset = replyPhotos[complaintId];
        if (!replyText.trim() && !photoAsset) return;

        setIsReplying(complaintId);
        try {
            const result = await onSendReply(complaintId, replyText, photoAsset);
            if (result?.success) {
                setReplyInputs(prev => ({ ...prev, [complaintId]: '' }));
                setReplyPhotos(prev => ({ ...prev, [complaintId]: null }));
            }
        } catch (e: any) {
            console.error('Error in CustomerHelpScreen handleReply:', e);
        } finally {
            setIsReplying(null);
        }
    };

    const renderComplaintItem = ({ item }: { item: Complaint }) => {
        const isResolved = item.status === ComplaintStatus.Resolved;
        const isExpanded = !isResolved || expandedComplaints.has(item.id);

        const conversation = [
            { id: item.id, senderType: 'customer', senderName: item.customerName, replyText: item.description, createdAt: item.dateSubmitted, photos: item.photos },
            ...(item.replies || [])
        ].sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime());

        return (
            <View style={styles.card}>
                <View style={styles.cardHeader}>
                    <View style={{ flex: 1 }}>
                        <Text style={styles.complaintType}>{item.type}</Text>
                        <Text style={styles.complaintDate}>#{item.id.split('-')[1]} • {formatDateTimeDisplay(item.dateSubmitted)}</Text>
                    </View>
                    <ComplaintStatusTag status={item.status} />
                </View>

                {isExpanded ? (
                    <>
                        <View style={styles.conversationContainer}>
                            {conversation.map((msg: any, index) => (
                                <View key={`${msg.id}-${index}`} style={[styles.messageBubble, msg.senderType === 'customer' ? styles.userMessage : styles.adminMessage]}>
                                    {msg.photos && msg.photos.length > 0 && (
                                        <View style={styles.photoGrid}>
                                            {msg.photos.map((photoUrl: string, pIndex: number) => (
                                                <Image key={pIndex} source={{ uri: `${API_BASE_URL.replace('/api', '')}${photoUrl}` }} style={styles.thumbnail} />
                                            ))}
                                        </View>
                                    )}
                                    {msg.replyText && <Text style={msg.senderType === 'customer' ? styles.userMessageText : styles.adminMessageText}>{msg.replyText}</Text>}
                                    <Text style={styles.messageTimestamp}>{msg.senderName} • {formatTimeDisplay(msg.createdAt)}</Text>
                                </View>
                            ))}
                        </View>
                        {!isResolved && (
                            <View style={styles.replyContainer}>
                                {replyPhotos[item.id] && (
                                    <View style={{ position: 'relative', marginBottom: 10, alignSelf: 'flex-start' }}>
                                        <Image source={{ uri: replyPhotos[item.id]?.uri }} style={{ width: 60, height: 60, borderRadius: 8 }} />
                                        <TouchableOpacity onPress={() => setReplyPhotos(prev => ({...prev, [item.id]: null}))} style={styles.removeImageButton}>
                                            <Ionicons name="close-circle" size={20} color="#ef4444" />
                                        </TouchableOpacity>
                                    </View>
                                )}
                                <View style={styles.replyInputRow}>
                                    <TextInput
                                        style={styles.replyInput}
                                        placeholder="Type your reply..."
                                        placeholderTextColor={isDark ? '#9ca3af' : '#6b7280'}
                                        value={replyInputs[item.id] || ''}
                                        onChangeText={text => setReplyInputs(prev => ({...prev, [item.id]: text}))}
                                        multiline
                                        editable={!isReplying}
                                    />
                                    <TouchableOpacity onPress={() => pickReplyImage(item.id)} style={styles.iconButton} disabled={!!isReplying}>
                                        <Ionicons name="attach" size={24} color={isDark ? '#9ca3af' : '#6b7280'} />
                                    </TouchableOpacity>
                                    <TouchableOpacity onPress={() => handleReply(item.id)} style={[styles.sendButton, (isReplying === item.id || (! (replyInputs[item.id] || '').trim() && !replyPhotos[item.id])) && styles.sendButtonDisabled]} disabled={isReplying === item.id || (! (replyInputs[item.id] || '').trim() && !replyPhotos[item.id])}>
                                        {isReplying === item.id ? <ActivityIndicator size="small" color="#fff" /> : <Ionicons name="send" size={20} color="#fff" />}
                                    </TouchableOpacity>
                                </View>
                            </View>
                        )}
                    </>
                ) : (
                    <TouchableOpacity onPress={() => toggleExpansion(item.id)} style={styles.toggleButton}>
                        <Text style={styles.toggleButtonText}>Show Conversation</Text>
                    </TouchableOpacity>
                )}
            </View>
        );
    };

    return (
        <SafeAreaView style={styles.safeArea}>
            <ComplaintModal visible={modalVisible} onClose={() => setModalVisible(false)} onSave={onSaveComplaint} />
            <KeyboardAvoidingView behavior={Platform.OS === 'ios' ? 'padding' : 'height'} style={{ flex: 1 }}>
                <FlatList
                    data={complaints}
                    renderItem={renderComplaintItem}
                    keyExtractor={item => item.id}
                    contentContainerStyle={styles.container}
                    ListHeaderComponent={
                        <View style={styles.headerContainer}>
                            <Text style={styles.title}>Help & Support</Text>
                            <TouchableOpacity onPress={() => setModalVisible(true)} style={styles.newButton}>
                                <Text style={styles.newButtonText}>New Complaint</Text>
                            </TouchableOpacity>
                        </View>
                    }
                    ListEmptyComponent={<Text style={styles.emptyText}>You have no complaints on record.</Text>}
                    refreshControl={<RefreshControl refreshing={isRefreshing} onRefresh={onRefresh} tintColor={isDark ? '#fff' : '#000'} />}
                />
            </KeyboardAvoidingView>
        </SafeAreaView>
    );
}

const getStyles = (isDark: boolean) => StyleSheet.create({
  safeArea: { flex: 1, backgroundColor: isDark ? '#111827' : '#f3f4f6' },
  container: { paddingHorizontal: 16, paddingBottom: 20 },
  headerContainer: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 24, paddingTop: 20, paddingHorizontal: 4 },
  title: { fontSize: 28, fontWeight: 'bold', color: isDark ? '#f9fafb' : '#1f2937' },
  newButton: { backgroundColor: '#2563eb', paddingHorizontal: 16, paddingVertical: 10, borderRadius: 8 },
  newButtonText: { color: '#fff', fontWeight: '600' },
  card: { backgroundColor: isDark ? '#1f2937' : '#e2d6c8ff', borderRadius: 12, marginBottom: 16, overflow: 'hidden' },
  cardHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'flex-start', padding: 16 },
  complaintType: { fontSize: 16, fontWeight: 'bold', color: isDark ? '#e5e7eb' : '#374151' },
  complaintDate: { fontSize: 12, color: isDark ? '#9ca3af' : '#6b7280' },
  conversationContainer: { padding: 16, paddingTop: 0 },
  messageBubble: { maxWidth: '85%', padding: 12, borderRadius: 16, marginBottom: 8 },
  userMessage: { backgroundColor: '#2563eb', alignSelf: 'flex-end', borderBottomRightRadius: 4 },
  adminMessage: { backgroundColor: isDark ? '#374151' : '#e5e7eb', alignSelf: 'flex-start', borderBottomLeftRadius: 4 },
  userMessageText: { color: '#fff', fontSize: 14 },
  adminMessageText: { color: isDark ? '#f9fafb' : '#1f2937', fontSize: 14 },
  messageTimestamp: { fontSize: 10, marginTop: 4, textAlign: 'right', opacity: 0.8, color: isDark ? '#9ca3af' : '#6b7280' },
  photoGrid: { flexDirection: 'row', flexWrap: 'wrap', gap: 8, marginBottom: 8 },
  thumbnail: { width: 80, height: 80, borderRadius: 8, borderWidth: 1, borderColor: isDark ? '#4b5563' : '#e5e7eb' },
  replyContainer: { borderTopWidth: 1, borderTopColor: isDark ? '#374151' : '#e5e7eb', padding: 16 },
  replyInputRow: { flexDirection: 'row', alignItems: 'flex-end', gap: 8 },
  replyInput: { flex: 1, minHeight: 44, backgroundColor: isDark ? '#374151' : '#f3f4f6', borderColor: isDark ? '#4b5563' : '#d1d5db', borderWidth: 1, borderRadius: 22, paddingHorizontal: 16, paddingTop: 12, paddingBottom: 12, fontSize: 14, color: isDark ? '#f9fafb' : '#111827' },
  iconButton: { padding: 8, alignSelf: 'center' },
  sendButton: { backgroundColor: '#2563eb', borderRadius: 22, width: 44, height: 44, justifyContent: 'center', alignItems: 'center' },
  sendButtonDisabled: { backgroundColor: '#60a5fa' },
  removeImageButton: { position: 'absolute', top: -5, right: -5, backgroundColor: isDark ? '#374151' : '#fff', borderRadius: 99 },
  toggleButton: { padding: 12, borderTopWidth: 1, borderTopColor: isDark ? '#374151' : '#e5e7eb', alignItems: 'center' },
  toggleButtonText: { color: '#2563eb', fontWeight: '500' },
  emptyText: { textAlign: 'center', marginTop: 40, color: isDark ? '#9ca3af' : '#6b7280' },
  modalBackdrop: { flex: 1, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'center', alignItems: 'center', padding: 20 },
  modalContent: { backgroundColor: isDark ? '#1f2937' : '#fff', borderRadius: 12, padding: 20, width: '100%', maxHeight: '80%' },
  modalTitle: { fontSize: 18, fontWeight: 'bold', color: isDark ? '#fff' : '#000', marginBottom: 15 },
  input: { minHeight: 100, textAlignVertical: 'top', backgroundColor: isDark ? '#374151' : '#f3f4f6', borderColor: isDark ? '#4b5563' : '#d1d5db', borderWidth: 1, borderRadius: 8, padding: 12, fontSize: 14, color: isDark ? '#f9fafb' : '#111827' },
  attachButton: { flexDirection: 'row', alignItems: 'center', padding: 8 },
  attachButtonText: { color: isDark ? '#9ca3af' : '#6b7280', marginLeft: 8 },
  modalActions: { flexDirection: 'row', justifyContent: 'flex-end', marginTop: 20 },
  modalButton: { paddingHorizontal: 20, paddingVertical: 10, borderRadius: 8, marginLeft: 10 },
  cancelButton: { backgroundColor: isDark ? '#4b5563' : '#e5e7eb' },
  cancelButtonText: { color: isDark ? '#fff' : '#000' },
  confirmButton: { backgroundColor: '#2563eb' },
  confirmButtonText: { color: '#fff' },
  errorText: { color: '#ef4444', marginTop: 10 }
});