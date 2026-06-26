import React from 'react';
import { View, Text, StyleSheet, useColorScheme } from 'react-native';
import { ComplaintStatus } from '~/types';

interface Props {
    status: ComplaintStatus;
}

export const ComplaintStatusTag: React.FC<Props> = ({ status }) => {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);
    
    const statusStyle = {
        [ComplaintStatus.Pending]: styles.pendingTag,
        [ComplaintStatus.InProgress]: styles.inProgressTag,
        [ComplaintStatus.Resolved]: styles.resolvedTag,
    };
    
    const textStyle = {
        [ComplaintStatus.Pending]: styles.pendingText,
        [ComplaintStatus.InProgress]: styles.inProgressText,
        [ComplaintStatus.Resolved]: styles.resolvedText,
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
    pendingTag: { backgroundColor: isDark ? 'rgba(59, 130, 246, 0.2)' : '#dbeafe' },
    pendingText: { color: isDark ? '#93c5fd' : '#2563eb' },
    inProgressTag: { backgroundColor: isDark ? 'rgba(234, 179, 8, 0.2)' : '#fef9c3' },
    inProgressText: { color: isDark ? '#facc15' : '#854d0e' },
    resolvedTag: { backgroundColor: isDark ? 'rgba(22, 163, 74, 0.2)' : '#dcfce7' },
    resolvedText: { color: isDark ? '#4ade80' : '#166534' },
});
