import { useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import { typeLabels } from '../../data/mockNotifications.js'
import './NotificationFormModal.css'

const TYPE_OPTIONS = Object.keys(typeLabels)
const RECIPIENT_OPTIONS = ['All Users', 'Premium Users', 'Standard Users', 'Individual']

// Shared "Create Notification" / "Edit Notification" form, opened from the
// page header's Create button and from a row's Edit action respectively.
function NotificationFormModal({ mode, notification, onClose, onSave }) {
  const isCreate = mode === 'create'
  const [title, setTitle] = useState(notification?.title ?? '')
  const [message, setMessage] = useState(notification?.description ?? '')
  const [type, setType] = useState(notification?.type ?? TYPE_OPTIONS[0])
  const [recipients, setRecipients] = useState(notification?.recipients ?? RECIPIENT_OPTIONS[0])
  const [scheduleDate, setScheduleDate] = useState('')

  function handleSubmit(event) {
    event.preventDefault()
    onSave({
      title: title.trim(),
      description: message.trim(),
      type,
      recipients,
      scheduleDate: scheduleDate || null,
    })
  }

  return (
    <div className="notification-form-modal__overlay" onMouseDown={onClose}>
      <form
        className="notification-form-modal"
        role="dialog"
        aria-modal="true"
        aria-label={isCreate ? 'Create Notification' : 'Edit Notification'}
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={handleSubmit}
      >
        <div className="notification-form-modal__header">
          <p className="notification-form-modal__title">
            {isCreate ? 'Create Notification' : 'Edit Notification'}
          </p>
          <button type="button" className="notification-form-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="notification-form-modal__body">
          <div className="notification-form-modal__field">
            <label className="notification-form-modal__label" htmlFor="notification-title">
              Title
            </label>
            <input
              id="notification-title"
              className="notification-form-modal__input"
              value={title}
              onChange={(event) => setTitle(event.target.value)}
              placeholder="Notification Title"
            />
          </div>

          <div className="notification-form-modal__field">
            <label className="notification-form-modal__label" htmlFor="notification-message">
              Message
            </label>
            <textarea
              id="notification-message"
              className="notification-form-modal__textarea"
              value={message}
              onChange={(event) => setMessage(event.target.value)}
              placeholder="Write your notifications....."
            />
          </div>

          <div className="notification-form-modal__row">
            <div className="notification-form-modal__field notification-form-modal__field--half">
              <label className="notification-form-modal__label" htmlFor="notification-type">
                Type
              </label>
              <div className="notification-form-modal__select">
                <select
                  id="notification-type"
                  className="notification-form-modal__select-input"
                  value={type}
                  onChange={(event) => setType(event.target.value)}
                >
                  {TYPE_OPTIONS.map((option) => (
                    <option key={option} value={option}>
                      {typeLabels[option]}
                    </option>
                  ))}
                </select>
                <Icon name="chevron-down-icon" size={10} className="notification-form-modal__chevron" />
              </div>
            </div>

            <div className="notification-form-modal__field notification-form-modal__field--half">
              <label className="notification-form-modal__label" htmlFor="notification-recipients">
                Recipients
              </label>
              <div className="notification-form-modal__select">
                <select
                  id="notification-recipients"
                  className="notification-form-modal__select-input"
                  value={recipients}
                  onChange={(event) => setRecipients(event.target.value)}
                >
                  {RECIPIENT_OPTIONS.map((option) => (
                    <option key={option} value={option}>
                      {option}
                    </option>
                  ))}
                </select>
                <Icon name="chevron-down-icon" size={10} className="notification-form-modal__chevron" />
              </div>
            </div>
          </div>

          {isCreate && (
            <div className="notification-form-modal__field">
              <label className="notification-form-modal__label" htmlFor="notification-schedule">
                Schedule (Optional)
              </label>
              <input
                id="notification-schedule"
                type="date"
                className="notification-form-modal__input"
                value={scheduleDate}
                onChange={(event) => setScheduleDate(event.target.value)}
              />
            </div>
          )}
        </div>

        <div className="notification-form-modal__actions">
          <button
            type="button"
            className="notification-form-modal__button notification-form-modal__button--cancel"
            onClick={onClose}
          >
            Cancel
          </button>
          <button type="submit" className="notification-form-modal__button notification-form-modal__button--save">
            Save Changes
          </button>
        </div>
      </form>
    </div>
  )
}

export default NotificationFormModal
