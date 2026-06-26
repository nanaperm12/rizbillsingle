import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, useColorScheme, ActivityIndicator, KeyboardAvoidingView, Platform, SafeAreaView, Image } from 'react-native';
import { Customer, ApiSettings } from '../types';
import { apiFetch } from '../api/api';
import { Ionicons } from '@expo/vector-icons';

interface Props {
    onLoginSuccess: (customer: Customer, token: string) => void;
    appSettings: ApiSettings | null;
}

export default function CustomerLoginScreen({ onLoginSuccess, appSettings }: Props) {
    const [customerId, setCustomerId] = useState('');
    const [otp, setOtp] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState('');
    const [loginStep, setLoginStep] = useState<'enter-id' | 'enter-otp'>('enter-id');
    const colorScheme = useColorScheme();

    const isDark = colorScheme === 'dark';
    const styles = getStyles(isDark);
    
    const logoUrl = appSettings?.app?.appLogoUrl;

    const handleRequestOtp = async () => {
        setError('');
        if (!customerId.trim()) {
            setError('Please enter your Customer ID.');
            return;
        }
        setIsLoading(true);
        try {
            const res = await apiFetch(`/public/login/request-otp`, {
                method: 'POST',
                body: JSON.stringify({ customerId: customerId.trim() }),
            });
            
            const data = await res.json();

            if (data.otpRequired) {
                setLoginStep('enter-otp');
            } else {
                onLoginSuccess(data.customer, data.token);
            }
        } catch (e: any) {
            setError(e.message);
        } finally {
            setIsLoading(false);
        }
    };
    
    const handleVerifyOtp = async () => {
        setError('');
        if (!otp.trim() || otp.length < 6) {
            setError('Please enter the 6-digit OTP.');
            return;
        }
        setIsLoading(true);
        try {
            const res = await apiFetch(`/public/login/verify-otp`, {
                method: 'POST',
                body: JSON.stringify({ customerId: customerId.trim(), otp }),
            });
            
            const data = await res.json();
            if (!data.success) {
                throw new Error(data.message || 'OTP verification failed.');
            }
            onLoginSuccess(data.customer, data.token);
        } catch (e: any) {
            setError(e.message);
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <SafeAreaView style={styles.container}>
            <KeyboardAvoidingView 
                behavior={Platform.OS === "ios" ? "padding" : "height"}
                style={styles.container}
            >
                <View style={styles.innerContainer}>
                    <View style={styles.logoContainer}>
                        {logoUrl ? (
                            <Image
                                source={{ uri: logoUrl }}
                                style={styles.logo}
                            />
                        ) : (
                            <Ionicons name="receipt-outline" size={80} color={isDark ? '#6b7280' : '#9ca3af'} />
                        )}
                    </View>
                    {loginStep === 'enter-id' ? (
                        <>
                            <Text style={styles.title}>{appSettings?.app?.appName || 'Customer Login'}</Text>
                            <TextInput
                                style={styles.input}
                                placeholder="Enter your Customer ID"
                                placeholderTextColor={isDark ? '#9ca3af' : '#6b7280'}
                                value={customerId}
                                onChangeText={setCustomerId}
                                keyboardType="number-pad"
                                autoCapitalize="none"
                                editable={!isLoading}
                            />
                            {error ? <Text style={styles.errorText}>{error}</Text> : null}
                            <TouchableOpacity style={[styles.button, isLoading && styles.buttonDisabled]} onPress={handleRequestOtp} disabled={isLoading}>
                                {isLoading ? <ActivityIndicator color="#fff" /> : <Text style={styles.buttonText}>Continue</Text>}
                            </TouchableOpacity>
                        </>
                    ) : (
                         <>
                            <Text style={styles.title}>Enter OTP</Text>
                            <Text style={styles.subtitle}>An OTP has been sent to your registered WhatsApp number for ID: {customerId}</Text>
                            <TextInput
                                style={[styles.input, styles.otpInput]}
                                placeholder="••••••"
                                placeholderTextColor={isDark ? '#9ca3af' : '#6b7280'}
                                value={otp}
                                onChangeText={setOtp}
                                keyboardType="number-pad"
                                maxLength={6}
                                editable={!isLoading}
                            />
                            {error ? <Text style={styles.errorText}>{error}</Text> : null}
                            <TouchableOpacity style={[styles.button, isLoading && styles.buttonDisabled]} onPress={handleVerifyOtp} disabled={isLoading}>
                                {isLoading ? <ActivityIndicator color="#fff" /> : <Text style={styles.buttonText}>Verify & Login</Text>}
                            </TouchableOpacity>
                             <TouchableOpacity style={styles.backButton} onPress={() => { setLoginStep('enter-id'); setError(''); setOtp(''); }} disabled={isLoading}>
                                <Text style={styles.backButtonText}>Back</Text>
                            </TouchableOpacity>
                        </>
                    )}
                </View>
            </KeyboardAvoidingView>
        </SafeAreaView>
    );
}

const getStyles = (isDark: boolean) => StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: isDark ? '#111827' : '#f9fafb',
    },
    innerContainer: {
        flex: 1,
        justifyContent: 'center',
        paddingHorizontal: 24,
    },
    logoContainer: {
        width: 100,
        height: 100,
        alignSelf: 'center',
        marginBottom: 24,
        justifyContent: 'center',
        alignItems: 'center',
    },
    logo: {
        width: 100,
        height: 100,
        resizeMode: 'contain',
    },
    title: {
        fontSize: 28,
        fontWeight: 'bold',
        color: isDark ? '#f9fafb' : '#111827',
        textAlign: 'center',
        marginBottom: 24,
    },
    subtitle: {
        fontSize: 14,
        color: isDark ? '#d1d5db' : '#4b5563',
        textAlign: 'center',
        marginBottom: 32,
        paddingHorizontal: 20,
    },
    input: {
        height: 50,
        backgroundColor: isDark ? '#374151' : '#fff',
        borderColor: isDark ? '#4b5563' : '#d1d5db',
        borderWidth: 1,
        borderRadius: 8,
        paddingHorizontal: 16,
        fontSize: 16,
        color: isDark ? '#f9fafb' : '#111827',
    },
    otpInput: {
        textAlign: 'center',
        fontSize: 20,
        letterSpacing: 10,
    },
    button: {
        backgroundColor: '#2563eb',
        height: 50,
        borderRadius: 8,
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 16,
    },
    buttonDisabled: {
        backgroundColor: '#60a5fa',
    },
    buttonText: {
        color: '#fff',
        fontSize: 16,
        fontWeight: '600',
    },
    backButton: {
        marginTop: 16,
        alignItems: 'center',
    },
    backButtonText: {
        color: '#2563eb',
        fontSize: 14,
    },
    errorText: {
        color: '#ef4444',
        textAlign: 'center',
        marginTop: 12,
        marginBottom: 4,
    },
});