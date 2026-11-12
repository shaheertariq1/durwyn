import { useState } from 'react'
import Tabs from '../../components/Tabs/Tabs.jsx'
import ProfileTab from './tabs/ProfileTab.jsx'
import PasswordTab from './tabs/PasswordTab.jsx'
import NotificationsTab from './tabs/NotificationsTab.jsx'
import SecurityTab from './tabs/SecurityTab.jsx'
import PlatformTab from './tabs/PlatformTab.jsx'
import './SettingsPage.css'

const TABS = [
  { value: 'profile', label: 'profile' },
  { value: 'password', label: 'password' },
  { value: 'notifications', label: 'notifications' },
  { value: 'security', label: 'security' },
  { value: 'platform', label: 'platform' },
]

const TAB_CONTENT = {
  profile: ProfileTab,
  password: PasswordTab,
  notifications: NotificationsTab,
  security: SecurityTab,
  platform: PlatformTab,
}

function SettingsPage() {
  const [tab, setTab] = useState('profile')
  const ActiveTab = TAB_CONTENT[tab]

  return (
    <div className="settings-page">
      <h2 className="settings-page__title">Settings</h2>
      <Tabs tabs={TABS} value={tab} onChange={setTab} />
      <ActiveTab />
    </div>
  )
}

export default SettingsPage
