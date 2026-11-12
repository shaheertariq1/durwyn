// Mock data for the Help & Support screen (Tickets / FAQ / Documentation tabs).
// Kept separate from presentation components so it can later be swapped for API data.

export const priorityLabels = {
  low: 'Low',
  medium: 'Medium',
  high: 'High',
  critical: 'Critical',
}

export const priorityTone = {
  low: 'neutral',
  medium: 'blue',
  high: 'amber',
  critical: 'red',
}

export const statusLabels = {
  open: 'Open',
  'in-progress': 'In Progress',
  resolved: 'Resolved',
}

export const statusTone = {
  open: 'amber',
  'in-progress': 'blue',
  resolved: 'green',
}

export const tickets = [
  {
    id: 'TKT-001',
    title: 'User unable to trigger emergency',
    date: '2024-07-14',
    priority: 'high',
    status: 'open',
  },
  {
    id: 'TKT-002',
    title: 'Payment gateway integration issue',
    date: '2024-07-13',
    priority: 'critical',
    status: 'in-progress',
  },
  {
    id: 'TKT-003',
    title: 'GPS tracking not updating',
    date: '2024-07-12',
    priority: 'medium',
    status: 'resolved',
  },
  {
    id: 'TKT-004',
    title: 'Push notification not delivered',
    date: '2024-07-11',
    priority: 'low',
    status: 'open',
  },
  {
    id: 'TKT-005',
    title: 'Subscription renewal failed silently',
    date: '2024-07-10',
    priority: 'high',
    status: 'in-progress',
  },
  {
    id: 'TKT-006',
    title: 'Emergency contact list not syncing',
    date: '2024-07-09',
    priority: 'medium',
    status: 'resolved',
  },
  {
    id: 'TKT-007',
    title: 'Report export stuck at 0%',
    date: '2024-07-08',
    priority: 'low',
    status: 'resolved',
  },
  {
    id: 'TKT-008',
    title: 'Admin login OTP not received',
    date: '2024-07-07',
    priority: 'critical',
    status: 'open',
  },
  {
    id: 'TKT-009',
    title: 'Duplicate refund issued to user',
    date: '2024-07-06',
    priority: 'high',
    status: 'in-progress',
  },
  {
    id: 'TKT-010',
    title: 'Map pin drifting on GPS history',
    date: '2024-07-05',
    priority: 'medium',
    status: 'resolved',
  },
]

export const faqs = [
  {
    id: 'faq-1',
    question: "How do I reset a user's password?",
    answer:
      'Navigate to User Management, find the user, open the action menu, and select Reset Password.',
  },
  {
    id: 'faq-2',
    question: 'How do I export data?',
    answer: 'Go to Reports, select a report type, apply filters, then export as PDF, Excel, or CSV.',
  },
  {
    id: 'faq-3',
    question: 'How do I manage subscriptions?',
    answer: 'Use the Subscription Management module to upgrade, downgrade, or cancel any plan.',
  },
  {
    id: 'faq-4',
    question: 'What happens during an emergency?',
    answer:
      'The system captures GPS, starts recording, notifies emergency contacts, and alerts the admin in real time.',
  },
]

export const docLinks = [
  { id: 'doc-payments', icon: 'activity-card-icon', title: 'Payments', subtitle: 'Payment guide' },
  { id: 'doc-notifications', icon: 'topnav-bell-icon', title: 'Notifications', subtitle: 'Sending alerts' },
  { id: 'doc-api', icon: 'help-globe-icon', title: 'API Reference', subtitle: 'Integration docs' },
  { id: 'doc-getting-started', icon: 'help-book-icon', title: 'Getting Started', subtitle: 'Setup for new admins' },
  { id: 'doc-user-management', icon: 'nav-user-icon', title: 'User Management', subtitle: 'Managing accounts' },
  { id: 'doc-emergency-response', icon: 'nav-emergencies-icon', title: 'Emergency Response', subtitle: 'Handling events' },
]
