import { useState } from 'react'
import SettingsField from '../../../components/SettingsField/SettingsField.jsx'
import avatarElena from '../../../assets/avatar-elena.png'
import { initialProfile } from '../../../data/mockSettings.js'
import './ProfileTab.css'

function ProfileTab() {
  const [profile, setProfile] = useState(initialProfile)

  function updateField(field) {
    return (event) => setProfile((current) => ({ ...current, [field]: event.target.value }))
  }

  function handleSubmit(event) {
    event.preventDefault()
    // No backend yet — mock data only, so submitting just keeps local state.
  }

  return (
    <form className="settings-panel profile-tab" onSubmit={handleSubmit}>
      <div className="profile-tab__header">
        <img className="profile-tab__avatar" src={avatarElena} alt="" />
        <div className="profile-tab__identity">
          <p className="profile-tab__name">{profile.displayName}</p>
          <p className="profile-tab__email">{profile.email}</p>
          <button type="button" className="profile-tab__change-photo">
            Change photo
          </button>
        </div>
      </div>

      <div className="settings-field-row">
        <SettingsField
          id="profile-first-name"
          label="First Name"
          value={profile.firstName}
          onChange={updateField('firstName')}
        />
        <SettingsField
          id="profile-last-name"
          label="Last Name"
          value={profile.lastName}
          onChange={updateField('lastName')}
        />
      </div>

      <SettingsField
        id="profile-second-first-name"
        label="First Name"
        value={profile.secondFirstName}
        onChange={updateField('secondFirstName')}
      />

      <div className="settings-field-row">
        <SettingsField
          id="profile-phone"
          label="Phone "
          value={profile.phone}
          onChange={updateField('phone')}
        />
        <SettingsField id="profile-role" label="Role" value={profile.role} readOnly filled />
      </div>

      <button type="submit" className="settings-save-button settings-save-button--sm">
        Save Changes
      </button>
    </form>
  )
}

export default ProfileTab
