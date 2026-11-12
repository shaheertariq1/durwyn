import Icon from '../Icon/Icon.jsx'
import Badge from '../Badge/Badge.jsx'
import { statusLabels, statusTone, typeLabels } from '../../data/mockNotifications.js'
import './NotificationDetailsModal.css'

// Read-only summary opened from the "View" row action.
function NotificationDetailsModal({ notification, onClose, onEdit }) {
  return (
    <div className="notification-details-modal__overlay" onMouseDown={onClose}>
      <div
        className="notification-details-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Notification Details"
        onMouseDown={(event) => event.stopPropagation()}
      >
        <div className="notification-details-modal__header">
          <p className="notification-details-modal__title">Notification Details</p>
          <button type="button" className="notification-details-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="notification-details-modal__body">
          <div className="notification-details-modal__identity">
            <span className="notification-details-modal__icon">
              <Icon name="topnav-bell-icon" size={16} />
            </span>
            <span className="notification-details-modal__identity-text">
              <span className="notification-details-modal__name">{notification.title}</span>
              <span className="notification-details-modal__subtitle">{notification.date}</span>
            </span>
            <Badge tone={statusTone[notification.status]}>{statusLabels[notification.status]}</Badge>
          </div>

          <div className="notification-details-modal__description">{notification.description}</div>

          <div className="notification-details-modal__grid">
            <div className="notification-details-modal__stat">
              <span className="notification-details-modal__stat-label">Type</span>
              <span className="notification-details-modal__stat-value">{typeLabels[notification.type]}</span>
            </div>
            <div className="notification-details-modal__stat">
              <span className="notification-details-modal__stat-label">Recipients</span>
              <span className="notification-details-modal__stat-value">{notification.recipients}</span>
            </div>
            <div className="notification-details-modal__stat">
              <span className="notification-details-modal__stat-label">Delivered</span>
              <span className="notification-details-modal__stat-value">
                {notification.delivered.toLocaleString()}
              </span>
            </div>
            <div className="notification-details-modal__stat">
              <span className="notification-details-modal__stat-label">Date</span>
              <span className="notification-details-modal__stat-value">{notification.date}</span>
            </div>
          </div>

          <button type="button" className="notification-details-modal__edit-button" onClick={onEdit}>
            <Icon name="action-edit-icon" size={14} />
            Edit Notification
          </button>
        </div>
      </div>
    </div>
  )
}

export default NotificationDetailsModal
