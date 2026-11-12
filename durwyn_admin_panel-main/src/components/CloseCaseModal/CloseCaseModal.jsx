import { useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import { resolutionTypes } from '../../data/mockEmergencies.js'
import './CloseCaseModal.css'

// Confirm dialog opened from the "Close Case" row action (and from the
// Emergency Details modal's footer button) in place of resolving instantly.
function CloseCaseModal({ emergency, onClose, onConfirm }) {
  const [note, setNote] = useState('')
  const [resolutionType, setResolutionType] = useState(resolutionTypes[0])

  function handleSubmit(event) {
    event.preventDefault()
    onConfirm({ note: note.trim(), resolutionType })
  }

  return (
    <div className="close-case-modal__overlay" onMouseDown={onClose}>
      <form
        className="close-case-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Close Case"
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={handleSubmit}
      >
        <div className="close-case-modal__header">
          <p className="close-case-modal__title">Close Case</p>
          <button type="button" className="close-case-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="close-case-modal__body">
          <div className="close-case-modal__intro">
            <span className="close-case-modal__icon">
              <Icon name="check-circle-icon" size={20} />
            </span>
            <p className="close-case-modal__message">
              Mark <strong>{emergency.name}</strong>&apos;s emergency as resolved?
            </p>
          </div>

          <div className="close-case-modal__field">
            <label className="close-case-modal__label" htmlFor="close-case-note">
              Escalation Note
            </label>
            <textarea
              id="close-case-note"
              className="close-case-modal__textarea"
              placeholder="Add context for responders…"
              value={note}
              onChange={(event) => setNote(event.target.value)}
            />
          </div>

          <div className="close-case-modal__field">
            <label className="close-case-modal__label" htmlFor="close-case-resolution">
              Resolution Type
            </label>
            <div className="close-case-modal__select-control">
              <select
                id="close-case-resolution"
                className="close-case-modal__select"
                value={resolutionType}
                onChange={(event) => setResolutionType(event.target.value)}
              >
                {resolutionTypes.map((option) => (
                  <option key={option} value={option}>
                    {option}
                  </option>
                ))}
              </select>
              <Icon name="chevron-down-icon" size={10} className="close-case-modal__chevron" />
            </div>
          </div>

          <div className="close-case-modal__actions">
            <button type="button" className="close-case-modal__button close-case-modal__button--cancel" onClick={onClose}>
              Cancel
            </button>
            <button type="submit" className="close-case-modal__button close-case-modal__button--close">
              Close Case
            </button>
          </div>
        </div>
      </form>
    </div>
  )
}

export default CloseCaseModal
