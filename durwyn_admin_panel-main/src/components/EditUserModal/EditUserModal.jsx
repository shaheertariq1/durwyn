import { useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import { planLabels, statusLabels } from '../../data/mockUsers.js'
import './EditUserModal.css'

const PLAN_OPTIONS = Object.entries(planLabels)
const STATUS_OPTIONS = Object.entries(statusLabels)

// Overlay form for editing a user's core profile fields, opened from the
// "Edit" action on the user detail header and the users table row menu.
function EditUserModal({ user, onClose, onSave }) {
  const [name, setName] = useState(user.name)
  const [email, setEmail] = useState(user.email)
  const [phone, setPhone] = useState(user.phone)
  const [plan, setPlan] = useState(user.plan)
  const [status, setStatus] = useState(user.status)

  function handleSubmit(event) {
    event.preventDefault()
    onSave({ name: name.trim(), email: email.trim(), phone: phone.trim(), plan, status })
  }

  return (
    <div className="edit-user-modal__overlay" onMouseDown={onClose}>
      <form
        className="edit-user-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Edit User"
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={handleSubmit}
      >
        <div className="edit-user-modal__header">
          <p className="edit-user-modal__title">Edit User</p>
          <button type="button" className="edit-user-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="edit-user-modal__body">
          <div className="edit-user-modal__field">
            <label className="edit-user-modal__label" htmlFor="edit-user-name">
              Full Name
            </label>
            <input
              id="edit-user-name"
              className="edit-user-modal__input"
              value={name}
              onChange={(event) => setName(event.target.value)}
            />
          </div>

          <div className="edit-user-modal__row">
            <div className="edit-user-modal__field">
              <label className="edit-user-modal__label" htmlFor="edit-user-email">
                Email
              </label>
              <input
                id="edit-user-email"
                type="email"
                className="edit-user-modal__input"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
              />
            </div>
            <div className="edit-user-modal__field">
              <label className="edit-user-modal__label" htmlFor="edit-user-phone">
                Phone
              </label>
              <input
                id="edit-user-phone"
                className="edit-user-modal__input"
                value={phone}
                onChange={(event) => setPhone(event.target.value)}
              />
            </div>
          </div>

          <div className="edit-user-modal__row">
            <div className="edit-user-modal__field">
              <label className="edit-user-modal__label" htmlFor="edit-user-plan">
                Plan
              </label>
              <div className="edit-user-modal__select-control">
                <select
                  id="edit-user-plan"
                  className="edit-user-modal__select"
                  value={plan}
                  onChange={(event) => setPlan(event.target.value)}
                >
                  {PLAN_OPTIONS.map(([value, label]) => (
                    <option key={value} value={value}>
                      {label}
                    </option>
                  ))}
                </select>
                <Icon name="chevron-down-icon" size={10} className="edit-user-modal__chevron" />
              </div>
            </div>
            <div className="edit-user-modal__field">
              <label className="edit-user-modal__label" htmlFor="edit-user-status">
                Status
              </label>
              <div className="edit-user-modal__select-control">
                <select
                  id="edit-user-status"
                  className="edit-user-modal__select"
                  value={status}
                  onChange={(event) => setStatus(event.target.value)}
                >
                  {STATUS_OPTIONS.map(([value, label]) => (
                    <option key={value} value={value}>
                      {label}
                    </option>
                  ))}
                </select>
                <Icon name="chevron-down-icon" size={10} className="edit-user-modal__chevron" />
              </div>
            </div>
          </div>
        </div>

        <div className="edit-user-modal__actions">
          <button type="button" className="edit-user-modal__button edit-user-modal__button--cancel" onClick={onClose}>
            Cancel
          </button>
          <button type="submit" className="edit-user-modal__button edit-user-modal__button--save">
            Save Changes
          </button>
        </div>
      </form>
    </div>
  )
}

export default EditUserModal
