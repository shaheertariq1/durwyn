import Icon from '../Icon/Icon.jsx'
import Badge from '../Badge/Badge.jsx'
import { priorityLabels, priorityTone, statusLabels, statusTone } from '../../data/mockHelpSupport.js'
import './TicketList.css'

// Row list of support tickets shown on the Help & Support "Tickets" tab.
function TicketList({ tickets }) {
  return (
    <ul className="ticket-list">
      {tickets.map((ticket) => (
        <li key={ticket.id} className="ticket-list__row">
          <div className="ticket-list__lead">
            <span className="ticket-list__icon">
              <Icon name="help-ticket-icon" size={14} />
            </span>
            <div className="ticket-list__text">
              <p className="ticket-list__title">{ticket.title}</p>
              <p className="ticket-list__meta">
                {ticket.id} · {ticket.date}
              </p>
            </div>
          </div>
          <div className="ticket-list__badges">
            <Badge tone={priorityTone[ticket.priority]}>{priorityLabels[ticket.priority]}</Badge>
            <Badge tone={statusTone[ticket.status]}>{statusLabels[ticket.status]}</Badge>
          </div>
        </li>
      ))}
    </ul>
  )
}

export default TicketList
