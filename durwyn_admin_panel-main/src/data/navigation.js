// Sidebar navigation config, shared by the Sidebar and the route table in App.jsx.
export const NAV_ITEMS = [
  { label: 'Dashboard', icon: 'nav-dashboard-icon', path: '/dashboard' },
  { label: 'User', icon: 'nav-user-icon', path: '/dashboard/user' },
  { label: 'Emergencies', icon: 'nav-emergencies-icon', path: '/dashboard/emergencies' },
  {
    label: 'Emergency Contacts',
    icon: 'nav-emergency-contacts-icon',
    path: '/dashboard/emergency-contacts',
  },
  { label: 'Subscription', icon: 'nav-subscription-icon', path: '/dashboard/subscription' },
  { label: 'Payments', icon: 'nav-payments-icon', path: '/dashboard/payments' },
  { label: 'GPS History', icon: 'nav-gps-history-icon', path: '/dashboard/gps-history' },
  { label: 'Notifications', icon: 'nav-notifications-icon', path: '/dashboard/notifications' },
  { label: 'Reports', icon: 'nav-reports-icon', path: '/dashboard/reports' },
  { label: 'Help & Support', icon: 'nav-help-support-icon', path: '/dashboard/help-support' },
  { label: 'Settings', icon: 'nav-settings-icon', path: '/dashboard/settings' },
]
