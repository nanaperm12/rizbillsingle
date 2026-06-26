import React, { useState, useEffect, useRef, useCallback } from 'react';
import { View, Text, StyleSheet, useColorScheme, SafeAreaView, ScrollView, TouchableOpacity, TextInput, Modal, ActivityIndicator, Alert, FlatList, Dimensions } from 'react-native';
import { Customer, Package, PackageChange, formatRupiah } from '../../types';
import { apiFetch } from '../../api/api';

interface CustomerProfileProps {
    customer: Customer;
    onLogout: () => void;
    customerPackage: Package | null;
    allPackages: Package[];
    pendingChange: PackageChange | null;
    onUpdate: () => void; // Untuk me-refresh data
    onProfileUpdate: (token: string) => void;
}


const DetailRow: React.FC<{ label: string; value?: string | null }> = ({ label, value }) => {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);
    
    return (
        <View style={styles.detailRow}>
            <Text style={styles.label}>{label}</Text>
            <Text style={styles.value}>{value || '-'}</Text>
        </View>
    );
};

const ConfirmationModal: React.FC<{
    visible: boolean;
    onClose: () => void;
    onConfirm: () => void;
    currentPackageName: string;
    newPackage: Package;
    isSaving: boolean;
}> = ({ visible, onClose, onConfirm, currentPackageName, newPackage, isSaving }) => {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);
    if (!visible) return null;
    return (
        <Modal transparent visible={visible} onRequestClose={onClose} animationType="fade">
            <View style={styles.modalBackdrop}>
                <View style={styles.modalContent}>
                    <Text style={styles.modalTitle}>Konfirmasi Perubahan Paket</Text>
                    <Text style={styles.modalText}>Anda akan mengubah paket dari <Text style={{fontWeight: 'bold'}}>{currentPackageName}</Text> ke <Text style={{fontWeight: 'bold'}}>{newPackage.name}</Text>.</Text>
                    <Text style={styles.modalText}>Perubahan ini akan berlaku pada siklus tagihan Anda berikutnya. Tagihan Anda selanjutnya akan menggunakan harga baru sebesar <Text style={{fontWeight: 'bold'}}>{formatRupiah(newPackage.price)}</Text>.</Text>
                    <View style={styles.modalActions}>
                        <TouchableOpacity onPress={onClose} style={[styles.modalButton, styles.cancelButton]}><Text style={styles.cancelButtonText}>Batal</Text></TouchableOpacity>
                        <TouchableOpacity onPress={onConfirm} disabled={isSaving} style={[styles.modalButton, styles.confirmButton]}>
                            {isSaving ? <ActivityIndicator color="#fff" /> : <Text style={styles.confirmButtonText}>Konfirmasi</Text>}
                        </TouchableOpacity>
                    </View>
                </View>
            </View>
        </Modal>
    );
};


export default function CustomerProfileScreen({ customer, onLogout, customerPackage, allPackages, pendingChange, onUpdate, onProfileUpdate }: CustomerProfileProps) {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);

    const [isEditing, setIsEditing] = useState(false);
    const [formData, setFormData] = useState({ phone: customer.phone, address: customer.address });
    const [isSavingProfile, setIsSavingProfile] = useState(false);
    const [profileError, setProfileError] = useState<string | null>(null);

    const [isConfirmModalOpen, setIsConfirmModalOpen] = useState(false);
    const [selectedPackage, setSelectedPackage] = useState<Package | null>(null);
    const [isSavingPackage, setIsSavingPackage] = useState(false);
    const [packageError, setPackageError] = useState<string | null>(null);

    const flatListRef = useRef<FlatList>(null);
    const [sliderIndex, setSliderIndex] = useState(0);
    const intervalRef = useRef<NodeJS.Timeout | null>(null);

    const availablePackages = allPackages.filter(p => p.id !== customer.packageId);
    
    useEffect(() => {
        setFormData({
            phone: customer.phone,
            address: customer.address,
        });
    }, [customer]);

    const handleSaveProfile = async () => {
        setIsSavingProfile(true);
        setProfileError(null);
        try {
            const res = await apiFetch(`/customers/${customer.id}/profile`, {
                method: 'PUT',
                body: JSON.stringify(formData),
            });
            const data = await res.json();
            if (!data.success || !data.token) {
                throw new Error(data.message || "Gagal memperbarui profil.");
            }
            
            onProfileUpdate(data.token);
            await onUpdate();
            setIsEditing(false);
            Alert.alert('Sukses', 'Profil berhasil diperbarui!');
        } catch (err: any) {
            setProfileError(err.message);
        } finally {
            setIsSavingProfile(false);
        }
    };
    
    const handleSwitchClick = (pkg: Package) => {
        setSelectedPackage(pkg);
        setIsConfirmModalOpen(true);
    };

    const handleConfirmChange = async () => {
        if (!selectedPackage) return;
        setIsSavingPackage(true);
        setPackageError(null);
        try {
            await apiFetch(`/customers/${customer.id}/package-change`, {
                method: 'POST',
                body: JSON.stringify({ new_package_id: selectedPackage.id }),
            });
            await onUpdate();
        } catch (err: any) {
            setPackageError(err.message);
        } finally {
            setIsSavingPackage(false);
            setIsConfirmModalOpen(false);
        }
    };
    
    const handleCancelChange = async () => {
        Alert.alert(
            "Batalkan Permintaan",
            "Apakah Anda yakin ingin membatalkan permintaan perubahan paket?",
            [
                { text: "Tidak" },
                { text: "Ya, Batalkan", onPress: async () => {
                    setIsSavingPackage(true);
                    setPackageError(null);
                    try {
                        await apiFetch(`/customers/${customer.id}/package-change`, { method: 'DELETE' });
                        await onUpdate();
                    } catch (err: any) {
                        setPackageError(err.message);
                    } finally {
                        setIsSavingPackage(false);
                    }
                }}
            ]
        );
    };

    const startAutoScroll = useCallback(() => {
        if (intervalRef.current) clearInterval(intervalRef.current);
        if (availablePackages.length <= 1) return;

        intervalRef.current = setInterval(() => {
            const nextIndex = (sliderIndex + 1) % availablePackages.length;
            flatListRef.current?.scrollToIndex({
                animated: true,
                index: nextIndex,
            });
        }, 4000);
    }, [availablePackages.length, sliderIndex]);

    const stopAutoScroll = useCallback(() => {
        if (intervalRef.current) {
            clearInterval(intervalRef.current);
            intervalRef.current = null;
        }
    }, []);

    useEffect(() => {
        startAutoScroll();
        return () => stopAutoScroll();
    }, [startAutoScroll, stopAutoScroll]);

    const onViewableItemsChanged = useRef(({ viewableItems }: any) => {
        if (viewableItems.length > 0) {
            setSliderIndex(viewableItems[0].index);
        }
    }).current;

    const viewabilityConfig = useRef({ viewAreaCoveragePercentThreshold: 50 }).current;


    return (
        <SafeAreaView style={styles.safeArea}>
             <ConfirmationModal 
                visible={isConfirmModalOpen}
                onClose={() => setIsConfirmModalOpen(false)}
                onConfirm={handleConfirmChange}
                currentPackageName={customerPackage?.name || ''}
                newPackage={selectedPackage!}
                isSaving={isSavingPackage}
            />
            <ScrollView contentContainerStyle={styles.container}>
                <Text style={styles.title}>Profil & Layanan</Text>
                
                 {profileError && <Text style={styles.errorText}>{profileError}</Text>}
                 {packageError && <Text style={styles.errorText}>{packageError}</Text>}

                <View style={styles.card}>
                    <View style={styles.cardHeader}>
                        <Text style={styles.cardTitle}>Profil Saya</Text>
                        {!isEditing && (
                            <TouchableOpacity onPress={() => setIsEditing(true)}>
                                <Text style={styles.editButtonText}>Edit</Text>
                            </TouchableOpacity>
                        )}
                    </View>
                     {isEditing ? (
                        <View style={styles.editContainer}>
                            <TextInput style={styles.input} value={formData.phone} onChangeText={val => setFormData({...formData, phone: val})} placeholder="Telepon" keyboardType="phone-pad" />
                            <TextInput style={styles.input} value={formData.address} onChangeText={val => setFormData({...formData, address: val})} placeholder="Alamat" multiline />
                            <View style={{flexDirection: 'row', justifyContent: 'flex-end', gap: 10, marginTop: 10}}>
                                <TouchableOpacity onPress={() => setIsEditing(false)} style={[styles.actionButton, styles.cancelButton]}>
                                    <Text style={styles.cancelButtonText}>Batal</Text>
                                </TouchableOpacity>
                                <TouchableOpacity onPress={handleSaveProfile} disabled={isSavingProfile} style={[styles.actionButton, styles.saveButton]}>
                                    {isSavingProfile ? <ActivityIndicator color="#fff" /> : <Text style={styles.saveButtonText}>Simpan</Text>}
                                </TouchableOpacity>
                            </View>
                        </View>
                     ) : (
                         <View style={{paddingHorizontal: 16, paddingBottom: 16}}>
                            <DetailRow label="ID Pelanggan" value={customer.id} />
                            <DetailRow label="Nama" value={customer.name} />
                            <DetailRow label="Email" value={customer.email} />
                            <DetailRow label="Telepon" value={customer.phone} />
                            <DetailRow label="Alamat" value={customer.address} />
                        </View>
                     )}
                </View>

                <View style={styles.card}>
                    <View style={styles.cardHeader}>
                        <Text style={styles.cardTitle}>Paket & Upgrade Layanan</Text>
                    </View>
                     {pendingChange ? (
                        <View style={styles.pendingChangeContainer}>
                            <Text style={styles.pendingTitle}>Perubahan Paket Tertunda</Text>
                            <Text style={styles.pendingText}>
                                Anda telah meminta untuk mengubah paket ke <Text style={{fontWeight: 'bold'}}>{pendingChange.new_package_name || (allPackages.find(p => p.id === pendingChange.new_package_id))?.name}</Text>.
                            </Text>
                            <Text style={styles.pendingSubtext}>Perubahan ini akan diterapkan pada siklus tagihan Anda berikutnya.</Text>
                            <TouchableOpacity onPress={handleCancelChange} disabled={isSavingPackage} style={styles.cancelRequestButton}>
                                <Text style={styles.cancelRequestButtonText}>{isSavingPackage ? 'Membatalkan...' : 'Batalkan Permintaan'}</Text>
                            </TouchableOpacity>
                        </View>
                    ) : (
                        <View style={{padding: 16, paddingTop: 0}}>
                            {customerPackage && (
                                <View style={{marginBottom: 20}}>
                                    <Text style={styles.sectionSubtitle}>Paket Anda Saat Ini</Text>
                                    <View style={styles.currentPackageCard}>
                                        <Text style={styles.packageName}>{customerPackage.name}</Text>
                                        <Text style={styles.packageSpeed}>{customerPackage.speed} Mbps</Text>
                                        <Text style={styles.packagePrice}>{formatRupiah(customerPackage.price)} / bulan</Text>
                                    </View>
                                </View>
                            )}
                            <Text style={styles.sectionSubtitle}>Pilih Paket Baru</Text>
                             {availablePackages.length > 0 ? (
                                <>
                                    <FlatList
                                        ref={flatListRef}
                                        data={availablePackages}
                                        horizontal
                                        pagingEnabled
                                        showsHorizontalScrollIndicator={false}
                                        onViewableItemsChanged={onViewableItemsChanged}
                                        viewabilityConfig={viewabilityConfig}
                                        keyExtractor={item => item.id.toString()}
                                        onScrollBeginDrag={stopAutoScroll}
                                        onScrollEndDrag={startAutoScroll}
                                        renderItem={({ item: pkg }) => (
                                            <View style={styles.sliderItem}>
                                                <View style={styles.packageOption}>
                                                    <View>
                                                        <Text style={styles.optionName}>{pkg.name}</Text>
                                                        <Text style={styles.optionSpeed}>{pkg.speed} Mbps</Text>
                                                        <Text style={styles.optionPrice}>{formatRupiah(pkg.price)} / bulan</Text>
                                                    </View>
                                                    <TouchableOpacity onPress={() => handleSwitchClick(pkg)} style={styles.switchButton}>
                                                        <Text style={styles.switchButtonText}>Pilih Paket</Text>
                                                    </TouchableOpacity>
                                                </View>
                                            </View>
                                        )}
                                        style={{ marginHorizontal: -16 }}
                                    />
                                     <View style={styles.pagination}>
                                        {availablePackages.map((_, index) => (
                                            <View
                                                key={index}
                                                style={[styles.dot, sliderIndex === index ? styles.dotActive : {}]}
                                            />
                                        ))}
                                    </View>
                                </>
                            ) : (
                                <Text style={styles.infoText}>Tidak ada paket lain yang tersedia saat ini.</Text>
                            )}
                        </View>
                    )}
                </View>
                
                <TouchableOpacity style={styles.logoutButton} onPress={onLogout}>
                    <Text style={styles.logoutButtonText}>Keluar</Text>
                </TouchableOpacity>
            </ScrollView>
        </SafeAreaView>
    );
}

const sliderWidth = Dimensions.get('window').width - 40;

const getStyles = (isDark: boolean) => StyleSheet.create({
    safeArea: { flex: 1, backgroundColor: isDark ? '#111827' : '#f7f3f6ff' },
    container: { padding: 20 },
    title: { fontSize: 28, fontWeight: 'bold', color: isDark ? '#f9fafb' : '#1f2937', marginBottom: 24 },
    card: { backgroundColor: isDark ? '#1f2937' : '#e2d6c8ff', borderRadius: 12, marginBottom: 16 },
    cardHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', padding: 16 },
    cardTitle: { fontSize: 18, fontWeight: '600', color: isDark ? '#e5e7eb' : '#374151' },
    editButtonText: { color: '#2563eb', fontWeight: '500' },
    detailRow: { paddingVertical: 14, borderBottomWidth: 1, borderBottomColor: isDark ? '#374151' : '#e5e7eb' },
    label: { fontSize: 14, color: isDark ? '#9ca3af' : '#6b7280', marginBottom: 4 },
    value: { fontSize: 16, color: isDark ? '#f9fafb' : '#1f2937', fontWeight: '500' },
    logoutButton: { marginTop: 32, backgroundColor: isDark ? '#374151' : '#fee2e2', borderRadius: 8, paddingVertical: 14, alignItems: 'center' },
    logoutButtonText: { color: isDark ? '#f87171' : '#991b1b', fontSize: 16, fontWeight: '600' },
    editContainer: { padding: 16, paddingTop: 0, gap: 12 },
    input: { backgroundColor: isDark ? '#374151' : '#f3f4f6', borderColor: isDark ? '#4b5563' : '#d1d5db', borderWidth: 1, borderRadius: 8, padding: 12, color: isDark ? '#fff' : '#000' },
    actionButton: { paddingHorizontal: 16, paddingVertical: 10, borderRadius: 8 },
    saveButton: { backgroundColor: '#2563eb' },
    saveButtonText: { color: '#fff', fontWeight: '600' },
    cancelButton: { backgroundColor: isDark ? '#4b5563' : '#e5e7eb' },
    cancelButtonText: { color: isDark ? '#fff' : '#000', fontWeight: '600' },
    errorText: { color: '#ef4444', textAlign: 'center', marginBottom: 12 },
    sectionSubtitle: { fontSize: 16, fontWeight: '600', color: isDark ? '#d1d5db' : '#4b5563', marginBottom: 8 },
    currentPackageCard: { backgroundColor: isDark ? '#374151' : '#e2a27dff', padding: 12, borderRadius: 8 },
    packageName: { fontSize: 18, fontWeight: 'bold', color: isDark ? '#60a5fa' : '#2563eb' },
    packageSpeed: { fontSize: 16, fontWeight: '600', color: isDark ? '#d1d5db' : '#374151' },
    packagePrice: { color: isDark ? '#9ca3af' : '#6b7280' },
    sliderItem: { width: sliderWidth, paddingHorizontal: 16 },
    packageOption: { backgroundColor: isDark ? '#1f2937' : '#d3c897ff', padding: 16, borderWidth: 1, borderColor: isDark ? '#4b5563' : '#e5e7eb', borderRadius: 12, minHeight: 160, justifyContent: 'space-between' },
    optionName: { fontWeight: 'bold', color: isDark ? '#f9fafb' : '#1f2937', fontSize: 16 },
    optionSpeed: { color: isDark ? '#d1d5db' : '#374151' },
    optionPrice: { fontSize: 14, color: isDark ? '#9ca3af' : '#6b7280' },
    switchButton: { backgroundColor: '#16a34a', paddingVertical: 10, borderRadius: 8, marginTop: 12 },
    switchButtonText: { color: '#fff', fontWeight: '600', textAlign: 'center' },
    pagination: { flexDirection: 'row', justifyContent: 'center', alignItems: 'center', marginTop: 24, height: 10 },
    dot: { width: 8, height: 8, borderRadius: 4, backgroundColor: isDark ? '#4b5563' : '#d1d5db', marginHorizontal: 4 },
    dotActive: { backgroundColor: '#2563eb' },
    infoText: { color: isDark ? '#9ca3af' : '#6b7280', textAlign: 'center' },
    pendingChangeContainer: { padding: 16, backgroundColor: isDark ? 'rgba(59, 130, 246, 0.2)' : '#f5e3c8ff', borderLeftWidth: 4, borderLeftColor: '#e0960bd5' },
    pendingTitle: { fontWeight: 'bold', color: isDark ? '#93c5fd' : '#1e40af' },
    pendingText: { marginTop: 4, color: isDark ? '#bfdbfe' : '#1d4ed8' },
    pendingSubtext: { fontSize: 12, marginTop: 2, color: isDark ? '#93c5fd' : '#123188ff' },
    cancelRequestButton: { marginTop: 12 },
    cancelRequestButtonText: { color: '#ef4444', fontWeight: '600', textDecorationLine: 'underline' },
    modalBackdrop: { flex: 1, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'center', alignItems: 'center', padding: 20 },
    modalContent: { backgroundColor: isDark ? '#1f2937' : '#fff', borderRadius: 12, padding: 20, width: '100%', maxHeight: '80%' },
    modalTitle: { fontSize: 18, fontWeight: 'bold', color: isDark ? '#fff' : '#000', marginBottom: 15 },
    modalText: { color: isDark ? '#d1d5db' : '#374151', marginBottom: 10, lineHeight: 20 },
    modalActions: { flexDirection: 'row', justifyContent: 'flex-end', marginTop: 20 },
    modalButton: { paddingHorizontal: 20, paddingVertical: 10, borderRadius: 8, marginLeft: 10 },
    confirmButton: { backgroundColor: '#2563eb' },
    confirmButtonText: { color: '#fff' },
});