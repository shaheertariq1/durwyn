import { useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import { priorityLabels, responderOptions } from '../../data/mockEmergencies.js'
import './AssignResponderModal.css'

const PRIORITY_OPTIONS = Object.entries(priorityLabels)

// Form opened from the "Assign Responder" row action; confirming marks the
// emergency responded and applies the chosen priority override.
function AssignResponderModal({ emergency, onClose, onAssign }) {
  const [responder, setResponder] = useState(responderOptions[0])
  const [priority, setPriority] = useState(emergency.priority)

  function handleSubmit(event) {
    event.preventDefault()
    onAssign({ responder, priority })
  }

  return (
    <div className="assign-responder-modal__overlay" onMouseDown={onClose}>
      <form
        className="assign-responder-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Assign Responder"
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={handleSubmit}
      >
        <div className="assign-responder-modal__header">
          <p className="assign-responder-modal__title">Assign Responder</p>
          <button type="button" className="assign-responder-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="assign-responder-modal__body">
          <p className="assign-responder-modal__banner">
            Assigning responder to emergency for <strong>{emergency.name}</strong>
          </p>

          <div className="assign-responder-modal__field">
            <label className="assign-responder-modal__label" htmlFor="assign-responder-select">
              Select Responder
            </label>
            <div className="assign-responder-modal__select-control">
              <select
                id="assign-responder-select"
                className="assign-responder-modal__select"
                value={responder}
                onChange={(event) => setResponder(event.target.value)}
              >
                {responderOptions.map((option) => (
                  <option key={option} value={option}>
                    {option}
                  </option>
                ))}
              </select>
              <Icon name="chevron-down-icon" size={10} className="assign-responder-modal__chevron" />
            </div>
          </div>

          <div className="assign-responder-modal__field">
            <label className="assign-responder-modal__label" htmlFor="assign-responder-priority">
              Priority Override
            </label>
            <div className="assign-responder-modal__select-control">
              <select
                id="assign-responder-priority"
                className="assign-responder-modal__select"
                value={priority}
                onChange={(event) => setPriority(event.target.value)}
              >
                {PRIORITY_OPTIONS.map(([value, label]) => (
                  <option key={value} value={value}>
                    {label}
                  </option>
                ))}
              </select>
              <Icon name="chevron-down-icon" size={10} className="assign-responder-modal__chevron" />
            </div>
          </div>

          <div className="assign-responder-modal__actions">
            <button
              type="button"
              className="assign-responder-modal__button assign-responder-modal__button--cancel"
              onClick={onClose}
            >
              Cancel
            </button>
            <button type="submit" className="assign-responder-modal__button assign-responder-modal__button--assign">
              Assign
            </button>
          </div>
        </div>
      </form>
    </div>
  )
}

export default AssignResponderModal
