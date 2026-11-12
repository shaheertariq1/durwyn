// Local mock data standing in for the Reports API. Each of the 6 report
// types below reuses the same underlying records shown on their own screens
// (users, subscriptions, payments) so the numbers stay consistent across the
// admin panel; swapping this module for a real fetch later is a drop-in change.

import { users } from './mockUsers.js'
import { subscriptions } from './mockSubscriptions.js'
import { payments } from './mockPayments.js'

export const reportTypes = [
  { id: 'user', label: 'User Report', icon: 'report-user-icon', tint: 'green' },
  { id: 'emergency', label: 'Emergency Report', icon: 'report-emergency-icon', tint: 'red' },
  { id: 'subscription', label: 'Subscription Report', icon: 'report-subscription-icon', tint: 'purple' },
  { id: 'revenue', label: 'Revenue Report', icon: 'report-revenue-icon', tint: 'amber' },
  { id: 'payment', label: 'Payment Report', icon: 'report-payment-icon', tint: 'blue' },
  { id: 'gps', label: 'GPS Report', icon: 'gps-pin-icon', tint: 'green' },
]

const userReportRows = users.map((user) => ({
  id: user.id,
  name: user.name,
  email: user.email,
  plan: user.plan,
  status: user.status,
  joined: user.joined,
  emergencies: `${user.stats.emergencies} events`,
}))

// Figma's "Emergency Report" and "Subscription Report" panels render the
// identical per-user subscription table (same columns, same sample rows), so
// both report types are backed by the same subscriptions data here.
const subscriptionStyleRows = subscriptions.map((subscription) => ({
  id: subscription.userId,
  user: subscription.name,
  plan: subscription.plan,
  status: subscription.status,
  started: subscription.started,
  renews: subscription.renews,
  amount: subscription.amount > 0 ? `$${subscription.amount.toFixed(2)}/mo` : 'Free',
}))

const revenueReportRows = [
  { id: 'R0', month: 'Jan 2024', revenue: 9842, growth: null, premium: 312, standard: 448, free: 480 },
  { id: 'R1', month: 'Feb 2024', revenue: 12130, growth: 23.2, premium: 387, standard: 521, free: 572 },
  { id: 'R2', month: 'Mar 2024', revenue: 14285, growth: 17.8, premium: 451, standard: 634, free: 665 },
  { id: 'R3', month: 'Apr 2024', revenue: 17520, growth: 22.6, premium: 538, standard: 722, free: 750 },
  { id: 'R4', month: 'May 2024', revenue: 20941, growth: 19.5, premium: 641, standard: 856, free: 883 },
  { id: 'R5', month: 'Jun 2024', revenue: 24876, growth: 18.8, premium: 738, standard: 968, free: 921 },
  { id: 'R6', month: 'Jul 2024', revenue: 28104, growth: 13.0, premium: 812, standard: 1039, free: 968 },
  { id: 'R7', month: 'Aug 2024', revenue: 31588, growth: 12.4, premium: 891, standard: 1091, free: 1005 },
  { id: 'R8', month: 'Sep 2024', revenue: 34209, growth: 8.3, premium: 946, standard: 1108, free: 1042 },
  { id: 'R9', month: 'Oct 2024', revenue: 36940, growth: 8.0, premium: 1005, standard: 1132, free: 1080 },
]

const paymentReportRows = payments.map((payment) => ({
  id: payment.id,
  user: payment.name,
  amount: `$${payment.amount.toFixed(2)}`,
  method: payment.method,
  plan: payment.plan,
  status: payment.status,
  date: payment.date,
}))

const gpsReportRows = users.map((user, index) => ({
  id: `GPS${index}`,
  user: user.name,
  route: `Route #${index + 1}`,
  distance: `${(2.4 + index * 1.1).toFixed(1)} km`,
  duration: `${14 + index * 3} min`,
  points: `${142 + index * 18} pts`,
  date: index < 5 ? '2024-07-15' : `2024-07-${16 + (index - 5)}`,
}))

const planLabels = { free: 'Free', standard: 'Standard', premium: 'Premium' }
const statusLabels = { active: 'Active', suspended: 'Suspended', cancelled: 'Cancelled' }
const paymentStatusLabels = { success: 'Success', failed: 'Failed', refunded: 'Refunded' }

export const reportConfigs = {
  user: {
    dateKey: 'joined',
    searchKeys: ['id', 'name', 'email'],
    rows: userReportRows,
    columns: [
      { key: 'id', label: 'User ID', mono: true },
      { key: 'name', label: 'Name' },
      { key: 'email', label: 'Email' },
      { key: 'plan', label: 'Plan', format: (value) => planLabels[value] },
      { key: 'status', label: 'Status', format: (value) => statusLabels[value] },
      { key: 'joined', label: 'Joined' },
      { key: 'emergencies', label: 'Emergencies' },
    ],
  },
  emergency: {
    dateKey: 'started',
    searchKeys: ['id', 'user'],
    rows: subscriptionStyleRows,
    columns: [
      { key: 'id', label: 'User ID', mono: true },
      { key: 'user', label: 'User' },
      { key: 'plan', label: 'Plan', format: (value) => planLabels[value] },
      { key: 'status', label: 'Status', format: (value) => statusLabels[value] },
      { key: 'started', label: 'Started' },
      { key: 'renews', label: 'Renews' },
      { key: 'amount', label: 'Amount' },
    ],
  },
  subscription: {
    dateKey: 'started',
    searchKeys: ['id', 'user'],
    rows: subscriptionStyleRows,
    columns: [
      { key: 'id', label: 'User ID', mono: true },
      { key: 'user', label: 'User' },
      { key: 'plan', label: 'Plan', format: (value) => planLabels[value] },
      { key: 'status', label: 'Status', format: (value) => statusLabels[value] },
      { key: 'started', label: 'Started' },
      { key: 'renews', label: 'Renews' },
      { key: 'amount', label: 'Amount' },
    ],
  },
  revenue: {
    dateKey: null,
    searchKeys: ['id', 'month'],
    rows: revenueReportRows,
    columns: [
      { key: 'id', label: 'Period', mono: true },
      { key: 'month', label: 'Month' },
      { key: 'revenue', label: 'Revenue', format: (value) => `$${value.toLocaleString()}` },
      { key: 'growth', label: 'Growth', format: (value) => (value == null ? '—' : `+${value.toFixed(1)}%`) },
      { key: 'premium', label: 'Premium' },
      { key: 'standard', label: 'Standard' },
      { key: 'free', label: 'Free' },
    ],
  },
  payment: {
    dateKey: 'date',
    searchKeys: ['id', 'user'],
    rows: paymentReportRows,
    columns: [
      { key: 'id', label: 'Pay ID', mono: true },
      { key: 'user', label: 'User' },
      { key: 'amount', label: 'Amount' },
      { key: 'method', label: 'Method' },
      { key: 'plan', label: 'Plan', format: (value) => planLabels[value] },
      { key: 'status', label: 'Status', format: (value) => paymentStatusLabels[value] },
      { key: 'date', label: 'Date' },
    ],
  },
  gps: {
    dateKey: 'date',
    searchKeys: ['id', 'user'],
    rows: gpsReportRows,
    columns: [
      { key: 'id', label: 'GPS ID', mono: true },
      { key: 'user', label: 'User' },
      { key: 'route', label: 'Route' },
      { key: 'distance', label: 'Distance' },
      { key: 'duration', label: 'Duration' },
      { key: 'points', label: 'GPS Points' },
      { key: 'date', label: 'Date' },
    ],
  },
}
