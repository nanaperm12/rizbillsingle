// FIX: Import `useMemo` from React to resolve 'Cannot find name' error.
import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, useColorScheme, ScrollView, TouchableOpacity, ActivityIndicator, TextInput, Alert, Platform } from 'react-native';
import { Customer, Invoice, Package, AcsDeviceDetails, formatRupiah } from '../../types';
import { RxPowerDisplay } from './shared/RxPowerDisplay';
import { Ionicons } from '@expo/vector-icons';
import { apiFetch } from '../../api/api';
// Import AdMob
import { BannerAd, BannerAdSize } from 'react-native-google-mobile-ads';

// Ganti ID pengujian di bawah ini dengan ID unit iklan spanduk ASLI Anda saat siap untuk produksi
// JANGAN gunakan ID asli Anda selama pengembangan untuk menghindari penangguhan akun.
const bannerAdUnitID = Platform.select({
  // https://developers.google.com/admob/ios/test-ads
  ios: "ca-app-pub-3940256099942544/2934735716",
  // https://developers.google.com/admob/android/test-ads
  android: "ca-app-pub-3940256099942544/6300978111",
});


interface CustomerHomeProps {
    navigation: any;
    customer: Customer;
    unpaidInvoices: Invoice[];
    customerPackage: Package | null;
    deviceDetails: AcsDeviceDetails | null;
    onRefreshDevice: () => Promise<void>;
    isRefreshingDevice: boolean;
    onRebootDevice: () => Promise<void>;
    onSaveWlan: (wlanFormData: { ssid: string; key: string }) => Promise<any>;
    isDeviceLoading: boolean;
    deviceError: string | null;
}

// Live Speed Monitor Component for React Native
const LiveSpeedMonitor: React.FC<{ customer: Customer }> = ({ customer }) => {
    const [liveTraffic, setLiveTraffic] = useState({ rx: 0, tx: 0 });
    const [error, setError] = useState<string | null>(null);
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);

    useEffect(() => {
        if (!customer.id || !customer.pppoeUsername) return;

        const fetchTraffic = async () => {
            try {
                const res = await apiFetch(`/customers/${customer.id}/live-traffic`);
                const data = await res.json();
                
                if (data.error && !error) {
                    setError(data.error);
                } else if (!data.error) {
                    setError(null);
                }
                setLiveTraffic({ rx: data.rx || 0, tx: data.tx || 0 });
            } catch (err: any) {
                if (!error) setError(err.message || 'Could not connect to monitor.');
            }
        };

        const intervalId = setInterval(fetchTraffic, 3000);
        fetchTraffic();

        return () => clearInterval(intervalId);
    }, [customer.id, customer.pppoeUsername, error]);

    const formatBits = (bits: number) => {
        if (bits < 1000) return `${bits.toFixed(0)} bps`;
        if (bits < 1000000) return `${(bits / 1000).toFixed(1)} Kbps`;
        return `${(bits / 1000000).toFixed(2)} Mbps`;
    };

    if (error) {
        return <Text style={styles.errorTextSmall}>{error}</Text>;
    }

    return (
        <View>
            <View style={styles.speedRow}>
                <Ionicons name="arrow-down-circle-outline" size={18} color="#ef4444" />
                <Text style={[styles.speedText, { color: '#ef4444' }]}>{formatBits(liveTraffic.tx)}</Text>
            </View>
            <View style={styles.speedRow}>
                <Ionicons name="arrow-up-circle-outline" size={18} color="#3b82f6" />
                <Text style={[styles.speedText, { color: '#3b82f6' }]}>{formatBits(liveTraffic.rx)}</Text>
            </View>
        </View>
    );
};


export default function CustomerHomeScreen({
    navigation,
    customer,
    unpaidInvoices,
    customerPackage,
    deviceDetails,
    onRefreshDevice,
    isRefreshingDevice,
    onRebootDevice,
    onSaveWlan,
    isDeviceLoading,
    deviceError,
}: CustomerHomeProps) {
    const isDark = useColorScheme() === 'dark';
    const styles = getStyles(isDark);

    const [isRebooting, setIsRebooting] = useState(false);
    const [isSavingWlan, setIsSavingWlan] = useState(false);
    const [isEditingWlan, setIsEditingWlan] = useState(false);
    const [wlanForm, setWlanForm] = useState({ ssid: '', key: '' });
    const [isDeviceListVisible, setIsDeviceListVisible] = useState(false);
    
    // Filter to only show SSID 1 (2.4G) and 5 (5.8G) to the customer
    const wlanConfigs = useMemo(() => {
        return deviceDetails?.wlanConfigs?.filter(config => 
            /\.[15]\.SSID$/.test(config.ssidPath)
        ) || [];
    }, [deviceDetails]);
    
    // Combine devices from all available WLAN configs (2.4GHz and 5GHz)
    const allAssociatedDevices = useMemo(() => {
        if (!wlanConfigs || wlanConfigs.length === 0) {
            return [];
        }
        const allDevices = wlanConfigs.flatMap(config => config.associatedDevices || []);
        const uniqueDevices = Array.from(new Map(allDevices.map(device => [device.mac, device])).values());
        return uniqueDevices;
    }, [wlanConfigs]);


    useEffect(() => {
        if (wlanConfigs.length > 0) {
            const ssid1 = wlanConfigs.find(c => c.ssidPath.endsWith('.1.SSID'));
            const initialConfig = ssid1 || wlanConfigs[0];
            setWlanForm({
                ssid: initialConfig.ssid,
                key: initialConfig.key,
            });
        }
    }, [wlanConfigs]);

    const handleReboot = async () => {
        setIsRebooting(true);
        await onRebootDevice();
        setIsRebooting(false);
    };

    const handleWlanSave = async () => {
        setIsSavingWlan(true);
        const result = await onSaveWlan(wlanForm);
        if (result?.success) {
            setIsEditingWlan(false);
        }
        setIsSavingWlan(false);
    };

    const totalUnpaid = unpaidInvoices.reduce((sum, inv) => sum + inv.amount, 0);

    const renderDeviceManagement = () => {
        if (!customer.acsSerialNumber) {
            return <Text style={styles.deviceInfoText}>No device is linked to your account.</Text>;
        }
        if (isDeviceLoading && !deviceDetails) {
            return (
                <View style={{ alignItems: 'center', padding: 20 }}>
                    <ActivityIndicator color={isDark ? '#fff' : '#000'} />
                    <Text style={styles.deviceInfoText}>Loading device status...</Text>
                </View>
            );
        }
        if (deviceError) {
            return <Text style={styles.errorText}>{deviceError}</Text>;
        }
        if (!deviceDetails) {
            return <Text style={styles.deviceInfoText}>Could not retrieve device information.</Text>;
        }

        return (
            <View style={styles.deviceSection}>
                <View style={styles.deviceInfoGrid}>
                    <View style={styles.deviceInfoItem}>
                        <Text style={styles.deviceInfoLabel}>Device Status</Text>
                        <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                             <View style={[styles.statusIndicator, { backgroundColor: deviceDetails.isOnline ? '#22c55e' : '#ef4444' }]} />
                             <Text style={[styles.deviceInfoValue, { color: deviceDetails.isOnline ? '#22c55e' : '#ef4444' }]}>
                                {deviceDetails.isOnline ? 'Online' : 'Offline'}
                            </Text>
                        </View>
                    </View>
                     <View style={styles.deviceInfoItem}>
                        <Text style={styles.deviceInfoLabel}>Model</Text>
                        <Text style={styles.deviceInfoValue}>{deviceDetails.model}</Text>
                    </View>
                     <View style={styles.deviceInfoItem}>
                        <Text style={styles.deviceInfoLabel}>Optical Power (RX)</Text>
                        <RxPowerDisplay rxPower={deviceDetails.rxPower} />
                    </View>
                </View>

                {wlanConfigs.length > 0 && (
                    <View style={styles.wlanSection}>
                         {isEditingWlan ? (
                            <View>
                                <Text style={styles.sectionSubtitle}>Edit Wi-Fi Settings</Text>
                                <Text style={styles.editHelpText}>Perubahan ini akan diterapkan ke semua jaringan Wi-Fi Anda (2.4GHz & 5GHz).</Text>
                                <TextInput style={styles.input} value={wlanForm.ssid} onChangeText={ssid => setWlanForm({...wlanForm, ssid})} placeholder="Wi-Fi Name (SSID)" placeholderTextColor={isDark ? '#9ca3af' : '#6b7280'} />
                                <TextInput style={styles.input} value={wlanForm.key} onChangeText={key => setWlanForm({...wlanForm, key})} placeholder="Wi-Fi Password" placeholderTextColor={isDark ? '#9ca3af' : '#6b7280'} />
                                <View style={{flexDirection: 'row', marginTop: 10}}>
                                    <TouchableOpacity onPress={handleWlanSave} disabled={isSavingWlan} style={[styles.deviceButton, styles.saveButton]}>
                                        {isSavingWlan ? <ActivityIndicator color="#fff" /> : <Text style={styles.deviceButtonText}>Simpan</Text>}
                                    </TouchableOpacity>
                                    <TouchableOpacity onPress={() => setIsEditingWlan(false)} style={[styles.deviceButton, styles.cancelButton]}>
                                        <Text style={styles.cancelButtonText}>Batal</Text>
                                    </TouchableOpacity>
                                </View>
                            </View>
                        ) : (
                            <View>
                                <View style={{flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center'}}>
                                    <Text style={styles.sectionSubtitle}>Wi-Fi Settings</Text>
                                    <TouchableOpacity onPress={() => setIsEditingWlan(true)}>
                                        <Text style={styles.editButtonText}>Ubah</Text>
                                    </TouchableOpacity>
                                </View>
                                {wlanConfigs.map((config, index) => (
                                    <View key={index} style={styles.wlanDisplayItem}>
                                        <View style={styles.deviceInfoItemFull}>
                                            <Text style={styles.deviceInfoLabel}>
                                                {/\.1\.SSID$/.test(config.ssidPath) ? 'Wi-Fi 2.4G' : /\.5\.SSID$/.test(config.ssidPath) ? 'Wi-Fi 5G' : `Wi-Fi #${index + 1}`}
                                            </Text>
                                            <Text style={styles.deviceInfoValue}>{config.ssid}</Text>
                                        </View>
                                        <View style={styles.deviceInfoItemFull}>
                                            <Text style={styles.deviceInfoLabel}>Wi-Fi Password</Text>
                                            <Text style={[styles.deviceInfoValue, { fontFamily: Platform.OS === 'ios' ? 'Courier New' : 'monospace' }]}>{config.key}</Text>
                                        </View>
                                    </View>
                                ))}
                            </View>
                        )}
                    </View>
                )}
                
                {allAssociatedDevices && allAssociatedDevices.length > 0 && (
                     <View style={styles.wlanSection}>
                        <View style={{flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center'}}>
                            <Text style={styles.sectionSubtitle}>
                                Perangkat Terhubung ({allAssociatedDevices.length})
                            </Text>
                            <TouchableOpacity onPress={() => setIsDeviceListVisible(!isDeviceListVisible)}>
                                <Text style={styles.editButtonText}>
                                    {isDeviceListVisible ? 'Tutup' : 'Lihat'}
                                </Text>
                            </TouchableOpacity>
                        </View>
                        {isDeviceListVisible && (
                            <View style={{marginTop: 8}}>
                                {allAssociatedDevices.map(dev => (
                                    <View key={dev.mac} style={styles.deviceListItem}>
                                        <View>
                                            <Text style={styles.deviceHostname}>{dev.hostname}</Text>
                                            <Text style={styles.deviceMac}>{dev.mac}</Text>
                                        </View>
                                        <View style={{alignItems: 'flex-end'}}>
                                            <Text style={styles.deviceSignal}>Signal: {dev.signal} dBm</Text>
                                            <Text style={styles.deviceIp}>{dev.ip}</Text>
                                        </View>
                                    </View>
                                ))}
                            </View>
                        )}
                    </View>
                )}
                
                <View style={styles.deviceActions}>
                    <TouchableOpacity onPress={handleReboot} disabled={isRebooting || !deviceDetails.isOnline} style={[styles.deviceButton, styles.rebootButton]}>
                         {isRebooting ? <ActivityIndicator color="#fff" /> : <Text style={styles.deviceButtonText}>Reboot Device</Text>}
                    </TouchableOpacity>
                     <TouchableOpacity onPress={onRefreshDevice} disabled={isRebooting || isRefreshingDevice} style={[styles.deviceButton, styles.refreshButton]}>
                        {isRefreshingDevice 
                            ? <ActivityIndicator color={isDark ? '#d1d5db' : '#374151'} /> 
                            : <Text style={styles.refreshButtonText}>Refresh</Text>}
                    </TouchableOpacity>
                </View>
            </View>
        );
    };

    return (
        <View style={styles.rootContainer}>
            <ScrollView style={styles.container} contentContainerStyle={styles.contentContainer}>
                <Text style={styles.title}>Welcome, {customer.name.split(' ')[0]}!</Text>
                
                {totalUnpaid > 0 && (
                    <View style={styles.unpaidCard}>
                        <View>
                            <Text style={styles.unpaidTitle}>You have unpaid bills</Text>
                            <Text style={styles.unpaidAmount}>{formatRupiah(totalUnpaid)}</Text>
                        </View>
                        <TouchableOpacity onPress={() => navigation.navigate('Bills')} style={styles.payButton}>
                            <Text style={styles.payButtonText}>View & Pay</Text>
                        </TouchableOpacity>
                    </View>
                )}

                <View style={styles.card}>
                    <Text style={styles.cardTitle}>Paket & Status Layanan</Text>
                    <View style={styles.serviceStatusContainer}>
                        <View>
                            {customerPackage ? (
                                <>
                                    <Text style={styles.packageName}>{customerPackage.name}</Text>
                                    <Text style={styles.packageSpeed}>{customerPackage.speed} Mbps</Text>
                                    <Text style={styles.packagePrice}>{formatRupiah(customerPackage.price)} / month</Text>
                                </>
                            ) : <Text style={styles.deviceInfoText}>Package not found.</Text>}
                        </View>
                        {customer.pppoeUsername && <LiveSpeedMonitor customer={customer} />}
                    </View>
                </View>

                <View style={styles.card}>
                    <Text style={styles.cardTitle}>Device Management</Text>
                    {renderDeviceManagement()}
                </View>
            </ScrollView>
             {/* Ad Banner */}
            {/* <View style={styles.adContainer}>
                {bannerAdUnitID && (
                    <BannerAd
                        unitId={bannerAdUnitID}
                        size={BannerAdSize.ADAPTIVE_BANNER}
                        onAdLoaded={() => {
                          console.log('AdMob: Adaptive Banner Ad loaded successfully.');
                        }}
                        onAdFailedToLoad={(error) => {
                          console.error('AdMob: Adaptive Banner Ad failed to load. Error:', error);
                        }}
                    />
                )}
            </View> */}
        </View>
    );
}

const getStyles = (isDark: boolean) => StyleSheet.create({
    rootContainer: {
        flex: 1,
        backgroundColor: isDark ? '#111827' : '#f7f3f6ff',
    },
    container: {
        flex: 1,
    },
    contentContainer: {
        padding: 20,
        paddingBottom: 70, 
    },
    adContainer: {
        position: 'absolute',
        bottom: 0,
        left: 0,
        right: 0,
        alignItems: 'center',
        backgroundColor: isDark ? '#1f2937' : '#fff',
        borderTopWidth: 1,
        borderTopColor: isDark ? '#374151' : '#e5e7eb',
        minHeight: 50, // Ensure container has height
    },
    title: {
        fontSize: 28,
        fontWeight: 'bold',
        color: isDark ? '#f9fafb' : '#d4c7c1ff',
        marginBottom: 24,
    },
    card: {
        backgroundColor: isDark ? '#1f2937' : '#e2d6c8ff',
        borderRadius: 12,
        padding: 16,
        marginBottom: 16,
    },
    cardTitle: {
        fontSize: 18,
        fontWeight: '600',
        color: isDark ? '#e5e7eb' : '#374151',
        marginBottom: 12,
    },
    unpaidCard: {
        backgroundColor: isDark ? 'rgba(252, 211, 77, 0.1)' : '#fefce8',
        borderRadius: 12,
        padding: 16,
        marginBottom: 16,
        borderLeftWidth: 4,
        borderLeftColor: '#f59e0b',
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    unpaidTitle: {
        fontWeight: '600',
        color: isDark ? '#fcd34d' : '#ca8a04',
    },
    unpaidAmount: {
        fontSize: 24,
        fontWeight: 'bold',
        color: isDark ? '#fef08a' : '#a16207',
    },
    payButton: {
        backgroundColor: '#f59e0b',
        paddingHorizontal: 16,
        paddingVertical: 10,
        borderRadius: 8,
    },
    payButtonText: {
        color: '#fff',
        fontWeight: '600',
    },
    serviceStatusContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    packageName: {
        fontSize: 22,
        fontWeight: 'bold',
        color: isDark ? '#60a5fa' : '#2563eb',
    },
    packageSpeed: {
        fontSize: 18,
        fontWeight: '600',
        color: isDark ? '#d1d5db' : '#128021ff',
    },
    packagePrice: {
        fontSize: 14,
        color: isDark ? '#9ca3af' : '#0fad0fff',
    },
    deviceSection: {
        marginTop: 10,
    },
    deviceInfoGrid: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        gap: 16,
    },
    deviceInfoItem: {
        flexBasis: '45%',
    },
    deviceInfoItemFull: {
        flexBasis: '100%',
    },
    deviceInfoLabel: {
        fontSize: 12,
        color: isDark ? '#9ca3af' : '#807c6bff',
    },
    deviceInfoValue: {
        fontSize: 14,
        fontWeight: '600',
        color: isDark ? '#f9fafb' : '#1fad0dff',
    },
    statusIndicator: {
        width: 10,
        height: 10,
        borderRadius: 5,
        marginRight: 8,
    },
    wlanSection: {
        marginTop: 16,
        paddingTop: 16,
        borderTopWidth: 1,
        borderTopColor: isDark ? '#374151' : '#ecbb1aff',
    },
    sectionSubtitle: {
        fontSize: 16,
        fontWeight: '600',
        color: isDark ? '#e5e7eb' : '#374151',
        marginBottom: 8,
    },
    editHelpText: {
        fontSize: 12,
        color: isDark ? '#9ca3af' : '#6b7280',
        marginBottom: 12,
    },
    wlanDisplayItem: {
        backgroundColor: isDark ? '#374151' : '#d3c897ff',
        padding: 12,
        borderRadius: 8,
        marginBottom: 10,
    },
    input: {
        backgroundColor: isDark ? '#374151' : '#d3c897ff',
        borderColor: isDark ? '#4b5563' : '#d3c897ff',
        borderWidth: 1,
        borderRadius: 8,
        padding: 10,
        color: isDark ? '#fff' : '#000',
        marginBottom: 10,
    },
    editButtonText: {
        fontSize: 12,
        color: '#ac0dd4ff',
        fontWeight: '600',
    },
  
    deviceActions: {
        marginTop: 16,
        paddingTop: 16,
        borderTopWidth: 1,
        borderTopColor: isDark ? '#374151' : '#e5e7eb',
        flexDirection: 'row',
        gap: 10,
    },
    deviceButton: {
        paddingVertical: 10,
        paddingHorizontal: 15,
        borderRadius: 8,
        justifyContent: 'center',
        alignItems: 'center',
        minWidth: 80,
    },
    deviceButtonText: {
        color: '#fff',
        fontWeight: '600',
    },
    rebootButton: {
        backgroundColor: '#4126dcff',
    },
    saveButton: {
        backgroundColor: '#2563eb',
    },
    cancelButton: {
        backgroundColor: isDark ? '#4b5563' : '#dc2626',
    },
    cancelButtonText: {
        color: isDark ? '#fff' : '#fff',
        fontWeight: '600',
    },
    refreshButton: {
        borderWidth: 1,
        borderColor: isDark ? '#4b5563' : '#4b5563',
        backgroundColor: isDark ? '#4b5563' : '#e9be61ff',
    },
    refreshButtonText: {
        color: isDark ? '#d1d5db' : '#374151',
        fontWeight: '600',
    },
    deviceInfoText: {
        fontSize: 14,
        color: isDark ? '#9ca3af' : '#6b7280',
    },
    errorText: {
        fontSize: 14,
        color: '#ef4444',
        textAlign: 'center',
        padding: 10,
    },
    speedRow: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'flex-end',
        gap: 8,
    },
    speedText: {
        fontSize: 16,
        fontWeight: '600',
        minWidth: 90,
        textAlign: 'left',
    },
    errorTextSmall: {
        fontSize: 12,
        color: '#ef4444',
        textAlign: 'right',
    },
    deviceListItem: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        backgroundColor: isDark ? '#374151' : '#7e065aff',
        padding: 12,
        borderRadius: 8,
        marginBottom: 8,
    },
    deviceHostname: {
        fontWeight: '600',
        color: isDark ? '#f9fafb' : '#eef0f3ff',
    },
    deviceMac: {
        fontSize: 12,
        color: isDark ? '#9ca3af' : '#f2f4f7ff',
        fontFamily: Platform.OS === 'ios' ? 'Courier New' : 'monospace',
    },
    deviceSignal: {
        fontSize: 12,
        color: isDark ? '#d1d5db' : '#7b7d80ff',
    },
    deviceIp: {
        fontSize: 12,
        color: isDark ? '#9ca3af' : '#eeeef0ff',
        fontFamily: Platform.OS === 'ios' ? 'Courier New' : 'monospace',
    },
});