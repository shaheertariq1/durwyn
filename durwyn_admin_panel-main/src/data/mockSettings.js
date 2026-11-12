// Mock data for the Settings screen, kept separate from presentation so it can
// be swapped for real API data later.

export const initialProfile = {
  displayName: 'Super Admin',
  email: 'admin@troublecheat.com',
  firstName: 'Super',
  lastName: 'Admin',
  // Figma's source node repeats a "First Name" field as a second, full-width
  // row with the same value — kept literal rather than "corrected", per the
  // project's standing precedent of not inventing fixes for design mismatches.
  secondFirstName: 'Super',
  phone: '+1 555-0000',
  role: 'Super Administrator',
}

export const passwordRequirements = [
  { id: 'length', label: 'Min. 8 characters', test: (password) => password.length >= 8 },
  { id: 'uppercase', label: 'Uppercase letter', test: (password) => /[A-Z]/.test(password) },
  { id: 'number', label: 'A number', test: (password) => /[0-9]/.test(password) },
  { id: 'special', label: 'Special character', test: (password) => /[^A-Za-z0-9]/.test(password) },
]

export const initialNotificationPreferences = [
  {
    id: 'emergencyAlerts',
    label: 'Emergency Alerts',
    description: 'Real-time alerts for all active emergencies',
    enabled: true,
  },
  {
    id: 'newRegistrations',
    label: 'New Registrations',
    description: 'Alert when new users join',
    enabled: true,
  },
  {
    id: 'paymentEvents',
    label: 'Payment Events',
    description: 'Failed and successful charges',
    enabled: true,
  },
  {
    id: 'subscriptionExpiry',
    label: 'Subscription Expiry',
    description: '7-day expiry reminders',
    enabled: true,
  },
  {
    id: 'weeklyAnalytics',
    label: 'Weekly Analytics',
    description: 'Auto-generated weekly reports',
    enabled: false,
  },
]

export const sessionTimeoutOptions = ['15 Mins', '30 Mins', '60 Mins', '4 Hours']

export const initialSecurity = {
  loginAlerts: true,
  sessionTimeout: '30 Mins',
  ipWhitelist: '192.168.1.0/24\n10.0.0.1',
}

export const initialSessions = [
  {
    id: 'session-1',
    device: 'Chrome / macOS',
    meta: '192.168.1.5 · New York, US · Active now',
    current: true,
  },
  {
    id: 'session-2',
    device: 'Safari / iPhone',
    meta: '10.0.1.88 · New York, US · 2h ago',
    current: false,
  },
  {
    id: 'session-3',
    device: 'Firefox / Win',
    meta: '203.45.12.9 · London, UK · Yesterday',
    current: false,
  },
]

export const platformNameOptions = ['Trouble Cheat']
export const languageOptions = ['English', 'Spanish', 'French']
export const timezoneOptions = ['UTC', 'America/New_York', 'Europe/London']
export const dataRetentionOptions = ['30 Days', '90 Days', '180 Days', '1 Year']

export const initialPlatformConfig = {
  platformName: 'Trouble Cheat',
  language: 'English',
  timezone: 'UTC',
  dataRetention: '90 Days',
}

export const initialFeatureToggles = [
  {
    id: 'gpsTracking',
    label: 'GPS Tracking',
    description: 'Real-time GPS during emergencies',
    enabled: true,
  },
  {
    id: 'audioRecording',
    label: 'Audio Recording',
    description: 'Record audio during emergency events',
    enabled: true,
  },
  {
    id: 'videoRecording',
    label: 'Video Recording',
    description: 'Record video (Premium)',
    enabled: true,
  },
  {
    id: 'emergencyAlerts',
    label: 'Emergency Alerts',
    description: 'Push to emergency contacts',
    enabled: true,
  },
  {
    id: 'pushNotifications',
    label: 'Push Notifications',
    description: 'System-wide push delivery',
    enabled: true,
  },
]

export const initialMaintenanceMode = false
