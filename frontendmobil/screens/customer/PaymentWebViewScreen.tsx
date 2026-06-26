import React from 'react';
import { View, ActivityIndicator, StyleSheet } from 'react-native';
import { WebView } from 'react-native-webview';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';

// Mendefinisikan tipe untuk parameter navigasi
type RootStackParamList = {
  PaymentWebView: {
    paymentUrl: string;
    returnUrl: string;
  };
  // ... definisikan layar lain jika perlu
};

type Props = NativeStackScreenProps<RootStackParamList, 'PaymentWebView'>;

export default function PaymentWebViewScreen({ route, navigation }: Props) {
  const { paymentUrl, returnUrl } = route.params;

  const handleNavigationStateChange = (navState: any) => {
    const { url } = navState;
    if (!url) return;

    // Jika URL saat ini di WebView dimulai dengan returnUrl kita,
    // berarti pembayaran selesai (berhasil atau gagal).
    // Kita tutup WebView dan kembali ke aplikasi.
    if (url.startsWith(returnUrl)) {
      navigation.goBack();
    }
  };

  const renderLoading = () => (
    <View style={styles.loadingContainer}>
      <ActivityIndicator size="large" />
    </View>
  );

  return (
    <WebView
      source={{ uri: paymentUrl }}
      onNavigationStateChange={handleNavigationStateChange}
      startInLoadingState={true}
      renderLoading={renderLoading}
      style={{ flex: 1 }}
    />
  );
}

const styles = StyleSheet.create({
  loadingContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.8)',
  },
});