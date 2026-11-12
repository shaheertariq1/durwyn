import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import UserProfileHeader from '../../components/UserProfileHeader/UserProfileHeader.jsx'
import Tabs from '../../components/Tabs/Tabs.jsx'
import UserOverviewCard from '../../components/UserOverviewCard/UserOverviewCard.jsx'
import EmergencyHistoryList from '../../components/EmergencyHistoryList/EmergencyHistoryList.jsx'
import PaymentHistoryList from '../../components/PaymentHistoryList/PaymentHistoryList.jsx'
import SyncedEmptyCard from '../../components/SyncedEmptyCard/SyncedEmptyCard.jsx'
import EmptyState from '../../components/EmptyState/EmptyState.jsx'
import EditUserModal from '../../components/EditUserModal/EditUserModal.jsx'
import { users } from '../../data/mockUsers.js'
import './UserDetailPage.css'

const TABS = [
  { value: 'overview', label: 'Overview' },
  { value: 'emergencies', label: 'Emergencies' },
  { value: 'contacts', label: 'Contacts' },
  { value: 'payments', label: 'Payments' },
  { value: 'gps-history', label: 'GPS History' },
]

function UserDetailPage() {
  const { userId } = useParams()
  const navigate = useNavigate()
  const [activeTab, setActiveTab] = useState('overview')
  const [user, setUser] = useState(() => users.find((candidate) => candidate.id === userId))
  const [isEditOpen, setIsEditOpen] = useState(false)
  const [loadedUserId, setLoadedUserId] = useState(userId)

  if (userId !== loadedUserId) {
    setLoadedUserId(userId)
    setUser(users.find((candidate) => candidate.id === userId))
  }

  if (!user) {
    return (
      <div className="user-detail-page">
        <EmptyState
          icon="nav-user-icon"
          title="User not found"
          message={`No user matches "${userId}". They may have been removed.`}
        />
      </div>
    )
  }

  function handleDelete() {
    const confirmed = window.confirm(`Delete ${user.name}? This cannot be undone.`)
    if (confirmed) navigate('/dashboard/user', { replace: true })
  }

  function handleSaveEdit(updates) {
    setUser((current) => ({ ...current, ...updates }))
    setIsEditOpen(false)
  }

  return (
    <div className="user-detail-page">
      <button type="button" className="user-detail-page__back" onClick={() => navigate('/dashboard/user')}>
        <span aria-hidden="true">←</span>
        Back to user
      </button>

      <UserProfileHeader user={user} onEdit={() => setIsEditOpen(true)} onDelete={handleDelete} />

      <Tabs tabs={TABS} value={activeTab} onChange={setActiveTab} />

      <div className="user-detail-page__panel">
        {activeTab === 'overview' && <UserOverviewCard user={user} />}
        {activeTab === 'emergencies' && <EmergencyHistoryList items={user.emergencyHistory} />}
        {activeTab === 'contacts' && <SyncedEmptyCard title="Emergency Contacts" />}
        {activeTab === 'payments' && <PaymentHistoryList items={user.payments} />}
        {activeTab === 'gps-history' && <SyncedEmptyCard title="GPS History" />}
      </div>

      {isEditOpen && (
        <EditUserModal user={user} onClose={() => setIsEditOpen(false)} onSave={handleSaveEdit} />
      )}
    </div>
  )
}

export default UserDetailPage
