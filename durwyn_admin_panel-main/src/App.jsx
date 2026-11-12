import { useState } from 'react'
import { Navigate, Route, Routes, useNavigate } from 'react-router-dom'
import LoginPage from './pages/Login/LoginPage.jsx'
import ForgotPasswordPage from './pages/ForgotPassword/ForgotPasswordPage.jsx'
import VerifyOtpPage from './pages/VerifyOtp/VerifyOtpPage.jsx'
import ResetPasswordPage from './pages/ResetPassword/ResetPasswordPage.jsx'
import AdminLayout from './layouts/AdminLayout/AdminLayout.jsx'
import DashboardPage from './pages/Dashboard/DashboardPage.jsx'
import UsersListPage from './pages/Users/UsersListPage.jsx'
import UserDetailPage from './pages/Users/UserDetailPage.jsx'
import EmergenciesPage from './pages/Emergencies/EmergenciesPage.jsx'
import EmergencyContactsPage from './pages/EmergencyContacts/EmergencyContactsPage.jsx'
import SubscriptionPage from './pages/Subscription/SubscriptionPage.jsx'
import PaymentsPage from './pages/Payments/PaymentsPage.jsx'
import GpsHistoryPage from './pages/GpsHistory/GpsHistoryPage.jsx'
import NotificationsPage from './pages/Notifications/NotificationsPage.jsx'
import ReportsPage from './pages/Reports/ReportsPage.jsx'
import HelpSupportPage from './pages/HelpSupport/HelpSupportPage.jsx'
import SettingsPage from './pages/Settings/SettingsPage.jsx'
import PlaceholderPage from './pages/Placeholder/PlaceholderPage.jsx'
import { NAV_ITEMS } from './data/navigation.js'

function LoginRoute() {
  const navigate = useNavigate()
  return (
    <LoginPage
      onForgotPassword={() => navigate('/forgot-password')}
      onLoginSuccess={() => navigate('/dashboard', { replace: true })}
    />
  )
}

function ForgotPasswordRoute({ onCodeSent }) {
  const navigate = useNavigate()
  return (
    <ForgotPasswordPage
      onBack={() => navigate('/login')}
      onCodeSent={(email) => {
        onCodeSent(email)
        navigate('/verify-otp')
      }}
    />
  )
}

function VerifyOtpRoute({ email }) {
  const navigate = useNavigate()
  return (
    <VerifyOtpPage
      email={email}
      onBack={() => navigate('/forgot-password')}
      onVerified={() => navigate('/reset-password')}
    />
  )
}

function ResetPasswordRoute() {
  const navigate = useNavigate()
  return (
    <ResetPasswordPage
      onBack={() => navigate('/verify-otp')}
      onDone={() => navigate('/login')}
    />
  )
}

function App() {
  const [resetEmail, setResetEmail] = useState('')

  return (
    <Routes>
      <Route path="/" element={<Navigate to="/login" replace />} />
      <Route path="/login" element={<LoginRoute />} />
      <Route
        path="/forgot-password"
        element={<ForgotPasswordRoute onCodeSent={setResetEmail} />}
      />
      <Route path="/verify-otp" element={<VerifyOtpRoute email={resetEmail} />} />
      <Route path="/reset-password" element={<ResetPasswordRoute />} />

      <Route path="/dashboard" element={<AdminLayout />}>
        <Route index element={<DashboardPage />} />
        <Route path="user" element={<UsersListPage />} />
        <Route path="user/:userId" element={<UserDetailPage />} />
        <Route path="emergencies" element={<EmergenciesPage />} />
        <Route path="emergency-contacts" element={<EmergencyContactsPage />} />
        <Route path="subscription" element={<SubscriptionPage />} />
        <Route path="payments" element={<PaymentsPage />} />
        <Route path="gps-history" element={<GpsHistoryPage />} />
        <Route path="notifications" element={<NotificationsPage />} />
        <Route path="reports" element={<ReportsPage />} />
        <Route path="help-support" element={<HelpSupportPage />} />
        <Route path="settings" element={<SettingsPage />} />
        {NAV_ITEMS.filter(
          (item) =>
            item.path !== '/dashboard' &&
            item.path !== '/dashboard/user' &&
            item.path !== '/dashboard/emergencies' &&
            item.path !== '/dashboard/emergency-contacts' &&
            item.path !== '/dashboard/subscription' &&
            item.path !== '/dashboard/payments' &&
            item.path !== '/dashboard/gps-history' &&
            item.path !== '/dashboard/notifications' &&
            item.path !== '/dashboard/reports' &&
            item.path !== '/dashboard/help-support' &&
            item.path !== '/dashboard/settings',
        ).map((item) => (
          <Route
            key={item.path}
            path={item.path.replace('/dashboard/', '')}
            element={<PlaceholderPage title={item.label} icon={item.icon} />}
          />
        ))}
      </Route>

      <Route path="*" element={<Navigate to="/login" replace />} />
    </Routes>
  )
}

export default App
