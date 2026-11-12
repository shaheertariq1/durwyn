import Icon from '../Icon/Icon.jsx'
import './NotificationsDropdown.css'

// Preview panel opened from the TopNav bell. Full history lives on the
// Notifications page — "View all" hands off there.
function NotificationsDropdown({ items, newCount, onViewAll }) {
  return (
    <div className="notifications-dropdown" role="dialog" aria-label="Notifications">
      <div className="notifications-dropdown__head">
        <p className="notifications-dropdown__title">Notifications</p>
        {newCount > 0 && (
          <span className="notifications-dropdown__count">{newCount} new</span>
        )}
      </div>

      <ul className="notifications-dropdown__list">
        {items.map((item) => (
          <li key={item.id} className="notifications-dropdown__item">
            <span
              className={`notifications-dropdown__icon notifications-dropdown__icon--${item.tint}`}
            >
              <Icon name={item.icon} size={13} />
            </span>
            <div className="notifications-dropdown__text">
              <p className="notifications-dropdown__item-title">{item.title}</p>
              <p className="notifications-dropdown__item-time">{item.time}</p>
            </div>
          </li>
        ))}
      </ul>

      <div className="notifications-dropdown__foot">
        <button type="button" className="notifications-dropdown__view-all" onClick={onViewAll}>
          View all
        </button>
      </div>
    </div>
  )
}

export default NotificationsDropdown
