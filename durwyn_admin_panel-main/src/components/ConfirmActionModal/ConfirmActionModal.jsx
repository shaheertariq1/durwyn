import Icon from '../Icon/Icon.jsx'
import './ConfirmActionModal.css'

const CONFIG = {
  activate: {
    title: 'Activate User',
    icon: 'check-circle-icon',
    tone: 'green',
    actionLabel: 'Activate',
    description: 'The user will regain full access.',
  },
  suspend: {
    title: 'Suspend User',
    icon: 'action-suspend-icon',
    tone: 'amber',
    actionLabel: 'Suspend',
    description: 'The user will lose access to the platform.',
  },
  delete: {
    title: 'Delete User',
    icon: 'action-delete-icon',
    tone: 'red',
    actionLabel: 'Delete',
    description: 'All data, emergencies, and history will be permanently removed.',
  },
  removeContact: {
    title: 'Remove Contact',
    icon: 'action-delete-icon',
    tone: 'red',
    actionLabel: 'Remove',
    description: (contact) => `They will be removed from ${contact.assignedUserName}'s contacts.`,
  },
}

// Shared confirm dialog for the Activate / Suspend / Delete row actions on
// the users table and the Remove action on the emergency contacts table,
// opened in place of firing the mutation immediately.
function ConfirmActionModal({ type, user, onClose, onConfirm }) {
  const config = CONFIG[type]
  const description =
    typeof config.description === 'function' ? config.description(user) : config.description

  return (
    <div className="confirm-action-modal__overlay" onMouseDown={onClose}>
      <div
        className="confirm-action-modal"
        role="dialog"
        aria-modal="true"
        aria-label={config.title}
        onMouseDown={(event) => event.stopPropagation()}
      >
        <div className="confirm-action-modal__header">
          <p className="confirm-action-modal__title">{config.title}</p>
          <button type="button" className="confirm-action-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="confirm-action-modal__body">
          <span className={`confirm-action-modal__icon confirm-action-modal__icon--${config.tone}`}>
            <Icon name={config.icon} size={20} />
          </span>
          <p className="confirm-action-modal__message">
            {config.actionLabel} <strong>{user.name}</strong>?
          </p>
          <p className="confirm-action-modal__description">{description}</p>

          <div className="confirm-action-modal__actions">
            <button
              type="button"
              className="confirm-action-modal__button confirm-action-modal__button--cancel"
              onClick={onClose}
            >
              Cancel
            </button>
            <button
              type="button"
              className={`confirm-action-modal__button confirm-action-modal__button--${config.tone}`}
              onClick={onConfirm}
            >
              {config.actionLabel}
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default ConfirmActionModal
