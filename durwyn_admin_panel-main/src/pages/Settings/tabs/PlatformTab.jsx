import { useState } from 'react'
import Icon from '../../../components/Icon/Icon.jsx'
import Toggle from '../../../components/Toggle/Toggle.jsx'
import SettingsSelect from '../../../components/SettingsSelect/SettingsSelect.jsx'
import {
  dataRetentionOptions,
  initialFeatureToggles,
  initialMaintenanceMode,
  initialPlatformConfig,
  languageOptions,
  platformNameOptions,
  timezoneOptions,
} from '../../../data/mockSettings.js'
import './PlatformTab.css'

function PlatformTab() {
  const [config, setConfig] = useState(initialPlatformConfig)
  const [featureToggles, setFeatureToggles] = useState(initialFeatureToggles)
  const [maintenanceMode, setMaintenanceMode] = useState(initialMaintenanceMode)

  function updateConfig(field) {
    return (event) => setConfig((current) => ({ ...current, [field]: event.target.value }))
  }

  function toggleFeature(id) {
    setFeatureToggles((current) =>
      current.map((feature) => (feature.id === id ? { ...feature, enabled: !feature.enabled } : feature)),
    )
  }

  return (
    <div className="settings-panel-stack platform-tab">
      <section className="settings-panel">
        <div className="settings-panel__head">
          <span className="settings-icon-chip settings-icon-chip--green">
            <Icon name="settings-general-config-icon" size={17} />
          </span>
          <p className="settings-panel__title">General Configuration</p>
        </div>

        <div className="settings-field-row">
          <SettingsSelect
            id="platform-name"
            label="Platform Name"
            value={config.platformName}
            onChange={updateConfig('platformName')}
            options={platformNameOptions}
          />
          <SettingsSelect
            id="platform-language"
            label="Language"
            value={config.language}
            onChange={updateConfig('language')}
            options={languageOptions}
          />
        </div>

        <div className="settings-field-row">
          <SettingsSelect
            id="platform-timezone"
            label="Timezone"
            value={config.timezone}
            onChange={updateConfig('timezone')}
            options={timezoneOptions}
          />
          <SettingsSelect
            id="platform-data-retention"
            label="Data Retention"
            value={config.dataRetention}
            onChange={updateConfig('dataRetention')}
            options={dataRetentionOptions}
          />
        </div>
      </section>

      <section className="settings-panel">
        <div className="settings-panel__head">
          <span className="settings-icon-chip settings-icon-chip--blue">
            <Icon name="settings-feature-toggles-icon" size={17} />
          </span>
          <p className="settings-panel__title">Feature Toggles</p>
        </div>

        {featureToggles.map((feature) => (
          <div key={feature.id} className="settings-toggle-row">
            <div>
              <p className="settings-toggle-row__title">{feature.label}</p>
              <p className="settings-toggle-row__description">{feature.description}</p>
            </div>
            <Toggle
              checked={feature.enabled}
              onChange={() => toggleFeature(feature.id)}
              label={feature.label}
            />
          </div>
        ))}
      </section>

      <section className="settings-panel platform-tab__maintenance">
        <div className="settings-panel__head">
          <span className="settings-icon-chip settings-icon-chip--neutral">
            <Icon name="settings-maintenance-icon" size={17} />
          </span>
          <div className="settings-panel__head-text">
            <p className="settings-panel__title">Maintenance Mode</p>
            <p className="settings-panel__subtitle">Take platform offline</p>
          </div>
          <Toggle
            checked={maintenanceMode}
            onChange={setMaintenanceMode}
            label="Maintenance Mode"
          />
        </div>
      </section>
    </div>
  )
}

export default PlatformTab
