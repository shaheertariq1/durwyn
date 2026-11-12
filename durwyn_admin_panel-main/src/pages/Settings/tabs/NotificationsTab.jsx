import { useState } from 'react'
import Toggle from '../../../components/Toggle/Toggle.jsx'
import { initialNotificationPreferences } from '../../../data/mockSettings.js'

function NotificationsTab() {
  const [preferences, setPreferences] = useState(initialNotificationPreferences)

  function togglePreference(id) {
    setPreferences((current) =>
      current.map((preference) =>
        preference.id === id ? { ...preference, enabled: !preference.enabled } : preference,
      ),
    )
  }

  function handleSubmit(event) {
    event.preventDefault()
    // No backend yet — mock data only, so submitting just keeps local state.
  }

  return (
    <form className="settings-panel" onSubmit={handleSubmit}>
      <p className="settings-panel__title">Notification Preferences</p>

      {preferences.map((preference) => (
        <div key={preference.id} className="settings-toggle-row">
          <div>
            <p className="settings-toggle-row__title">{preference.label}</p>
            <p className="settings-toggle-row__description">{preference.description}</p>
          </div>
          <Toggle
            checked={preference.enabled}
            onChange={() => togglePreference(preference.id)}
            label={preference.label}
          />
        </div>
      ))}

      <button type="submit" className="settings-save-button">
        Save
      </button>
    </form>
  )
}

export default NotificationsTab
