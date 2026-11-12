// Local mock data standing in for the Notifications API.

export const typeLabels = {
  system: 'System',
  marketing: 'Marketing',
  subscription: 'Subscription',
  emergency: 'Emergency',
}
export const typeTone = { system: 'blue', marketing: 'purple', subscription: 'amber', emergency: 'red' }

export const statusLabels = { sent: 'Sent', scheduled: 'Scheduled', failed: 'Failed' }
export const statusTone = { sent: 'green', scheduled: 'amber', failed: 'red' }

export const kpiSummary = [
  { id: 'total-sent', label: 'Total Sent', value: '3,271', tone: 'green' },
  { id: 'scheduled', label: 'Scheduled', value: '2', tone: 'amber' },
  { id: 'delivered-rate', label: 'Delivered Rate', value: '98.4%', tone: 'blue' },
  { id: 'failed', label: 'Failed', value: '52', tone: 'red' },
]

export const notifications = [
  {
    id: 'NTF001',
    title: 'System Maintenance',
    description: 'Scheduled maintenance on July 20, 2024 from 2AM-4AM UTC.',
    type: 'system',
    recipients: 'All Users',
    status: 'sent',
    date: '2024-07-14',
    delivered: 2847,
  },
  {
    id: 'NTF002',
    title: 'Premium Feature Unlocked',
    description: 'Your Premium plan now includes GPS history export!',
    type: 'marketing',
    recipients: 'Premium Users',
    status: 'sent',
    date: '2024-07-10',
    delivered: 423,
  },
  {
    id: 'NTF003',
    title: 'Subscription Expiring',
    description: 'Your subscription expires in 3 days. Renew to stay safe.',
    type: 'subscription',
    recipients: 'Standard Users',
    status: 'scheduled',
    date: '2024-07-18',
    delivered: 0,
  },
  {
    id: 'NTF004',
    title: 'Emergency Contact Alert',
    description: 'A new emergency contact request requires your attention.',
    type: 'emergency',
    recipients: 'Individual',
    status: 'sent',
    date: '2024-07-12',
    delivered: 1,
  },
  {
    id: 'NTF005',
    title: 'New Login Detected',
    description: 'A new device signed in to your account from Chicago, IL.',
    type: 'system',
    recipients: 'Individual',
    status: 'sent',
    date: '2024-07-11',
    delivered: 1,
  },
  {
    id: 'NTF006',
    title: 'Refer a Friend',
    description: 'Invite friends and earn a free month of Premium.',
    type: 'marketing',
    recipients: 'All Users',
    status: 'scheduled',
    date: '2024-07-22',
    delivered: 0,
  },
  {
    id: 'NTF007',
    title: 'Payment Failed',
    description: 'We could not process your last subscription payment.',
    type: 'subscription',
    recipients: 'Standard Users',
    status: 'failed',
    date: '2024-07-09',
    delivered: 0,
  },
  {
    id: 'NTF008',
    title: 'GPS Signal Lost',
    description: 'GPS tracking was interrupted for one of your emergency contacts.',
    type: 'emergency',
    recipients: 'Individual',
    status: 'failed',
    date: '2024-07-08',
    delivered: 0,
  },
  {
    id: 'NTF009',
    title: 'Weekly Safety Digest',
    description: 'Your weekly summary of emergency activity is ready.',
    type: 'system',
    recipients: 'All Users',
    status: 'sent',
    date: '2024-07-07',
    delivered: 3012,
  },
  {
    id: 'NTF010',
    title: 'Plan Renewal Reminder',
    description: 'Your Premium plan renews automatically on July 25.',
    type: 'subscription',
    recipients: 'Premium Users',
    status: 'scheduled',
    date: '2024-07-25',
    delivered: 0,
  },
]
