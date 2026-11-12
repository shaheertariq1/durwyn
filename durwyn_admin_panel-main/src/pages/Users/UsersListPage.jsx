import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import SearchInput from '../../components/SearchInput/SearchInput.jsx'
import FilterPills from '../../components/FilterPills/FilterPills.jsx'
import UsersTable from '../../components/UsersTable/UsersTable.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import EditUserModal from '../../components/EditUserModal/EditUserModal.jsx'
import ConfirmActionModal from '../../components/ConfirmActionModal/ConfirmActionModal.jsx'
import { users as initialUsers, planLabels, statusLabels } from '../../data/mockUsers.js'
import './UsersListPage.css'

const PAGE_SIZE = 8

const FILTER_OPTIONS = [
  { value: 'all', label: 'all' },
  { value: 'premium', label: planLabels.premium },
  { value: 'standard', label: planLabels.standard },
  { value: 'free', label: planLabels.free },
  { value: 'active', label: statusLabels.active },
  { value: 'suspended', label: statusLabels.suspended },
]

function compareUsers(a, b, key) {
  if (key === 'joined') return a.joined.localeCompare(b.joined)
  return String(a[key]).localeCompare(String(b[key]))
}

function downloadCsv(rows) {
  const header = ['ID', 'Name', 'Email', 'Phone', 'Plan', 'Status', 'Joined']
  const lines = rows.map((user) =>
    [user.id, user.name, user.email, user.phone, planLabels[user.plan], statusLabels[user.status], user.joined]
      .map((value) => `"${String(value).replace(/"/g, '""')}"`)
      .join(','),
  )
  const csv = [header.join(','), ...lines].join('\n')
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = 'users.csv'
  link.click()
  URL.revokeObjectURL(url)
}

function UsersListPage() {
  const [users, setUsers] = useState(initialUsers)
  const [search, setSearch] = useState('')
  const [filter, setFilter] = useState('all')
  const [sort, setSort] = useState({ key: 'name', direction: 'asc' })
  const [page, setPage] = useState(1)
  const [selectedIds, setSelectedIds] = useState(() => new Set())
  const [isRefreshing, setIsRefreshing] = useState(false)
  const [editingUser, setEditingUser] = useState(null)
  const [pendingAction, setPendingAction] = useState(null)

  const filteredUsers = useMemo(() => {
    const term = search.trim().toLowerCase()
    const list = users.filter((user) => {
      const matchesSearch =
        term.length === 0 ||
        user.name.toLowerCase().includes(term) ||
        user.email.toLowerCase().includes(term)
      const matchesFilter =
        filter === 'all' ||
        user.plan === filter ||
        user.status === filter
      return matchesSearch && matchesFilter
    })

    const sorted = [...list].sort((a, b) => compareUsers(a, b, sort.key))
    return sort.direction === 'desc' ? sorted.reverse() : sorted
  }, [users, search, filter, sort])

  const pageCount = Math.max(1, Math.ceil(filteredUsers.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pageUsers = filteredUsers.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  function updateSearch(value) {
    setSearch(value)
    setPage(1)
  }

  function updateFilter(value) {
    setFilter(value)
    setPage(1)
  }

  function toggleSelect(id) {
    setSelectedIds((current) => {
      const next = new Set(current)
      if (next.has(id)) next.delete(id)
      else next.add(id)
      return next
    })
  }

  function toggleSelectAll(shouldSelect) {
    setSelectedIds((current) => {
      const next = new Set(current)
      pageUsers.forEach((user) => (shouldSelect ? next.add(user.id) : next.delete(user.id)))
      return next
    })
  }

  function toggleStatus(id) {
    setUsers((current) =>
      current.map((user) =>
        user.id === id ? { ...user, status: user.status === 'active' ? 'suspended' : 'active' } : user,
      ),
    )
  }

  function deleteUser(id) {
    setUsers((current) => current.filter((user) => user.id !== id))
    setSelectedIds((current) => {
      const next = new Set(current)
      next.delete(id)
      return next
    })
  }

  function saveEditedUser(updates) {
    setUsers((current) =>
      current.map((user) => (user.id === editingUser.id ? { ...user, ...updates } : user)),
    )
    setEditingUser(null)
  }

  function requestToggleStatus(id) {
    const user = users.find((candidate) => candidate.id === id)
    if (!user) return
    setPendingAction({ type: user.status === 'active' ? 'suspend' : 'activate', user })
  }

  function requestDelete(id) {
    const user = users.find((candidate) => candidate.id === id)
    if (!user) return
    setPendingAction({ type: 'delete', user })
  }

  function confirmPendingAction() {
    if (pendingAction.type === 'delete') {
      deleteUser(pendingAction.user.id)
    } else {
      toggleStatus(pendingAction.user.id)
    }
    setPendingAction(null)
  }

  function handleRefresh() {
    setIsRefreshing(true)
    setSearch('')
    setFilter('all')
    setSort({ key: 'name', direction: 'asc' })
    setPage(1)
    window.setTimeout(() => setIsRefreshing(false), 500)
  }

  return (
    <div className="users-page">
      <div className="users-page__header">
        <div>
          <h2 className="users-page__title">User Management</h2>
          <p className="users-page__subtitle">{users.length} users</p>
        </div>
        <button type="button" className="users-page__add-button">
          <Icon name="action-add-icon" size={16} />
          Add User
        </button>
      </div>

      <div className="users-page__panel">
        <div className="users-page__toolbar">
          <SearchInput
            value={search}
            onChange={(event) => updateSearch(event.target.value)}
            placeholder="Search name or email…"
            className="users-page__search"
          />
          <FilterPills options={FILTER_OPTIONS} value={filter} onChange={updateFilter} />
          <div className="users-page__toolbar-actions">
            <button type="button" className="users-page__ghost-button" onClick={() => downloadCsv(filteredUsers)}>
              <Icon name="action-export-icon" size={12} />
              Export
            </button>
            <button
              type="button"
              className="users-page__ghost-button"
              onClick={handleRefresh}
              aria-busy={isRefreshing}
            >
              <Icon
                name="action-refresh-icon"
                size={12}
                className={isRefreshing ? 'users-page__refresh-icon--spinning' : ''}
              />
              Refresh
            </button>
          </div>
        </div>

        <div className="users-page__table-scroll">
          <UsersTable
            users={pageUsers}
            sort={sort}
            onSortChange={setSort}
            selectedIds={selectedIds}
            onToggleSelect={toggleSelect}
            onToggleSelectAll={toggleSelectAll}
            onToggleStatus={requestToggleStatus}
            onDelete={requestDelete}
            onEdit={setEditingUser}
          />
        </div>

        <Pagination
          page={safePage}
          pageCount={pageCount}
          totalCount={filteredUsers.length}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      </div>

      {editingUser && (
        <EditUserModal user={editingUser} onClose={() => setEditingUser(null)} onSave={saveEditedUser} />
      )}

      {pendingAction && (
        <ConfirmActionModal
          type={pendingAction.type}
          user={pendingAction.user}
          onClose={() => setPendingAction(null)}
          onConfirm={confirmPendingAction}
        />
      )}
    </div>
  )
}

export default UsersListPage
