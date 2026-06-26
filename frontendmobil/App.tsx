import React, { useCallback } from 'react';
import { StatusBar } from 'expo-status-bar';
import { NavigationContainer } from '@react-navigation/native';
import AppNavigator from './navigation/AppNavigator';
import { useColorScheme, View, StyleSheet } from 'react-native';
import { useFonts } from 'expo-font';
import { Ionicons } from '@expo/vector-icons';
import * as SplashScreen from 'expo-splash-screen';

// Menjaga layar splash tetap terlihat saat kita mengambil sumber daya
SplashScreen.preventAutoHideAsync();

export default function App() {
  const colorScheme = useColorScheme();

  const [fontsLoaded, fontError] = useFonts({
    ...Ionicons.font,
  });

  const onLayoutRootView = useCallback(async () => {
    if (fontsLoaded || fontError) {
      // Ini akan menyembunyikan layar splash dan menampilkan layout aplikasi.
      await SplashScreen.hideAsync();
    }
  }, [fontsLoaded, fontError]);

  // Jika font belum dimuat dan tidak ada error, jangan render apa pun.
  // Layar splash akan tetap terlihat.
  if (!fontsLoaded && !fontError) {
    return null;
  }

  // Praktik yang baik untuk mencatat error jika pemuatan font gagal
  if (fontError) {
    console.error("Font loading error:", fontError);
  }

  return (
    // Prop onLayout memastikan kita hanya menyembunyikan layar splash setelah View ini selesai di-layout.
    <View style={styles.container} onLayout={onLayoutRootView}>
      <NavigationContainer>
        <AppNavigator />
        <StatusBar style={colorScheme === 'dark' ? 'light' : 'dark'} />
      </NavigationContainer>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});