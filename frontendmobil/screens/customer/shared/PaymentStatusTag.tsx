import React from 'react';
import { View, Text, StyleSheet, useColorScheme } from 'react-native';
import { PaymentStatus } from '~/types';

interface Props {
    status: PaymentStatus;
}

export const PaymentStatusTag: React.FC<Props> = ({ status }) => {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);
    
    const statusStyle = {
        [PaymentStatus.Paid]: styles.paidTag,
        [PaymentStatus.Unpaid]: styles.unpaidTag,
        [PaymentStatus.Overdue]: styles.overdueTag,
    };
    
    const textStyle = {
        [PaymentStatus.Paid]: styles.paidText,
        [PaymentStatus.Unpaid]: styles.unpaidText,
        [PaymentStatus.Overdue]: styles.overdueText,
    };

    return (
        <View style={[styles.tag, statusStyle[status]]}>
            <Text style={[styles.tagText, textStyle[status]]}>{status}</Text>
        </View>
    );
};

const getStyles = (isDark: boolean) => StyleSheet.create({
    tag: {
        paddingHorizontal: 10,
        paddingVertical: 4,
        borderRadius: 999,
    },
    tagText: {
        fontSize: 12,
        fontWeight: '500',
    },
    paidTag: { backgroundColor: isDark ? 'rgba(22, 163, 74, 0.2)' : '#dcfce7' },
    paidText: { color: isDark ? '#4ade80' : '#166534' },
    unpaidTag: { backgroundColor: isDark ? 'rgba(234, 179, 8, 0.2)' : '#fef9c3' },
    unpaidText: { color: isDark ? '#facc15' : '#854d0e' },
    overdueTag: { backgroundColor: isDark ? 'rgba(220, 38, 38, 0.2)' : '#fee2e2' },
    overdueText: { color: isDark ? '#f87171' : '#991b1b' },
});
