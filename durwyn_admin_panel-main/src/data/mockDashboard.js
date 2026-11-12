// Local mock data standing in for the dashboard API. Swap each export for a
// real fetch once the backend endpoints exist — components only consume the
// shapes below, not this module directly.

export const currentUser = {
  name: 'Elena Vasquez',
  role: 'Piano Teacher',
  unreadNotifications: 4,
}

// Feed shown in the TopNav bell dropdown — a short preview, not the full
// Notifications page (see mockNotifications.js for that).
export const notificationFeed = [
  {
    id: 'feed-1',
    icon: 'activity-warning-icon',
    tint: 'red',
    title: 'Active emergency: Sarah Mitchell',
    time: '2m ago',
  },
  {
    id: 'feed-2',
    icon: 'activity-user-add-icon',
    tint: 'green',
    title: 'New user: Kwame Asante',
    time: '18m ago',
  },
  {
    id: 'feed-3',
    icon: 'activity-card-icon',
    tint: 'amber',
    title: 'Payment failed: Priya Nair',
    time: '1h ago',
  },
  {
    id: 'feed-4',
    icon: 'topnav-bell-icon',
    tint: 'blue',
    title: 'Maintenance at 2AM UTC',
    time: '3h ago',
  },
]

export const kpiCards = [
  {
    id: 'total-users',
    label: 'Total Users',
    value: '3,124',
    icon: 'kpi-total-users-icon',
    tint: 'green',
    trend: { direction: 'up', label: '14.2%' },
  },
  {
    id: 'active-users',
    label: 'Active Users',
    value: '2,891',
    icon: 'kpi-active-users-icon',
    tint: 'blue',
    trend: { direction: 'up', label: '8.7%' },
  },
  {
    id: 'emergencies-today',
    label: "Today's Emergencies",
    value: '6',
    icon: 'kpi-emergencies-today-icon',
    tint: 'red',
    trend: { direction: 'up', label: '2' },
  },
  {
    id: 'monthly-revenue',
    label: 'Monthly Revenue',
    value: '$28,714',
    icon: 'kpi-revenue-icon',
    tint: 'amber',
    trend: { direction: 'up', label: '17.6%' },
  },
  {
    id: 'premium-users',
    label: 'Premium Users',
    value: '867',
    icon: 'kpi-premium-icon',
    tint: 'purple',
    trend: { direction: 'up', label: '22.1%' },
  },
  {
    id: 'standard-users',
    label: 'Standard Users',
    value: '1,124',
    icon: 'kpi-standard-icon',
    tint: 'blue',
    trend: { direction: 'up', label: '11.4%' },
  },
  {
    id: 'emergency-contacts',
    label: 'Emerg. Contacts',
    value: '4,218',
    icon: 'kpi-emerg-contacts-icon',
    tint: 'green',
    trend: { direction: 'up', label: '9.3%' },
  },
  {
    id: 'active-emergencies',
    label: 'Active Emerg.',
    value: '2',
    icon: 'kpi-active-emerg-icon',
    tint: 'red',
    trend: { direction: 'down', label: '1' },
  },
]

const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul']

export const userGrowthTrend = {
  title: 'User Growth',
  subtitle: 'Monthly',
  changeLabel: '+14.2%',
  data: [1500, 1780, 2050, 2380, 2650, 2920, 3124].map((value, index) => ({
    month: MONTHS[index],
    users: value,
  })),
}

export const revenueTrend = {
  title: 'Revenue',
  subtitle: 'Monthly USD',
  changeLabel: '+17.6%',
  data: [12400, 14100, 16300, 18900, 21600, 24800, 28714].map((value, index) => ({
    month: MONTHS[index],
    revenue: value,
  })),
}

export const emergencyStatisticsChart = {
  title: 'Emergency Statistics',
  categories: [
    { key: 'medical', label: 'Medical', color: '#ef4444' },
    { key: 'assault', label: 'Assault', color: '#f59e0b' },
    { key: 'fire', label: 'Fire', color: '#8b5cf6' },
    { key: 'other', label: 'Other', color: '#3b82f6' },
  ],
  data: [
    { month: 'Jan', medical: 9, assault: 4, fire: 6, other: 3 },
    { month: 'Feb', medical: 11, assault: 5, fire: 7, other: 4 },
    { month: 'Mar', medical: 10, assault: 6, fire: 9, other: 5 },
    { month: 'Apr', medical: 14, assault: 7, fire: 10, other: 4 },
    { month: 'May', medical: 12, assault: 8, fire: 12, other: 6 },
    { month: 'Jun', medical: 15, assault: 9, fire: 13, other: 6 },
    { month: 'Jul', medical: 16, assault: 10, fire: 14, other: 7 },
  ],
}

export const subscriptionSplit = {
  title: 'Subscription Split',
  totalLabel: '3,124 users',
  segments: [
    { key: 'premium', label: 'Premium', value: 867, percent: 28, color: '#22c55e' },
    { key: 'standard', label: 'Standard', value: 1124, percent: 36, color: '#3b82f6' },
    { key: 'free', label: 'Free', value: 1133, percent: 36, color: '#ffffff' },
  ],
}

export const recentActivity = [
  {
    id: 'activity-1',
    icon: 'activity-user-add-icon',
    tint: 'green',
    title: 'New user registered',
    detail: 'Kwame Asante joined with Premium plan',
    time: '2m ago',
  },
  {
    id: 'activity-2',
    icon: 'activity-warning-icon',
    tint: 'red',
    title: 'Emergency activated',
    detail: 'Sarah Mitchell triggered medical alert',
    time: '12m ago',
  },
  {
    id: 'activity-3',
    icon: 'activity-card-icon',
    tint: 'amber',
    title: 'Payment received',
    detail: '$19.99 from Daniel Rivera (Premium)',
    time: '45m ago',
  },
  {
    id: 'activity-4',
    icon: 'activity-arrow-upgrade-icon',
    tint: 'blue',
    title: 'Plan upgrade',
    detail: 'Marcus Webb Free → Standard',
    time: '1h ago',
  },
  {
    id: 'activity-5',
    icon: 'activity-alert-circle-icon',
    tint: 'red',
    title: 'Payment failed',
    detail: 'Priya Nair Standard renewal failed',
    time: '2h ago',
  },
  {
    id: 'activity-6',
    icon: 'activity-check-circle-icon',
    tint: 'green',
    title: 'Emergency resolved',
    detail: 'Daniel Rivera emergency closed',
    time: '3h ago',
  },
]

export const quickActions = [
  { id: 'send-notification', icon: 'action-send-icon', tint: 'green', label: 'Send Notification' },
  {
    id: 'view-active-emergencies',
    icon: 'activity-warning-icon',
    tint: 'red',
    label: 'View Active Emergencies',
  },
  { id: 'generate-report', icon: 'action-report-icon', tint: 'purple', label: 'Generate Report' },
  {
    id: 'manage-subscriptions',
    icon: 'action-subscriptions-icon',
    tint: 'amber',
    label: 'Manage Subscriptions',
  },
  { id: 'export-analytics', icon: 'action-export-icon', tint: 'blue', label: 'Export Analytics' },
  { id: 'add-user', icon: 'activity-user-add-icon', tint: 'green', label: 'Add User' },
]
