import { statusLabels } from '../../data/mockContacts.js'
import './ContactDetailsModal.css'

const ROWS = [
  { key: 'phone', label: 'Phone' },
  { key: 'status', label: 'Status', format: (contact) => statusLabels[contact.status] },
  { key: 'id', label: 'ID' },
]

function initialsFor(name) {
  const parts = name.trim().split(/\s+/)
  return `${parts[0]?.[0] ?? ''}${parts[1]?.[0] ?? ''}`.toUpperCase()
}

// Read-only summary opened from the "View" row action.
function ContactDetailsModal({ contact, onClose }) {
  return (
    <div className="contact-details-modal__overlay" onMouseDown={onClose}>
      <div
        className="contact-details-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Contact Details"
        onMouseDown={(event) => event.stopPropagation()}
      >
        <div className="contact-details-modal__header">
          <p className="contact-details-modal__title">Contact Details</p>
          <button type="button" className="contact-details-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="contact-details-modal__body">
          <div className="contact-details-modal__identity">
            <span className="contact-details-modal__avatar">{initialsFor(contact.name)}</span>
            <span className="contact-details-modal__identity-text">
              <span className="contact-details-modal__name">{contact.name}</span>
              <span className="contact-details-modal__subtitle">
                {contact.relationship} of {contact.assignedUserName}
              </span>
            </span>
          </div>

          {ROWS.map((row) => (
            <div className="contact-details-modal__row" key={row.key}>
              <span className="contact-details-modal__label">{row.label}</span>
              <span className="contact-details-modal__value">
                {row.format ? row.format(contact) : contact[row.key]}
              </span>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}

export default ContactDetailsModal
