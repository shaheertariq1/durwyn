import Badge from '../Badge/Badge.jsx'
import EmptyState from '../EmptyState/EmptyState.jsx'
import './EmergencyHistoryList.css'

const STATUS_TONE = { active: 'red', resolved: 'green' }
const STATUS_LABEL = { active: 'Active', resolved: 'Resolved' }

// "Emergency History" card on the user detail Emergencies tab.
function EmergencyHistoryList({ items }) {
  return (
    <div className="emergency-history">
      <p className="emergency-history__title">Emergency History</p>
      {items.length === 0 ? (
        <EmptyState
          icon="nav-emergencies-icon"
          title="No emergencies on record"
          message="Any future emergency events for this user will appear here."
        />
      ) : (
        <ul className="emergency-history__list">
          {items.map((item) => (
            <li className="emergency-history__row" key={item.id}>
              <div>
                <p className="emergency-history__type">{item.type}</p>
                <p className="emergency-history__meta">
                  {item.date} · {item.duration}
                </p>
              </div>
              <Badge tone={STATUS_TONE[item.status]}>{STATUS_LABEL[item.status]}</Badge>
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}

export default EmergencyHistoryList
