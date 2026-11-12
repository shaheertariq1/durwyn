import Icon from '../Icon/Icon.jsx'
import './CancelEmergencyModal.css'

// Confirm dialog opened from the "Cancel Emergency" row action in place of
// firing the mutation immediately.
function CancelEmergencyModal({ emergency, onClose, onConfirm }) {
  return (
    <div className="cancel-emergency-modal__overlay" onMouseDown={onClose}>
      <div
        className="cancel-emergency-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Cancel Emergency"
        onMouseDown={(event) => event.stopPropagation()}
      >
        <div className="cancel-emergency-modal__header">
          <p className="cancel-emergency-modal__title">Cancel Emergency</p>
          <button type="button" className="cancel-emergency-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="cancel-emergency-modal__body">
          <span className="cancel-emergency-modal__icon">
            <Icon name="x-circle-icon" size={22} />
          </span>
          <p className="cancel-emergency-modal__message">
            Cancel <strong>{emergency.name}</strong>&apos;s emergency?
          </p>
          <p className="cancel-emergency-modal__description">Status will be set to Cancelled.</p>

          <div className="cancel-emergency-modal__actions">
            <button
              type="button"
              className="cancel-emergency-modal__button cancel-emergency-modal__button--keep"
              onClick={onClose}
            >
              Keep Active
            </button>
            <button
              type="button"
              className="cancel-emergency-modal__button cancel-emergency-modal__button--cancel"
              onClick={onConfirm}
            >
              Cancel Emergency
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default CancelEmergencyModal
