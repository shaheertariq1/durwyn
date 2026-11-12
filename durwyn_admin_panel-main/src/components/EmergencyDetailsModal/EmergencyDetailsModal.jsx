import Icon from '../Icon/Icon.jsx'
import { priorityLabels, responseLabels, statusLabels, statusTone } from '../../data/mockEmergencies.js'
import './EmergencyDetailsModal.css'

const FIELDS = [
  { key: 'id', label: 'Event ID' },
  { key: 'name', label: 'User' },
  { key: 'type', label: 'Type' },
  { key: 'priority', label: 'Priority', format: (emergency) => priorityLabels[emergency.priority] },
  { key: 'status', label: 'Status', format: (emergency) => statusLabels[emergency.status] },
  { key: 'duration', label: 'Duration' },
  { key: 'started', label: 'Started' },
  { key: 'contact', label: 'Emergency Contact' },
  { key: 'response', label: 'Response Status', format: (emergency) => responseLabels[emergency.response] },
]

// Read-only summary opened from the "View Details" row action; its own
// footer re-triggers the Close Case flow and the CSV download.
function EmergencyDetailsModal({ emergency, onClose, onRequestClose, onDownload }) {
  const tone = statusTone[emergency.status]

  return (
    <div className="emergency-details-modal__overlay" onMouseDown={onClose}>
      <div
        className="emergency-details-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Emergency Details"
        onMouseDown={(event) => event.stopPropagation()}
      >
        <div className="emergency-details-modal__header">
          <p className="emergency-details-modal__title">Emergency Details</p>
          <button type="button" className="emergency-details-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="emergency-details-modal__body">
          <div className={`emergency-details-modal__banner emergency-details-modal__banner--${tone}`}>
            <span className="emergency-details-modal__banner-dot" aria-hidden="true" />
            {statusLabels[emergency.status]} — {priorityLabels[emergency.priority]} Priority
          </div>

          <div className="emergency-details-modal__grid">
            {FIELDS.map((field) => (
              <div className="emergency-details-modal__cell" key={field.key}>
                <p className="emergency-details-modal__label">{field.label}</p>
                <p className="emergency-details-modal__value">
                  {field.format ? field.format(emergency) : emergency[field.key]}
                </p>
              </div>
            ))}
          </div>

          <div className="emergency-details-modal__actions">
            <button
              type="button"
              className="emergency-details-modal__button emergency-details-modal__button--primary"
              onClick={() => onRequestClose(emergency.id)}
            >
              <Icon name="check-circle-icon" size={14} />
              {emergency.status === 'resolved' ? 'Reopen Case' : 'Close Case'}
            </button>
            <button
              type="button"
              className="emergency-details-modal__button emergency-details-modal__button--secondary"
              onClick={() => onDownload(emergency)}
            >
              <Icon name="action-export-icon" size={14} />
              Download Report
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default EmergencyDetailsModal
