import AsyncStorage from '@react-native-async-storage/async-storage';
import { API_BASE_URL } from './config';

const SESSION_KEY = '@rizkitechbill_session';

export const apiFetch = async (endpoint: string, options: RequestInit = {}): Promise<Response> => {
    let token: string | null = null;
    try {
        const sessionDataJSON = await AsyncStorage.getItem(SESSION_KEY);
        if (sessionDataJSON) {
            const { token: storedToken } = JSON.parse(sessionDataJSON);
            token = storedToken;
        }
    } catch (e) {
        console.error("Failed to get token from storage", e);
    }

    let finalHeaders: HeadersInit = {};

    if (options.headers) {
        if (options.headers instanceof Headers) {
            options.headers.forEach((value, key) => {
                (finalHeaders as Record<string, string>)[key] = value;
            });
        } else if (Array.isArray(options.headers)) {
             options.headers.forEach(([key, value]) => {
                (finalHeaders as Record<string, string>)[key] = value;
            });
        } else {
            finalHeaders = { ...options.headers };
        }
    }

    if (token) {
        (finalHeaders as Record<string, string>)['Authorization'] = `Bearer ${token}`;
    }

    if (options.body instanceof FormData) {
        // Untuk FormData, biarkan browser mengatur header Content-Type dengan boundary yang benar.
        delete (finalHeaders as Record<string, string>)['Content-Type'];
        delete (finalHeaders as Record<string, string>)['content-type'];
    } else {
        // Hanya tambahkan Content-Type jika body ada dan belum diatur.
        if (options.body && !(finalHeaders as Record<string, string>)['Content-Type'] && !(finalHeaders as Record<string, string>)['content-type']) {
            (finalHeaders as Record<string, string>)['Content-Type'] = 'application/json';
        }
    }

    const finalOptions: RequestInit = {
        ...options,
        headers: finalHeaders,
    };
    
    const fullUrl = `${API_BASE_URL}${endpoint}`;

    const response = await fetch(fullUrl, finalOptions);

    if (!response.ok) {
        let errorMessage = `Request failed with status ${response.status}`;
        try {
            // Check if there is a response body before trying to parse it
            const text = await response.text();
            if (text) {
                const errorData = JSON.parse(text);
                errorMessage = errorData.message || errorMessage;
            }
        } catch (e) {
            // Ignore JSON parsing errors, the default message will be used.
            console.error("Could not parse error response JSON", e);
        }
        throw new Error(errorMessage);
    }

    return response;
};