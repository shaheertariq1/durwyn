import { useState } from 'react'
import SettingsField from '../../../components/SettingsField/SettingsField.jsx'
import Icon from '../../../components/Icon/Icon.jsx'
import { passwordRequirements } from '../../../data/mockSettings.js'
import './PasswordTab.css'

const INITIAL_FORM = { current: '', next: '', confirm: '' }
const INITIAL_VISIBILITY = { current: false, next: false, confirm: false }

function PasswordTab() {
  const [form, setForm] = useState(INITIAL_FORM)
  const [visible, setVisible] = useState(INITIAL_VISIBILITY)

  function updateField(field) {
    return (event) => setForm((current) => ({ ...current, [field]: event.target.value }))
  }

  function toggleVisibility(field) {
    setVisible((current) => ({ ...current, [field]: !current[field] }))
  }

  function handleSubmit(event) {
    event.preventDefault()
    // No backend yet — mock data only, so submitting just keeps local state.
  }

  function eyeButton(field) {
    return (
      <button
        type="button"
        className="settings-field__trailing-button"
        onClick={() => toggleVisibility(field)}
        aria-label={visible[field] ? 'Hide password' : 'Show password'}
      >
        <Icon name={visible[field] ? 'eye-off-icon' : 'eye-icon'} size={20} />
      </button>
    )
  }

  return (
    <form className="settings-panel" onSubmit={handleSubmit}>
      <SettingsField
        id="password-current"
        label="Current Password"
        icon="lock-icon"
        prominent
        type={visible.current ? 'text' : 'password'}
        placeholder="Current password enter"
        value={form.current}
        onChange={updateField('current')}
        trailing={eyeButton('current')}
      />

      <SettingsField
        id="password-new"
        label="New Password"
        icon="lock-icon"
        prominent
        type={visible.next ? 'text' : 'password'}
        placeholder="Confirm your password"
        value={form.next}
        onChange={updateField('next')}
        trailing={eyeButton('next')}
      />

      <SettingsField
        id="password-confirm"
        label="Confirm New Password"
        icon="lock-icon"
        prominent
        type={visible.confirm ? 'text' : 'password'}
        placeholder="Confirm your password"
        value={form.confirm}
        onChange={updateField('confirm')}
        trailing={eyeButton('confirm')}
      />

      <ul className="password-tab__requirements">
        {passwordRequirements.map((requirement) => {
          const met = requirement.test(form.next)
          return (
            <li
              key={requirement.id}
              className={`password-tab__requirement${met ? ' password-tab__requirement--met' : ''}`}
            >
              <Icon name="check-circle-icon" size={11} />
              {requirement.label}
            </li>
          )
        })}
      </ul>

      <button type="submit" className="settings-save-button">
        Update Password
      </button>
    </form>
  )
}

export default PasswordTab
