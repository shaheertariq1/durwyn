import InfoList from '../InfoList/InfoList.jsx'
import StatGrid from '../StatGrid/StatGrid.jsx'
import './UserOverviewCard.css'

// "Personal Info" + "Statistics" side-by-side card on the user detail Overview tab.
function UserOverviewCard({ user }) {
  const personalInfoRows = [
    { label: 'Full Name', value: user.name },
    { label: 'Email', value: user.email },
    { label: 'Phone', value: user.phone },
    { label: 'Location', value: user.location },
    { label: 'Registered', value: user.joined },
  ]

  const stats = [
    { label: 'Emergencies', value: user.stats.emergencies, color: 'var(--admin-red)' },
    { label: 'Contacts', value: user.stats.contacts, color: 'var(--admin-accent)' },
    { label: 'GPS Points', value: user.stats.gpsPoints, color: 'var(--admin-blue)' },
    { label: 'Payments', value: user.stats.payments, color: 'var(--admin-purple)' },
  ]

  return (
    <div className="user-overview-card">
      <InfoList title="Personal Info" rows={personalInfoRows} />
      <StatGrid title="Statistics" stats={stats} />
    </div>
  )
}

export default UserOverviewCard
