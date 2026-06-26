import React from 'react';
import { Text, StyleSheet, useColorScheme } from 'react-native';

interface Props {
    rxPower: string;
}

export const RxPowerDisplay: React.FC<Props> = ({ rxPower }) => {
    const isDark = useColorScheme() === 'dark';

    if (rxPower === 'N/A') {
        return <Text style={getStyles(isDark).grayText}>N/A</Text>;
    }
    
    const powerValue = parseFloat(rxPower);
    if (isNaN(powerValue)) {
        return <Text style={getStyles(isDark).grayText}>{rxPower}</Text>;
    }
    
    let style;
    if (powerValue > -25) {
        style = getStyles(isDark).greenText;
    } else if (powerValue >= -28) {
        style = getStyles(isDark).yellowText;
    } else {
        style = getStyles(isDark).redText;
    }
    
    return <Text style={[getStyles(isDark).baseText, style]}>{rxPower}</Text>;
};

const getStyles = (isDark: boolean) => StyleSheet.create({
    baseText: {
        fontWeight: '600',
        fontSize: 14,
    },
    grayText: {
        color: '#9ca3af',
        fontWeight: '600',
        fontSize: 14,
    },
    greenText: {
        color: '#22c55e',
    },
    yellowText: {
        color: '#f59e0b',
    },
    redText: {
        color: '#ef4444',
    },
});