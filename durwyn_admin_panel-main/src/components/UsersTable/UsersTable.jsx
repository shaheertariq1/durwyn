import { useNavigate } from 'react-router-dom'
import Icon from '../Icon/Icon.jsx'
import Checkbox from '../Checkbox/Checkbox.jsx'
import Avatar from '../Avatar/Avatar.jsx'
import Badge from '../Badge/Badge.jsx'
import RowActionMenu from '../RowActionMenu/RowActionMenu.jsx'
import { planLabels, statusLabels } from '../../data/mockUsers.js'
import './UsersTable.css'

const PLAN_TONE = { free: 'neutral', standard: 'blue', premium: 'purple' }
const STATUS_TONE = { active: 'green', suspended: 'red' }

const COLUMNS = [
  { key: 'name', label: 'User' },
  { key: 'email', label: 'Email' },
  { key: 'phone', label: 'Phone' },
  { key: 'plan', label: 'Plan' },
  { key: 'status', label: 'Status' },
  { key: 'joined', label: 'Joined' },
]

function SortIcon({ active, direction }) {
  return (
    <span
      className={`users-table__sort-icon${active ? ' users-table__sort-icon--active' : ''}${
        active && direction === 'desc' ? ' users-table__sort-icon--desc' : ''
      }`}
    >
      <Icon name="table-sort-icon" size={11} />
    </span>
  )
}

function UsersTable({
  users,
  sort,
  onSortChange,
  selectedIds,
  onToggleSelect,
  onToggleSelectAll,
  onToggleStatus,
  onDelete,
  onEdit,
}) {
  const navigate = useNavigate()
  const allSelected = users.length > 0 && users.every((user) => selectedIds.has(user.id))

  function handleSort(key) {
    if (sort.key === key) {
      onSortChange({ key, direction: sort.direction === 'asc' ? 'desc' : 'asc' })
    } else {
      onSortChange({ key, direction: 'asc' })
    }
  }

  return (
    <div className="users-table" role="table" aria-label="Users">
      <div className="users-table__row users-table__row--head" role="row">
        <span className="users-table__cell users-table__cell--checkbox">
          <Checkbox
            id="users-select-all"
            label=""
            checked={allSelected}
            onChange={() => onToggleSelectAll(!allSelected)}
          />
        </span>
        {COLUMNS.map((column) => (
          <button
            key={column.key}
            type="button"
            className={`users-table__cell users-table__cell--${column.key} users-table__head-button`}
            onClick={() => handleSort(column.key)}
          >
            {column.label}
            <SortIcon active={sort.key === column.key} direction={sort.direction} />
          </button>
        ))}
        <span className="users-table__cell users-table__cell--actions users-table__cell--actions-head">
          Actions
        </span>
      </div>

      <div className="users-table__body">
        {users.map((user) => (
          <div className="users-table__row" role="row" key={user.id}>
            <span className="users-table__cell users-table__cell--checkbox">
              <Checkbox
                id={`select-${user.id}`}
                label=""
                checked={selectedIds.has(user.id)}
                onChange={() => onToggleSelect(user.id)}
              />
            </span>
            <span className="users-table__cell users-table__cell--name">
              <Avatar name={user.name} size={28} />
              <span className="users-table__identity">
                <button
                  type="button"
                  className="users-table__name-link"
                  onClick={() => navigate(`/dashboard/user/${user.id}`)}
                >
                  {user.name}
                </button>
                <span className="users-table__id">{user.id}</span>
              </span>
            </span>
            <span className="users-table__cell users-table__cell--email">{user.email}</span>
            <span className="users-table__cell users-table__cell--phone users-table__mono">
              {user.phone}
            </span>
            <span className="users-table__cell users-table__cell--plan">
              <Badge tone={PLAN_TONE[user.plan]}>{planLabels[user.plan]}</Badge>
            </span>
            <span className="users-table__cell users-table__cell--status">
              <Badge tone={STATUS_TONE[user.status]}>{statusLabels[user.status]}</Badge>
            </span>
            <span className="users-table__cell users-table__cell--joined">{user.joined}</span>
            <span className="users-table__cell users-table__cell--actions">
              <button
                type="button"
                className="users-table__icon-button"
                aria-label={`View ${user.name}`}
                onClick={() => navigate(`/dashboard/user/${user.id}`)}
              >
                <Icon name="eye-icon" size={13} />
              </button>
              <RowActionMenu
                label={`Actions for ${user.name}`}
                actions={[
                  {
                    label: 'View Profile',
                    icon: 'eye-icon',
                    onClick: () => navigate(`/dashboard/user/${user.id}`),
                  },
                  {
                    label: 'Edit User',
                    icon: 'action-edit-icon',
                    onClick: () => onEdit(user),
                  },
                  {
                    label: user.status === 'active' ? 'Suspend User' : 'Activate User',
                    icon: user.status === 'active' ? 'action-suspend-icon' : 'check-circle-icon',
                    onClick: () => onToggleStatus(user.id),
                  },
                  {
                    label: 'Delete User',
                    icon: 'action-delete-icon',
                    tone: 'red',
                    onClick: () => onDelete(user.id),
                  },
                ]}
              />
            </span>
          </div>
        ))}

        {users.length === 0 && (
          <p className="users-table__empty">No users match the current search and filters.</p>
        )}
      </div>
    </div>
  )
}

export default UsersTable
