import { useNavigate } from 'react-router-dom'
import Avatar from '../Avatar/Avatar.jsx'
import Badge from '../Badge/Badge.jsx'
import RowActionMenu from '../RowActionMenu/RowActionMenu.jsx'
import { statusLabels, statusTone } from '../../data/mockContacts.js'
import './ContactsTable.css'

const COLUMNS = [
  { key: 'contact', label: 'Contact' },
  { key: 'relationship', label: 'Relationship' },
  { key: 'assignedUser', label: 'Assigned User' },
  { key: 'phone', label: 'Phone' },
  { key: 'status', label: 'Status' },
]

function ContactsTable({ contacts, onView, onEdit, onToggleStatus, onDelete }) {
  const navigate = useNavigate()

  return (
    <div className="contacts-table" role="table" aria-label="Emergency contacts">
      <div className="contacts-table__row contacts-table__row--head" role="row">
        {COLUMNS.map((column) => (
          <span key={column.key} className={`contacts-table__cell contacts-table__cell--${column.key}`}>
            {column.label}
          </span>
        ))}
        <span className="contacts-table__cell contacts-table__cell--actions">Actions</span>
      </div>

      <div className="contacts-table__body">
        {contacts.map((contact) => (
          <div className="contacts-table__row" role="row" key={contact.id}>
            <span className="contacts-table__cell contacts-table__cell--contact">
              <Avatar name={contact.name} size={28} />
              <span className="contacts-table__identity">
                <span className="contacts-table__name">{contact.name}</span>
                <span className="contacts-table__id">{contact.id}</span>
              </span>
            </span>
            <span className="contacts-table__cell contacts-table__cell--relationship">
              {contact.relationship}
            </span>
            <span className="contacts-table__cell contacts-table__cell--assignedUser">
              <button
                type="button"
                className="contacts-table__user-link"
                onClick={() => navigate(`/dashboard/user/${contact.assignedUserId}`)}
              >
                {contact.assignedUserName}
              </button>
            </span>
            <span className="contacts-table__cell contacts-table__cell--phone contacts-table__mono">
              {contact.phone}
            </span>
            <span className="contacts-table__cell contacts-table__cell--status">
              <Badge tone={statusTone[contact.status]}>{statusLabels[contact.status]}</Badge>
            </span>
            <span className="contacts-table__cell contacts-table__cell--actions">
              <RowActionMenu
                label={`Actions for ${contact.name}`}
                actions={[
                  {
                    label: 'View',
                    icon: 'eye-icon',
                    onClick: () => onView(contact),
                  },
                  {
                    label: 'Edit',
                    icon: 'action-edit-icon',
                    onClick: () => onEdit(contact),
                  },
                  {
                    label: contact.status === 'active' ? 'Deactivate' : 'Activate',
                    icon: contact.status === 'active' ? 'action-suspend-icon' : 'check-circle-icon',
                    onClick: () => onToggleStatus(contact.id),
                  },
                  { label: 'Remove', icon: 'action-delete-icon', tone: 'red', onClick: () => onDelete(contact.id) },
                ]}
              />
            </span>
          </div>
        ))}

        {contacts.length === 0 && (
          <p className="contacts-table__empty">No emergency contacts match the current search.</p>
        )}
      </div>
    </div>
  )
}

export default ContactsTable
