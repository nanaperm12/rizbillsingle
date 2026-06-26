// types.ts

// Enums
export enum CustomerStatus {
  Active = 'Active',
  Suspended = 'Suspended',
  Inactive = 'Inactive',
}

export enum PaymentStatus {
  Paid = 'Paid',
  Unpaid = 'Unpaid',
  Overdue = 'Overdue',
}

export enum ComplaintStatus {
  Pending = 'Pending',
  InProgress = 'In Progress',
  Resolved = 'Resolved',
}

export enum ComplaintType {
    SlowConnection = 'Slow Connection',
    NoConnection = 'No Connection',
    BillingIssue = 'Billing Issue',
    Other = 'Other',
}

export enum VoucherStatus {
    New = 'new',
    Active = 'active',
    Expired = 'expired',
}


// Interfaces
export interface PackageChange {
  id: number;
  customer_id: string;
  new_package_id: number;
  status: 'pending' | 'processed' | 'cancelled';
  created_at: string;
  new_package_name?: string; // Ditambahkan untuk menampilkan nama paket
}


// New interface for replies
export interface ComplaintReply {
  id: string;
  senderType: 'admin' | 'customer';
  senderName: string; // e.g., 'admin', or the customer's name
  replyText: string;
  createdAt: string;
  photos?: string[];
}

export interface Customer {
  id: string;
  name: string;
  address: string;
  phone: string;
  email: string;
  packageId: number;
  status: CustomerStatus;
  location?: { lat: number; lng: number };
  odpId?: string;
  pppoeUsername?: string;
  activeDate?: string;
  previousPppoeProfile?: string;
  acsSerialNumber?: string; // Field baru untuk menautkan ke perangkat ACS
}

export type UserRole = 'admin' | 'reseller' | 'technician';

export interface AdminUser {
  id: string;
  username: string;
  role: UserRole;
  balance?: number;
  phone?: string;
}

export interface Package {
  id: number;
  name: string;
  speed: number;
  price: number;
  pppoeProfile?: string;
  useTax?: boolean;
}

export interface Invoice {
  id: string;
  customerId: string;
  issueDate: string;
  dueDate: string;
  amount: number;
  status: PaymentStatus;
  notes: string;
  billingPeriodStart: string;
  billingPeriodEnd: string;
  tripayReference?: string;
  paymentUrl?: string;
}

export interface Payment {
  id: string;
  invoiceId: string;
  customerId: string | null;
  date: string;
  amount: number;
  method: string;
  sold_by_user_id?: string;
}

export interface Complaint {
  id: string;
  customerId: string;
  customerName: string;
  dateSubmitted: string;
  type: ComplaintType;
  description: string;
  status: ComplaintStatus;
  replies?: ComplaintReply[];
  assignedTo?: string; // Technician user ID
  technicianNotes?: string; // Notes from the technician
  photos?: string[]; // Array of photo URLs/filenames
}

export interface Odp {
    id: string;
    name: string;
    address: string;
    location: { lat: number; lng: number };
    parentId?: string;
    lineColor?: string;
    powerInput?: number;
    powerOutput?: number;
    totalPorts?: number;
}

export interface WhatsappLog {
    id: number;
    recipient_number: string;
    customer_id: string | null;
    message_body: string;
    status: 'sent' | 'failed' | 'pending';
    type: string;
    error_message: string | null;
    created_at: string;
}

// ACS-related types
export interface AcsDevice {
  id: string; // The device's unique ID from ACS (usually Serial Number)
  serialNumber: string;
  productClass: string;
  ipAddress: string;
  pppoeUsername: string;
  rxPower: string;
  lastInform: string;
  isOnline: boolean;
  ssid1?: string;
  customerId: string | null;
  customerName: string | null;
}

// New types for customer-facing ACS device details
export interface AcsWlanConfig {
    ssid: string;
    ssidPath: string;
    key: string;
    keyPath: string;
    associatedDevices?: {
        mac: string;
        ip: string;
        hostname: string;
        signal: string;
    }[];
}

export interface AcsDeviceDetails {
    isOnline: boolean;
    model: string;
    rxPower: string;
    wlanConfigs: AcsWlanConfig[];
}

export interface AcsDeviceFullDetails {
    general: {
        firmware: string | null;
        uptime: string | null;
        model: string | null;
        hardwareVersion: string | null;
    };
    wan: {
        type: string;
        status: string | null;
        username?: string | null;
        usernamePath?: string;
        passwordPath?: string;
        ip: string | null;
        dns: string | null;
        rxPower?: string;
    }[];
    wlan: {
        name: string;
        status: string | null;
        enabled: boolean | null;
        ssid: string | null;
        ssidPath: string;
        security: string | null;
        key: string | null;
        keyPath: string;
        associatedDevices: {
            mac: string;
            ip: string;
            hostname: string;
            signal: string;
        }[];
    }[];
    lan: {
        ip: string | null;
        subnet: string | null;
        connectedHosts: {
            ip: string;
            mac: string;
            hostname: string;
            active: boolean;
        }[];
    };
    raw?: any; // For the raw JSON view
}


// Mikrotik-related types
export interface PppoeUser {
    id: string;
    name: string;
    password?: string;
    service: string;
    profile: string;
    comment: string;
    disabled: boolean;
    active: boolean;
}

export interface PppoeProfile {
    id: string;
    name: string;
    localAddress: string;
    remoteAddressPool: string;
    rateLimit: string;
    userCount?: number;
}

export interface PppoeActiveUser {
    id: string;
    name: string;
    service: string;
    callerId: string;
    address: string;
    uptime: string;
}

export interface HotspotUser {
    id: string;
    name: string;
    password?: string;
    profile: string;
    comment: string;
    disabled: boolean;
    active?: boolean;
    totalUptime?: string;
}

export interface HotspotProfile {
    id: string;
    name: string;
    rateLimit: string;
    sharedUsers: number;
    userCount?: number;
    price?: number;
    sellingPrice?: number;
    duration_minutes?: number;
}

export interface HotspotVoucher {
    id: number;
    username: string;
    password: string;
    profile: string;
    duration_minutes: number;
    status: VoucherStatus;
    created_at: string;
    mikrotik_id: string;
    first_used_at: string | null;
    expires_at: string | null;
    active: boolean;
    sold_by_user_id?: string | null;
    // Fix: Add optional `uptime` and `totalUptime` properties to hold live data from the router.
    uptime?: string | null; // Session uptime from active connection
    totalUptime?: string | null; // Total accumulated uptime from user details
}

export interface HotspotActiveUser {
    id: string;
    user: string;
    address: string;
    uptime: string;
    bytesIn: number;
    bytesOut: number;
}

// Settings
export interface ApiSettings {
  mikrotik: {
    host: string;
    user: string;
    password?: string;
    port: number;
  };
  tripay: {
    apiKey: string;
    privateKey: string;
    merchantCode: string;
    sandboxMode: boolean;
    enabledMethods: string[];
  };
  billing: {
    taxRate: number;
    dueDays: number;
    generationDay: number;
    suspensionDays: number;
    suspensionProfileName: string;
    whatsappNotificationsEnabled: boolean;
    reminderDaysBeforeDue?: number;
  };
  app: {
    baseUrl: string;
    appName: string;
    appLogoUrl?: string;
    odpLineColor?: string;
    companyPhone?: string;
    companyAddress?: string;
    customerIdPrefix?: string;
    apiKey?: string;
  };
  otp: {
    enabled: boolean;
    whatsappTemplate: string;
  };
  whatsapp: {
    invoiceCreated: string;
    invoiceReminder: string;
    paymentSuccess: string;
    suspensionWarning: string;
    adminPhoneNumber: string;
    newComplaintNotification: string;
    accountSuspended: string;
    accountReactivated: string;
    accountDeactivated: string;
    resellerBalanceAdded: string;
    technicianTaskAssignment: string;
    chatbotEnabled?: boolean;
    packageChanged?: string; // Add packageChanged to satisfy ApiSettings
  };
  acs: {
    apiUrl: string;
    username?: string;
    password?: string;
  };
}

// Helper Functions

export const formatRupiah = (amount: number): string => {
    if (isNaN(amount)) return 'Rp 0';
    return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
    }).format(amount);
};

export const formatDateDisplay = (dateString?: string | null): string => {
    if (!dateString) return 'N/A';
    try {
        const date = new Date(dateString);
        if (isNaN(date.getTime())) return 'N/A';
        return date.toLocaleDateString('id-ID', { day: '2-digit', month: 'short', year: 'numeric' });
    } catch (e) {
        return 'Invalid Date';
    }
};

export const formatTimeDisplay = (dateString?: string | null): string => {
    if (!dateString) return '';
    try {
        const date = new Date(dateString);
        if (isNaN(date.getTime())) return '';
        return date.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
    } catch (e) {
        return '';
    }
};

export const formatDateTimeDisplay = (dateString?: string | null): string => {
    if (!dateString) return 'N/A';
    try {
        const date = new Date(dateString);
        if (isNaN(date.getTime())) return 'N/A';
        return date.toLocaleString('id-ID', {
            day: '2-digit',
            month: 'short',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
        });
    } catch (e) {
        return 'Invalid Date';
    }
};

/**
 * Formats a date string by treating its components as local time, ignoring browser's timezone conversion.
 * It uses UTC getters on the date object which effectively reads the raw date/time values from the string.
 * @param dateString The ISO-like string from the database.
 * @returns A formatted local date and time string.
 */
export const formatDateTimeDisplayFixed = (dateString?: string | null): string => {
    // FIX: This function was incorrectly displaying raw UTC time components.
    // It is now being redirected to use formatDateTimeDisplay which correctly
    // converts the UTC timestamp to the user's local timezone.
    return formatDateTimeDisplay(dateString);
};


export const formatBillingPeriod = (start?: string | null, end?: string | null): string => {
    if (!start || !end) return 'N/A';
    return `${formatDateDisplay(start)} - ${formatDateDisplay(end)}`;
};

export const formatDuration = (minutes: number): string => {
    if (isNaN(minutes) || minutes < 0) return 'N/A';
    if (minutes === 0) return '0 minutes';

    const MINS_IN_DAY = 24 * 60;
    const MINS_IN_HOUR = 60;

    const days = Math.floor(minutes / MINS_IN_DAY);
    const remainingMinutesAfterDays = minutes % MINS_IN_DAY;
    const hours = Math.floor(remainingMinutesAfterDays / MINS_IN_HOUR);
    const remainingMinutes = remainingMinutesAfterDays % MINS_IN_HOUR;

    const parts = [];
    if (days > 0) {
        parts.push(`${days} day${days > 1 ? 's' : ''}`);
    }
    if (hours > 0) {
        parts.push(`${hours} hour${hours > 1 ? 's' : ''}`);
    }
    if (remainingMinutes > 0) {
        parts.push(`${remainingMinutes} minute${remainingMinutes > 1 ? 's' : ''}`);
    }

    if (parts.length === 0) {
        return `${minutes} minute${minutes > 1 ? 's' : ''}`;
    }

    return parts.join(' ');
};

export const formatBytes = (bytes: number, decimals = 2): string => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
};