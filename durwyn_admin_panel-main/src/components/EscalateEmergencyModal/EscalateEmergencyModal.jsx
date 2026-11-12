import { useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import { escalationTargets } from '../../data/mockEmergencies.js'
import './EscalateEmergencyModal.css'

// Form opened from the "Escalate" row action; confirming bumps the
// emergency's priority a level and records who it was escalated to.
function EscalateEmergencyModal({ emergency, onClose, onEscalate }) {
  const [escalateTo, setEscalateTo] = useState(escalationTargets[0])
  const [note, setNote] = useState('')

  function handleSubmit(event) {
    event.preventDefault()
    onEscalate({ escalateTo, note: note.trim() })
  }

  return (
    <div className="escalate-emergency-modal__overlay" onMouseDown={onClose}>
      <form
        className="escalate-emergency-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Escalate Emergency"
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={handleSubmit}
      >
        <div className="escalate-emergency-modal__header">
          <p className="escalate-emergency-modal__title">Escalate Emergency</p>
          <button type="button" className="escalate-emergency-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="escalate-emergency-modal__body">
          <p className="escalate-emergency-modal__banner">
            <Icon name="activity-alert-circle-icon" size={13} />
            <span>
              Escalating <strong>{emergency.type}</strong> for <strong>{emergency.name}</strong>
            </span>
          </p>

          <div className="escalate-emergency-modal__field">
            <label className="escalate-emergency-modal__label" htmlFor="escalate-to">
              Escalate To
            </label>
            <div className="escalate-emergency-modal__select-control">
              <select
                id="escalate-to"
                className="escalate-emergency-modal__select"
                value={escalateTo}
                onChange={(event) => setEscalateTo(event.target.value)}
              >
                {escalationTargets.map((option) => (
                  <option key={option} value={option}>
                    {option}
                  </option>
                ))}
              </select>
              <Icon name="chevron-down-icon" size={10} className="escalate-emergency-modal__chevron" />
            </div>
          </div>

          <div className="escalate-emergency-modal__field">
            <label className="escalate-emergency-modal__label" htmlFor="escalate-note">
              Escalation Note
            </label>
            <textarea
              id="escalate-note"
              className="escalate-emergency-modal__textarea"
              placeholder="Add context for responders…"
              value={note}
              onChange={(event) => setNote(event.target.value)}
            />
          </div>

          <div className="escalate-emergency-modal__actions">
            <button
              type="button"
              className="escalate-emergency-modal__button escalate-emergency-modal__button--cancel"
              onClick={onClose}
            >
              Cancel
            </button>
            <button type="submit" className="escalate-emergency-modal__button escalate-emergency-modal__button--escalate">
              Escalate Now
            </button>
          </div>
        </div>
      </form>
    </div>
  )
}

export default EscalateEmergencyModal
