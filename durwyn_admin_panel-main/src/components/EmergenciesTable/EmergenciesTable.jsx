import Avatar from '../Avatar/Avatar.jsx'
import Badge from '../Badge/Badge.jsx'
import RowActionMenu from '../RowActionMenu/RowActionMenu.jsx'
import {
  priorityLabels,
  priorityTone,
  statusLabels,
  statusTone,
  responseLabels,
  responseTone,
} from '../../data/mockEmergencies.js'
import './EmergenciesTable.css'

const COLUMNS = [
  { key: 'user', label: 'User' },
  { key: 'type', label: 'Type' },
  { key: 'priority', label: 'Priority' },
  { key: 'status', label: 'Status' },
  { key: 'duration', label: 'Duration' },
  { key: 'started', label: 'Started' },
  { key: 'contact', label: 'Contact' },
  { key: 'response', label: 'Response' },
]

function EmergenciesTable({ emergencies, onViewDetails, onRequestClose, onRequestCancel, onRequestAssign, onRequestEscalate, onDownload }) {
  return (
    <div className="emergencies-table" role="table" aria-label="Emergencies">
      <div className="emergencies-table__row emergencies-table__row--head" role="row">
        {COLUMNS.map((column) => (
          <span key={column.key} className={`emergencies-table__cell emergencies-table__cell--${column.key}`}>
            {column.label}
          </span>
        ))}
        <span className="emergencies-table__cell emergencies-table__cell--actions">Actions</span>
      </div>

      <div className="emergencies-table__body">
        {emergencies.map((emergency) => (
          <div className="emergencies-table__row" role="row" key={emergency.id}>
            <span className="emergencies-table__cell emergencies-table__cell--user">
              <Avatar name={emergency.name} size={24} />
              <span className="emergencies-table__name">{emergency.name}</span>
            </span>
            <span className="emergencies-table__cell emergencies-table__cell--type">{emergency.type}</span>
            <span className="emergencies-table__cell emergencies-table__cell--priority">
              <Badge tone={priorityTone[emergency.priority]}>{priorityLabels[emergency.priority]}</Badge>
            </span>
            <span className="emergencies-table__cell emergencies-table__cell--status">
              <Badge tone={statusTone[emergency.status]} dot={emergency.status === 'active'}>
                {statusLabels[emergency.status]}
              </Badge>
            </span>
            <span className="emergencies-table__cell emergencies-table__cell--duration emergencies-table__mono">
              {emergency.duration}
            </span>
            <span className="emergencies-table__cell emergencies-table__cell--started">{emergency.started}</span>
            <span className="emergencies-table__cell emergencies-table__cell--contact">{emergency.contact}</span>
            <span className="emergencies-table__cell emergencies-table__cell--response">
              <Badge tone={responseTone[emergency.response]}>{responseLabels[emergency.response]}</Badge>
            </span>
            <span className="emergencies-table__cell emergencies-table__cell--actions">
              <RowActionMenu
                label={`Actions for ${emergency.name}'s ${emergency.type} emergency`}
                actions={[
                  {
                    label: 'View Details',
                    icon: 'action-view-icon',
                    onClick: () => onViewDetails(emergency.id),
                  },
                  {
                    label: 'Assign Responder',
                    icon: 'activity-user-add-icon',
                    onClick: () => onRequestAssign(emergency.id),
                  },
                  {
                    label: 'Escalate',
                    icon: 'action-escalate-icon',
                    onClick: () => onRequestEscalate(emergency.id),
                  },
                  {
                    label: 'Download Report',
                    icon: 'action-export-icon',
                    onClick: () => onDownload(emergency),
                  },
                  {
                    label: emergency.status === 'resolved' ? 'Reopen Case' : 'Close Case',
                    icon: 'activity-check-circle-icon',
                    onClick: () => onRequestClose(emergency.id),
                  },
                  {
                    label: 'Cancel Emergency',
                    icon: 'action-suspend-icon',
                    tone: 'red',
                    onClick: () => onRequestCancel(emergency.id),
                  },
                ]}
              />
            </span>
          </div>
        ))}

        {emergencies.length === 0 && (
          <p className="emergencies-table__empty">No emergencies match the current search and filters.</p>
        )}
      </div>
    </div>
  )
}

export default EmergenciesTable
