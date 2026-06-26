import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, useColorScheme, FlatList, SafeAreaView, TouchableOpacity, Modal, ActivityIndicator } from 'react-native';
import { Customer, Invoice, PaymentStatus, formatRupiah, formatBillingPeriod, formatDateDisplay } from '../../types';
import { PaymentStatusTag } from './shared/PaymentStatusTag';
import { apiFetch } from '../../api/api';

interface PaymentChannel { code: string; name: string; icon_url: string; }

interface PaymentMethodModalProps {
    visible: boolean;
    onClose: () => void;
    onConfirm: (method: string) => void;
}

const PaymentMethodModal: React.FC<PaymentMethodModalProps> = ({ visible, onClose, onConfirm }) => {
    const [channels, setChannels] = useState<PaymentChannel[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const [selectedMethod, setSelectedMethod] = useState<string>('');
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);

    useEffect(() => {
        if (visible) {
            setIsLoading(true);
            apiFetch('/public/payment-channels')
                .then(res => res.json())
                .then((data: PaymentChannel[]) => {
                    const ewalletOrder = ['QRIS', 'SHOPEEPAY', 'OVO', 'DANA', 'LINKAJA'];
                    const sorted = data.sort((a, b) => {
                        const aIsEwallet = ewalletOrder.includes(a.code);
                        const bIsEwallet = ewalletOrder.includes(b.code);
                        if (aIsEwallet && !bIsEwallet) return -1;
                        if (!aIsEwallet && bIsEwallet) return 1;
                        return a.name.localeCompare(b.name);
                    });
                    setChannels(sorted);
                    if (sorted.length > 0) setSelectedMethod(sorted[0].code);
                })
                .catch(err => console.error("Failed to fetch payment channels", err))
                .finally(() => setIsLoading(false));
        }
    }, [visible]);

    return (
        <Modal transparent visible={visible} onRequestClose={onClose} animationType="fade">
            <View style={styles.modalBackdrop}>
                <View style={styles.modalContent}>
                    <Text style={styles.modalTitle}>Choose Payment Method</Text>
                    {isLoading ? <ActivityIndicator /> : (
                        <FlatList
                            data={channels}
                            keyExtractor={item => item.code}
                            renderItem={({ item }) => (
                                <TouchableOpacity onPress={() => setSelectedMethod(item.code)} style={[styles.channelItem, selectedMethod === item.code && styles.channelItemSelected]}>
                                    <Text style={styles.channelText}>{item.name}</Text>
                                </TouchableOpacity>
                            )}
                        />
                    )}
                    <View style={styles.modalActions}>
                        <TouchableOpacity onPress={onClose} style={[styles.modalButton, styles.cancelButton]}><Text style={styles.cancelButtonText}>Cancel</Text></TouchableOpacity>
                        <TouchableOpacity onPress={() => onConfirm(selectedMethod)} disabled={!selectedMethod || isLoading} style={[styles.modalButton, styles.confirmButton]}><Text style={styles.confirmButtonText}>Confirm</Text></TouchableOpacity>
                    </View>
                </View>
            </View>
        </Modal>
    );
};

interface Props {
    customer: Customer;
    invoices: Invoice[];
    onCreatePaymentLink: (invoiceId: string, method: string) => Promise<void>;
}

export default function CustomerBillsScreen({ customer, invoices, onCreatePaymentLink }: Props) {
    const colorScheme = useColorScheme();
    const isDark = colorScheme === 'dark';
    const styles = getStyles(isDark);
    
    const [modalVisible, setModalVisible] = useState(false);
    const [selectedInvoice, setSelectedInvoice] = useState<Invoice | null>(null);
    const [isProcessing, setIsProcessing] = useState<string | null>(null);

    const handlePayPress = (invoice: Invoice) => {
        setSelectedInvoice(invoice);
        setModalVisible(true);
    };

    const handleConfirmPayment = async (method: string) => {
        if (!selectedInvoice) return;
        setModalVisible(false);
        setIsProcessing(selectedInvoice.id);
        await onCreatePaymentLink(selectedInvoice.id, method);
        setIsProcessing(null);
        setSelectedInvoice(null);
    };

    const renderItem = ({ item }: { item: Invoice }) => (
        <View style={styles.card}>
            <View style={styles.cardHeader}>
                <Text style={styles.invoiceId}>{item.id}</Text>
                <PaymentStatusTag status={item.status} />
            </View>
            <View style={styles.cardBody}>
                <Text style={styles.amount}>{formatRupiah(item.amount)}</Text>
                <Text style={styles.dateText}>Due: {formatDateDisplay(item.dueDate)}</Text>
                <Text style={styles.dateText}>Period: {formatBillingPeriod(item.billingPeriodStart, item.billingPeriodEnd)}</Text>
            </View>
            {(item.status === PaymentStatus.Unpaid || item.status === PaymentStatus.Overdue) && (
                <TouchableOpacity onPress={() => handlePayPress(item)} disabled={!!isProcessing} style={styles.payButton}>
                    {isProcessing === item.id ? <ActivityIndicator color="#fff" /> : <Text style={styles.payButtonText}>Pay Now</Text>}
                </TouchableOpacity>
            )}
        </View>
    );

    return (
        <SafeAreaView style={styles.safeArea}>
            <PaymentMethodModal
                visible={modalVisible}
                onClose={() => setModalVisible(false)}
                onConfirm={handleConfirmPayment}
            />
            <FlatList
                data={invoices}
                renderItem={renderItem}
                keyExtractor={item => item.id}
                contentContainerStyle={styles.container}
                ListHeaderComponent={<Text style={styles.title}>Bills & Payments</Text>}
                ListEmptyComponent={<Text style={styles.emptyText}>You have no billing history.</Text>}
            />
        </SafeAreaView>
    );
}

const getStyles = (isDark: boolean) => StyleSheet.create({
    safeArea: { flex: 1, backgroundColor: isDark ? '#111827' : '#f3f4f6' },
    container: { padding: 20 },
    title: { fontSize: 28, fontWeight: 'bold', color: isDark ? '#f9fafb' : '#1f2937', marginBottom: 24 },
    card: { backgroundColor: isDark ? '#1f2937' : '#e2d6c8ff', borderRadius: 12, marginBottom: 16, overflow: 'hidden' },
    cardHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', padding: 16, borderBottomWidth: 1, borderBottomColor: isDark ? '#374151' : '#e5e7eb' },
    invoiceId: { fontSize: 16, fontWeight: '600', color: isDark ? '#e5e7eb' : '#374151' },
    cardBody: { padding: 16 },
    amount: { fontSize: 22, fontWeight: 'bold', color: isDark ? '#f9fafb' : '#1f2937' },
    dateText: { fontSize: 14, color: isDark ? '#9ca3af' : '#6b7280', marginTop: 4 },
    payButton: { backgroundColor: '#2563eb', paddingVertical: 12, justifyContent: 'center', alignItems: 'center' },
    payButtonText: { color: '#fff', fontSize: 16, fontWeight: '600' },
    emptyText: { textAlign: 'center', marginTop: 40, color: isDark ? '#9ca3af' : '#6b7280' },
    modalBackdrop: { flex: 1, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'center', alignItems: 'center', padding: 20 },
    modalContent: { backgroundColor: isDark ? '#1f2937' : '#fff', borderRadius: 12, padding: 20, width: '100%', maxHeight: '80%' },
    modalTitle: { fontSize: 18, fontWeight: 'bold', color: isDark ? '#fff' : '#000', marginBottom: 15 },
    channelItem: { padding: 15, borderWidth: 1, borderColor: isDark ? '#4b5563' : '#d1d5db', borderRadius: 8, marginBottom: 10 },
    channelItemSelected: { borderColor: '#3b82f6', backgroundColor: isDark ? '#1e3a8a' : '#eff6ff' },
    channelText: { color: isDark ? '#fff' : '#000' },
    modalActions: { flexDirection: 'row', justifyContent: 'flex-end', marginTop: 20 },
    modalButton: { paddingHorizontal: 20, paddingVertical: 10, borderRadius: 8, marginLeft: 10 },
    cancelButton: { backgroundColor: isDark ? '#4b5563' : '#e5e7eb' },
    cancelButtonText: { color: isDark ? '#fff' : '#000' },
    confirmButton: { backgroundColor: '#2563eb' },
    confirmButtonText: { color: '#fff' },
});