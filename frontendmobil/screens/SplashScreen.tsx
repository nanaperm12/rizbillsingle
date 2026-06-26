import React from 'react';
import { View, ActivityIndicator, StyleSheet, useColorScheme, Image } from 'react-native';

interface SplashScreenProps {
  logoUrl: string | null;
}

const SplashScreen: React.FC<SplashScreenProps> = ({ logoUrl }) => {
  const isDark = useColorScheme() === 'dark';
  const styles = getStyles(isDark);

  return (
    <View style={styles.container}>
      {logoUrl ? (
        <Image source={{ uri: logoUrl }} style={styles.logo} resizeMode="contain" />
      ) : (
        // Fallback jika logo tidak tersedia
        <View style={styles.logo} />
      )}
      <ActivityIndicator size="large" color={isDark ? '#9ca3af' : '#6b7280'} />
    </View>
  );
};

const getStyles = (isDark: boolean) => StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: isDark ? '#111827' : '#f9fafb',
  },
  logo: {
    width: 120,
    height: 120,
    marginBottom: 40,
  },
});

export default SplashScreen;