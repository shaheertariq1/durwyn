import Icon from '../Icon/Icon.jsx'
import './SyncedEmptyCard.css'

// Bordered placeholder used for tabs whose data is only ever synced from the mobile app
// (Emergency Contacts, GPS History) — there is no admin-side record to list.
function SyncedEmptyCard({ title, message = 'Synced from mobile app' }) {
  return (
    <div className="synced-empty-card">
      <div className="synced-empty-card__box" role="status">
        <Icon name="empty-document-icon" size={28} />
        <p className="synced-empty-card__title">{title}</p>
        <p className="synced-empty-card__message">{message}</p>
      </div>
    </div>
  )
}

export default SyncedEmptyCard
