import Badge from '../Badge/Badge.jsx'
import RowActionMenu from '../RowActionMenu/RowActionMenu.jsx'
import { typeLabels, typeTone, statusLabels, statusTone } from '../../data/mockNotifications.js'
import './NotificationsTable.css'

const COLUMNS = [
  { key: 'title', label: 'Title' },
  { key: 'type', label: 'Type' },
  { key: 'recipients', label: 'Recipients' },
  { key: 'status', label: 'Status' },
  { key: 'date', label: 'Date' },
  { key: 'delivered', label: 'Delivered' },
]

function NotificationsTable({ notifications, onView, onEdit, onDelete }) {
  return (
    <div className="notifications-table" role="table" aria-label="Notifications">
      <div className="notifications-table__row notifications-table__row--head" role="row">
        {COLUMNS.map((column) => (
          <span key={column.key} className={`notifications-table__cell notifications-table__cell--${column.key}`}>
            {column.label}
          </span>
        ))}
        <span className="notifications-table__cell notifications-table__cell--actions">Actions</span>
      </div>

      <div className="notifications-table__body">
        {notifications.map((notification) => (
          <div className="notifications-table__row" role="row" key={notification.id}>
            <span className="notifications-table__cell notifications-table__cell--title">
              <span className="notifications-table__title-text">{notification.title}</span>
              <span className="notifications-table__description">{notification.description}</span>
            </span>
            <span className={`notifications-table__cell notifications-table__cell--type notifications-table__type--${typeTone[notification.type]}`}>
              {typeLabels[notification.type]}
            </span>
            <span className="notifications-table__cell notifications-table__cell--recipients">
              {notification.recipients}
            </span>
            <span className="notifications-table__cell notifications-table__cell--status">
              <Badge tone={statusTone[notification.status]}>{statusLabels[notification.status]}</Badge>
            </span>
            <span className="notifications-table__cell notifications-table__cell--date">{notification.date}</span>
            <span className="notifications-table__cell notifications-table__cell--delivered">
              {notification.delivered.toLocaleString()}
            </span>
            <span className="notifications-table__cell notifications-table__cell--actions">
              <RowActionMenu
                label={`Actions for ${notification.title}`}
                actions={[
                  { label: 'View', icon: 'eye-icon', onClick: () => onView(notification) },
                  { label: 'Edit', icon: 'action-edit-icon', onClick: () => onEdit(notification) },
                  {
                    label: 'Delete',
                    icon: 'action-delete-icon',
                    tone: 'red',
                    onClick: () => onDelete(notification.id),
                  },
                ]}
              />
            </span>
          </div>
        ))}

        {notifications.length === 0 && (
          <p className="notifications-table__empty">No notifications match the current search.</p>
        )}
      </div>
    </div>
  )
}

export default NotificationsTable
