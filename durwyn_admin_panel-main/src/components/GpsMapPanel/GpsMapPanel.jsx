import { useId, useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import Badge from '../Badge/Badge.jsx'
import gpsMap from '../../assets/gps-history-map.jpg'
import './GpsMapPanel.css'

const MARKER_TONE_CLASS = {
  start: 'gps-map-panel__marker--start',
  waypoint: 'gps-map-panel__marker--waypoint',
  current: 'gps-map-panel__marker--current',
}

// Right-hand panel of GPS History — shows the selected user's last known
// location on the map plus a scrubber over their recorded route for the day.
function GpsMapPanel({ user, history }) {
  const sliderId = useId()
  const [progress, setProgress] = useState(history.playback.progress)
  const hasRoute = history.points.length > 0 && history.playback.start !== '—'

  return (
    <div className="gps-map-panel">
      <div className="gps-map-panel__header">
        <div className="gps-map-panel__title">
          <Icon name="gps-pin-icon" size={14} className="gps-map-panel__pin-icon" />
          <span className="gps-map-panel__name">{user.name}</span>
          {history.live && <Badge tone="green">Live</Badge>}
        </div>
        <span className="gps-map-panel__location">{user.location}</span>
      </div>

      <div className="gps-map-panel__map">
        <img className="gps-map-panel__map-image" src={gpsMap} alt={`Map of ${user.name}'s recorded route`} />
        {history.points.map((point, index) => (
          <span
            key={index}
            className={`gps-map-panel__marker ${MARKER_TONE_CLASS[point.tone]}`}
            style={{ left: `${point.x}%`, top: `${point.y}%` }}
          />
        ))}
        {!hasRoute && (
          <div className="gps-map-panel__no-route">No GPS activity recorded for this user yet.</div>
        )}
      </div>

      <div className="gps-map-panel__playback">
        <p className="gps-map-panel__playback-heading">Playback</p>
        <div className="gps-map-panel__playback-row">
          <span className="gps-map-panel__time">{history.playback.start}</span>
          <label className="sr-only" htmlFor={sliderId}>
            Playback position for {user.name}
          </label>
          <input
            id={sliderId}
            type="range"
            className="gps-map-panel__slider"
            min={0}
            max={100}
            value={progress}
            disabled={!hasRoute}
            onChange={(event) => setProgress(Number(event.target.value))}
            style={{ '--progress': `${progress}%` }}
          />
          <span className="gps-map-panel__time">{history.playback.end}</span>
        </div>
      </div>
    </div>
  )
}

export default GpsMapPanel
