import { useState } from 'react'
import Toggle from '../../../components/Toggle/Toggle.jsx'
import Badge from '../../../components/Badge/Badge.jsx'
import Icon from '../../../components/Icon/Icon.jsx'
import SettingsSelect from '../../../components/SettingsSelect/SettingsSelect.jsx'
import {
  initialSecurity,
  initialSessions,
  sessionTimeoutOptions,
} from '../../../data/mockSettings.js'
import './SecurityTab.css'
import './SecurityTab.css'

function SecurityTab() {
  const [loginAlerts, setLoginAlerts] = useState(initialSecurity.loginAlerts)
  const [sessionTimeout, setSessionTimeout] = useState(initialSecurity.sessionTimeout)
  const [sessions, setSessions] = useState(initialSessions)
  const [ipWhitelist, setIpWhitelist] = useState(initialSecurity.ipWhitelist)

  function revokeSession(id) {
    setSessions((current) => current.filter((session) => session.id !== id))
  }

  function revokeAllOthers() {
    setSessions((current) => current.filter((session) => session.current))
  }

  function handleSubmit(event) {
    event.preventDefault()
    // No backend yet — mock data only, so submitting just keeps local state.
  }

  return (
    <div className="settings-panel-stack">
      <section className="settings-panel">
        <div className="settings-panel__head">
          <span className="settings-icon-chip settings-icon-chip--blue">
            <Icon name="settings-login-alerts-icon" size={17} />
          </span>
          <div className="settings-panel__head-text">
            <p className="settings-panel__title">Login Alerts</p>
            <p className="settings-panel__subtitle">Email on every sign-in</p>
          </div>
          <Toggle checked={loginAlerts} onChange={setLoginAlerts} label="Login Alerts" />
        </div>

        <SettingsSelect
          id="session-timeout"
          label="Session Timeout"
          value={sessionTimeout}
          onChange={(event) => setSessionTimeout(event.target.value)}
          options={sessionTimeoutOptions}
        />
      </section>

      <section className="settings-panel">
        <div className="security-tab__sessions-head">
          <div className="settings-panel__head">
            <span className="settings-icon-chip settings-icon-chip--purple">
              <Icon name="settings-active-sessions-icon" size={17} />
            </span>
            <div className="settings-panel__head-text">
              <p className="settings-panel__title">Active Sessions</p>
              <p className="settings-panel__subtitle">{sessions.length} active</p>
            </div>
          </div>
          <button type="button" className="security-tab__revoke-all" onClick={revokeAllOthers}>
            Revoke all others
          </button>
        </div>

        <div className="security-tab__sessions-list">
          {sessions.map((session) => (
            <div key={session.id} className="security-tab__session-row">
              <div className="security-tab__session-info">
                <span
                  className={`security-tab__session-dot${session.current ? ' security-tab__session-dot--current' : ''}`}
                />
                <div>
                  <p className="security-tab__session-device">{session.device}</p>
                  <p className="security-tab__session-meta">{session.meta}</p>
                </div>
              </div>
              {session.current ? (
                <Badge tone="green">Current</Badge>
              ) : (
                <button
                  type="button"
                  className="security-tab__revoke"
                  onClick={() => revokeSession(session.id)}
                >
                  Revoke
                </button>
              )}
            </div>
          ))}
        </div>
      </section>

      <form className="settings-panel" onSubmit={handleSubmit}>
        <div className="settings-panel__head">
          <span className="settings-icon-chip settings-icon-chip--amber">
            <Icon name="settings-ip-whitelist-icon" size={17} />
          </span>
          <div className="settings-panel__head-text">
            <p className="settings-panel__title">IP Whitelist</p>
            <p className="settings-panel__subtitle">One IP/CIDR per line</p>
          </div>
        </div>

        <textarea
          className="security-tab__ip-textarea"
          value={ipWhitelist}
          onChange={(event) => setIpWhitelist(event.target.value)}
          aria-label="IP Whitelist"
        />

        <button type="submit" className="settings-save-button settings-save-button--sm">
          Save Security Settings
        </button>
      </form>
    </div>
  )
}

export default SecurityTab
