import React, { useState, useEffect, useCallback } from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { Ionicons } from '@expo/vector-icons';
// FIX: Import 'ActivityIndicator' from 'react-native' to resolve the error.
import { useColorScheme, View, Text, StyleSheet, Alert, ActivityIndicator } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import AsyncStorage from '@react-native-async-storage/async-storage';

import CustomerLoginScreen from '../screens/CustomerLoginScreen';
import CustomerHomeScreen from '../screens/customer/CustomerHomeScreen';
import CustomerBillsScreen from '../screens/customer/CustomerBillsScreen';
import CustomerHelpScreen from '../screens/customer/CustomerHelpScreen';
import CustomerProfileScreen from '../screens/customer/CustomerProfileScreen';
import PaymentWebViewScreen from '../screens/customer/PaymentWebViewScreen';
import SplashScreenComponent from '../screens/SplashScreen'; // Impor splash screen baru
import { Customer, Invoice, Package, Complaint, AcsDeviceDetails, ComplaintType, ComplaintReply, ApiSettings, PackageChange } from '../types';
import { apiFetch } from '../api/api';

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

const SESSION_KEY = '@rizkitechbill_session';
const APP_SETTINGS_KEY = '@appSettings';
const SESSION_DURATION = 7 * 24 * 60 * 60 * 1000; // 7 hari

// Helper function to decode JWT payload
function decodeJwt(token: string) {
  try {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    // Add padding to handle base64 strings of any length, which resolves potential 'atob' errors.
    const paddedBase64 = base64 + '=='.substring(0, (4 - base64.length % 4) % 4);
    const jsonPayload = decodeURIComponent(atob(paddedBase64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    return JSON.parse(jsonPayload);
  } catch (e) {
    console.error("Failed to decode JWT:", e);
    return null;
  }
}

type TabBarIconProps = {
  focused: boolean;
  color: string;
  size: number;
};

// Antarmuka untuk aset yang dipilih oleh image picker
interface ImagePickerAsset {
    uri: string;
    fileName?: string | null;
    type?: string;
}

// Komponen ini sekarang menjadi wadah data untuk seluruh portal pelanggan
function MainAppTabs({ navigation, customer, onLogout, onProfileUpdate }: { navigation: any, customer: Customer, onLogout: () => void, onProfileUpdate: (token: string) => void }) {
    const colorScheme = useColorScheme();
    const isDark = colorScheme === 'dark';

    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [invoices, setInvoices] = useState<Invoice[]>([]);
    const [complaints, setComplaints] = useState<Complaint[]>([]);
    const [customerPackage, setCustomerPackage] = useState<Package | null>(null);
    const [allPackages, setAllPackages] = useState<Package[]>([]);
    const [pendingChange, setPendingChange] = useState<PackageChange | null>(null);
    const [deviceDetails, setDeviceDetails] = useState<AcsDeviceDetails | null>(null);
    const [isRefreshing, setIsRefreshing] = useState(false);
    const [isRefreshingDevice, setIsRefreshingDevice] = useState(false);

    const fetchData = useCallback(async () => {
        setError(null);
        try {
            const results = await Promise.allSettled([
                apiFetch(`/billing/invoices?customerId=${customer.id}`),
                apiFetch(`/customers/complaints?customerId=${customer.id}`),
                apiFetch(`/network/packages`),
                apiFetch(`/customers/${customer.id}/package-change`),
                customer.acsSerialNumber ? apiFetch(`/acs/customer-device?customerId=${customer.id}`) : Promise.resolve(null),
            ]);

            const [invoicesResult, complaintsResult, packagesResult, pendingChangeResult, deviceResult] = results;
            const errorMessages: string[] = [];

            // Process invoices
            if (invoicesResult.status === 'fulfilled') {
                const allInvoices: Invoice[] = await invoicesResult.value.json();
                setInvoices(allInvoices.sort((a, b) => new Date(b.issueDate).getTime() - new Date(a.issueDate).getTime()));
            } else {
                errorMessages.push('Failed to load invoices.');
                console.error('Invoice fetch failed:', invoicesResult.reason);
            }

            // Process complaints
            if (complaintsResult.status === 'fulfilled') {
                const allComplaints: Complaint[] = await complaintsResult.value.json();
                setComplaints(allComplaints.sort((a, b) => new Date(b.dateSubmitted).getTime() - new Date(a.dateSubmitted).getTime()));
            } else {
                errorMessages.push('Failed to load complaints.');
                console.error('Complaint fetch failed:', complaintsResult.reason);
            }
            
            // Process packages
            if (packagesResult.status === 'fulfilled') {
                const allPkgs: Package[] = await packagesResult.value.json();
                setAllPackages(allPkgs);
                setCustomerPackage(allPkgs.find(p => p.id === customer.packageId) || null);
            } else {
                errorMessages.push('Failed to load package details.');
                console.error('Package fetch failed:', packagesResult.reason);
            }
            
            // Process pending change
            if (pendingChangeResult.status === 'fulfilled') {
                setPendingChange(await pendingChangeResult.value.json());
            } else {
                 console.error('Pending change fetch failed:', pendingChangeResult.reason);
            }


            // Process device details
            if (deviceResult.status === 'fulfilled' && deviceResult.value) {
                const deviceRes = deviceResult.value;
                if (deviceRes.ok) {
                    setDeviceDetails(await deviceRes.json());
                }
            } else if (deviceResult.status === 'rejected') {
                errorMessages.push('Failed to load device status.');
                console.error('Device fetch failed:', deviceResult.reason);
                setDeviceDetails(null);
            }

            if (errorMessages.length > 0) {
                setError(errorMessages.join(' \n '));
            }

        } catch (e: any) {
            setError('An unexpected critical error occurred.');
            console.error('Fallback fetchData catch:', e);
        } finally {
            if (isLoading) {
                setIsLoading(false);
            }
        }
    }, [customer.id, customer.packageId, customer.acsSerialNumber, isLoading]);


    // Gunakan useFocusEffect untuk mengambil data setiap kali layar ini menjadi fokus
    // Ini akan secara otomatis me-refresh data setelah kembali dari modal pembayaran
    useFocusEffect(
        useCallback(() => {
            fetchData();
        }, [fetchData])
    );
    
    const handleRefresh = useCallback(async () => {
        setIsRefreshing(true);
        await fetchData();
        setIsRefreshing(false);
    }, [fetchData]);

    const handleRefreshDeviceData = useCallback(async () => {
        if (!customer.acsSerialNumber) {
            await handleRefresh(); // Fallback to normal refresh
            return;
        }
        
        setIsRefreshingDevice(true);
        setError(null);
    
        try {
            // Step 1: Summon the device
            const res = await apiFetch(`/acs/customer-device/summon`, {
                method: 'POST',
                body: JSON.stringify({ customerId: customer.id }),
            });
            const summonData = await res.json();
            if (!res.ok) throw new Error(summonData.message || 'Failed to send refresh command.');
    
            Alert.alert(
                "Proses Pengambilan Data",
                "Permintaan pengambilan data sedang di proses, tunggu beberapa saat."
            );
            
            // Step 2: Wait for device to report back to ACS
            await new Promise(resolve => setTimeout(resolve, 10000));
    
            // Step 3: Fetch fresh data.
            await fetchData(); 
    
        } catch (error: any) {
            Alert.alert('Error', `Failed to refresh device status: ${error.message}`);
        } finally {
            setIsRefreshingDevice(false);
        }
    }, [customer, fetchData, handleRefresh]);


    const handleAction = async (action: () => Promise<any>, successMessage: string, errorMessage: string) => {
        try {
            const result = await action();
            Alert.alert('Success', successMessage);
            await fetchData(); // Refresh semua data
            return result;
        } catch (e: any) {
            Alert.alert('Error', `${errorMessage}: ${e.message}`);
        }
    };
    
    const handleRebootDevice = () => handleAction(
        async () => {
            const res = await apiFetch(`/acs/customer-device/reboot`, { method: 'POST', body: JSON.stringify({ customerId: customer.id }) });
            return res.json();
        },
        'Reboot command sent successfully. The device will restart shortly.',
        'Failed to reboot device'
    );

    const handleSaveWlan = (wlanFormData: { ssid: string; key: string; }) => handleAction(
        async () => {
            const res = await apiFetch(`/acs/customer-device/update-wlan`, { 
                method: 'POST', 
                body: JSON.stringify({ 
                    customerId: customer.id, 
                    ssid: wlanFormData.ssid, 
                    key: wlanFormData.key 
                }) 
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.message);
            return { success: true };
        },
        'Wi-Fi settings saved. Changes will apply to all your networks (2.4GHz & 5GHz).',
        'Failed to save Wi-Fi settings'
    );
    
    const handleSaveComplaint = (complaintData: { type: ComplaintType; description: string; photo?: ImagePickerAsset | null }) => handleAction(
        async () => {
            const formData = new FormData();
            formData.append('customerId', customer.id);
            formData.append('type', complaintData.type);
            formData.append('description', complaintData.description);
            
            if (complaintData.photo) {
                const uri = complaintData.photo.uri;
                const filename = complaintData.photo.fileName || uri.split('/').pop() || `complaint_${Date.now()}.jpg`;
                let mimeType = complaintData.photo.type;
                if (!mimeType) {
                    const ext = filename.split('.').pop()?.toLowerCase();
                    if (ext === 'jpg' || ext === 'jpeg') mimeType = 'image/jpeg';
                    else if (ext === 'png') mimeType = 'image/png';
                    else mimeType = 'application/octet-stream';
                }
                
                const photoData = { uri, name: filename, type: mimeType };
                formData.append('photo', photoData as any);
            }

            const res = await apiFetch(`/customers/complaints`, { method: 'POST', body: formData });
            const data = await res.json();
            if (!res.ok) throw new Error(data.message);
            return { success: true };
        },
        'Complaint submitted successfully.',
        'Failed to submit complaint'
    );
    
    const handleSendReply = async (complaintId: string, replyText: string, photo?: ImagePickerAsset | null): Promise<{ success: boolean; message?: string; } | undefined> => {
        try {
            const formData = new FormData();
            formData.append('replyText', replyText || '');
            formData.append('repliedBy', customer.name);

            if (photo) {
                const uri = photo.uri;
                const filename = photo.fileName || uri.split('/').pop() || `reply_${Date.now()}.jpg`;
                
                let mimeType = photo.type;
                if (!mimeType || mimeType === 'image') { // Also handle generic 'image' type
                    const fileExtension = filename.split('.').pop()?.toLowerCase();
                    if (fileExtension === 'jpg' || fileExtension === 'jpeg') mimeType = 'image/jpeg';
                    else if (fileExtension === 'png') mimeType = 'image/png';
                    else mimeType = 'application/octet-stream'; // Generic fallback
                }
                
                const photoData = { uri, name: filename, type: mimeType };
                formData.append('photo', photoData as any);
            }

            const res = await apiFetch(`/customers/complaints/${complaintId}/reply`, {
                method: 'POST',
                body: formData,
            });
            
            const newReply: ComplaintReply = await res.json();

            setComplaints(prev => prev.map(c => {
                if (c.id === complaintId) {
                    return { ...c, replies: [...(c.replies || []), newReply] };
                }
                return c;
            }));

            Alert.alert('Success', 'Reply sent successfully.');
            return { success: true };
        } catch (e: any) {
            console.error('Error sending reply:', e);
            Alert.alert('Error', `Failed to send reply: ${e.message}`);
            return { success: false, message: e.message };
        }
    };

    const handleCreatePaymentLink = async (invoiceId: string, method: string) => {
        try {
            const res = await apiFetch(`/billing/invoices/${invoiceId}/create-payment`, {
                method: 'POST',
                body: JSON.stringify({
                    method
                })
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.message);

            if (!data.paymentUrl || !data.returnUrl) {
                throw new Error('Server response is missing necessary URLs for payment.');
            }
            
            navigation.navigate('PaymentWebView', {
                paymentUrl: data.paymentUrl,
                returnUrl: data.returnUrl
            });

        } catch (e: any) {
            Alert.alert(`Failed to create payment link: ${e.message}`);
        }
    };

    if (isLoading) {
        return (
            <View style={styles.centerContainer}>
                <ActivityIndicator size="large" color={isDark ? '#fff' : '#000'} />
                <Text style={{ color: isDark ? '#fff' : '#000', marginTop: 10 }}>Loading your portal...</Text>
            </View>
        );
    }

    return (
        <View style={{ flex: 1, backgroundColor: isDark ? '#111827' : '#f3f4f6' }}>
            {error && (
                <View style={{ padding: 10, backgroundColor: '#cc3333', zIndex: 10 }}>
                    <Text style={{ color: 'white', textAlign: 'center', fontSize: 12 }}>{error}</Text>
                </View>
            )}
            <Tab.Navigator
                id={undefined}
                screenOptions={({ route }) => ({
                    tabBarIcon: ({ focused, color, size }: TabBarIconProps) => {
                        let iconName: keyof typeof Ionicons.glyphMap;
                        if (route.name === 'Home') iconName = focused ? 'home' : 'home-outline';
                        else if (route.name === 'Bills') iconName = focused ? 'receipt' : 'receipt-outline';
                        else if (route.name === 'Help') iconName = focused ? 'help-buoy' : 'help-buoy-outline';
                        else if (route.name === 'Profile') iconName = focused ? 'person-circle' : 'person-circle-outline';
                        else iconName = 'alert-circle';
                        return <Ionicons name={iconName} size={size} color={color} />;
                    },
                    tabBarActiveTintColor: isDark ? '#60a5fa' : '#2563eb',
                    tabBarInactiveTintColor: isDark ? '#9ca3af' : '#6b7280',
                    tabBarStyle: { backgroundColor: isDark ? '#1f2937' : '#fff', borderTopColor: isDark ? '#374151' : '#e5e7eb' },
                    headerStyle: { backgroundColor: isDark ? '#1f2937' : '#fff' },
                    headerTitleStyle: { color: isDark ? '#f9fafb' : '#111827' },
                })}
            >
                <Tab.Screen name="Home">
                    {(props) => <CustomerHomeScreen {...props} 
                        customer={customer} 
                        unpaidInvoices={invoices.filter(inv => inv.status !== 'Paid')}
                        customerPackage={customerPackage}
                        deviceDetails={deviceDetails}
                        onRefreshDevice={handleRefreshDeviceData}
                        isRefreshingDevice={isRefreshingDevice}
                        onRebootDevice={handleRebootDevice}
                        onSaveWlan={handleSaveWlan}
                        isDeviceLoading={isLoading}
                        deviceError={error}
                    />}
                </Tab.Screen>
                <Tab.Screen name="Bills">
                    {(props) => <CustomerBillsScreen {...props} 
                        customer={customer}
                        invoices={invoices}
                        onCreatePaymentLink={handleCreatePaymentLink}
                    />}
                </Tab.Screen>
                <Tab.Screen name="Help">
                     {(props) => <CustomerHelpScreen {...props} 
                        customer={customer}
                        complaints={complaints}
                        onSaveComplaint={handleSaveComplaint}
                        onRefresh={handleRefresh}
                        isRefreshing={isRefreshing}
                        onSendReply={handleSendReply}
                     />}
                </Tab.Screen>
                <Tab.Screen name="Profile">
                     {(props) => <CustomerProfileScreen {...props} 
                        customer={customer} 
                        onLogout={onLogout}
                        customerPackage={customerPackage}
                        allPackages={allPackages}
                        pendingChange={pendingChange}
                        onUpdate={fetchData}
                        onProfileUpdate={onProfileUpdate}
                     />}
                </Tab.Screen>
            </Tab.Navigator>
        </View>
    );
}

const AppStack = createNativeStackNavigator();

export default function AppNavigator() {
    const [loggedInCustomer, setLoggedInCustomer] = useState<Customer | null>(null);
    const [isAppReady, setIsAppReady] = useState(false); // Mengganti isAppLoading
    const [appSettings, setAppSettings] = useState<ApiSettings | null>(null);
    const [dynamicLogoUrl, setDynamicLogoUrl] = useState<string | null>(null);

    useEffect(() => {
        const prepareApp = async () => {
            try {
                // Fetch settings first
                const settingsRes = await apiFetch('/public/settings');
                let settingsData;
                if (settingsRes.ok) {
                    settingsData = await settingsRes.json();
                    setAppSettings(settingsData);
                    setDynamicLogoUrl(settingsData.app.appLogoUrl);
                    await AsyncStorage.setItem(APP_SETTINGS_KEY, JSON.stringify(settingsData));
                } else {
                    const cachedSettings = await AsyncStorage.getItem(APP_SETTINGS_KEY);
                    if (cachedSettings) {
                        settingsData = JSON.parse(cachedSettings);
                        setAppSettings(settingsData);
                        setDynamicLogoUrl(settingsData.app.appLogoUrl);
                    }
                }

                // Then check login status
                const sessionDataJSON = await AsyncStorage.getItem(SESSION_KEY);
                if (sessionDataJSON) {
                    const { token, timestamp } = JSON.parse(sessionDataJSON);
                    if (Date.now() - timestamp < SESSION_DURATION) {
                        const customer = decodeJwt(token);
                        setLoggedInCustomer(customer);
                    } else {
                        await AsyncStorage.removeItem(SESSION_KEY);
                    }
                }
            } catch (e) {
                console.error('Failed to prepare app.', e);
                try {
                    const cachedSettings = await AsyncStorage.getItem(APP_SETTINGS_KEY);
                    if (cachedSettings) {
                       const settingsData = JSON.parse(cachedSettings);
                       setAppSettings(settingsData);
                       setDynamicLogoUrl(settingsData.app.appLogoUrl);
                    }
                } catch (cacheError) {
                    console.error('Failed to load cached settings.', cacheError);
                }
            } finally {
                // Aplikasi siap untuk ditampilkan setelah semua data dimuat
                setIsAppReady(true);
            }
        };
        prepareApp();
    }, []);
    
    const handleLoginSuccess = async (customer: Customer, token: string) => {
        try {
            const sessionData = { token, timestamp: Date.now() };
            await AsyncStorage.setItem(SESSION_KEY, JSON.stringify(sessionData));
            setLoggedInCustomer(customer);
        } catch (e) {
            console.error('Failed to save session.', e);
            Alert.alert('Error', 'Failed to save login session. You may need to log in again next time.');
        }
    };

    const handleProfileUpdate = async (token: string) => {
        try {
            const sessionData = { token, timestamp: Date.now() };
            await AsyncStorage.setItem(SESSION_KEY, JSON.stringify(sessionData));
            const newCustomerData = decodeJwt(token);
            if(newCustomerData) {
                setLoggedInCustomer(newCustomerData);
            }
        } catch (e) {
            console.error('Failed to update session after profile change.', e);
        }
    };
    
    const handleLogout = async () => {
        try {
            await AsyncStorage.removeItem(SESSION_KEY);
            setLoggedInCustomer(null);
        } catch (e) {
            console.error('Failed to clear session.', e);
        }
    };

    if (!isAppReady) {
        return <SplashScreenComponent logoUrl={dynamicLogoUrl} />;
    }

    return (
        <AppStack.Navigator
            id={undefined}
        >
            {loggedInCustomer ? (
                <>
                    <AppStack.Screen name="MainApp" options={{ headerShown: false }}>
                        {(props) => (
                            <MainAppTabs
                                {...props}
                                customer={loggedInCustomer as Customer} 
                                onLogout={handleLogout}
                                onProfileUpdate={handleProfileUpdate}
                            />
                        )}
                    </AppStack.Screen>
                    <AppStack.Screen
                        name="PaymentWebView"
                        component={PaymentWebViewScreen}
                        options={{
                            presentation: 'modal',
                            title: 'Complete Payment'
                        }}
                    />
                </>
            ) : (
                <AppStack.Screen name="Login" options={{ headerShown: false }}>
                    {(props) => <CustomerLoginScreen {...props} onLoginSuccess={handleLoginSuccess} appSettings={appSettings} />}
                </AppStack.Screen>
            )}
        </AppStack.Navigator>
    );
}

const styles = StyleSheet.create({
    centerContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    }
});