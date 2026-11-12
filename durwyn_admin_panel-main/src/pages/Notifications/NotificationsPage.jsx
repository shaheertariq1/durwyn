import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import SearchInput from '../../components/SearchInput/SearchInput.jsx'
import NotificationsTable from '../../components/NotificationsTable/NotificationsTable.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import NotificationDetailsModal from '../../components/NotificationDetailsModal/NotificationDetailsModal.jsx'
import NotificationFormModal from '../../components/NotificationFormModal/NotificationFormModal.jsx'
import { kpiSummary, notifications as initialNotifications } from '../../data/mockNotifications.js'
import './NotificationsPage.css'

const PAGE_SIZE = 8

function nextNotificationId(notifications) {
  const maxNumber = notifications.reduce((max, notification) => {
    const number = Number(notification.id.replace(/\D/g, ''))
    return Number.isFinite(number) ? Math.max(max, number) : max
  }, 0)
  return `NTF${String(maxNumber + 1).padStart(3, '0')}`
}

function NotificationsPage() {
  const [notifications, setNotifications] = useState(initialNotifications)
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const [viewingId, setViewingId] = useState(null)
  const [editingId, setEditingId] = useState(null)
  const [isCreating, setIsCreating] = useState(false)

  const filteredNotifications = useMemo(() => {
    const term = search.trim().toLowerCase()
    if (term.length === 0) return notifications
    return notifications.filter(
      (notification) =>
        notification.title.toLowerCase().includes(term) ||
        notification.description.toLowerCase().includes(term),
    )
  }, [notifications, search])

  const pageCount = Math.max(1, Math.ceil(filteredNotifications.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pageNotifications = filteredNotifications.slice(
    (safePage - 1) * PAGE_SIZE,
    safePage * PAGE_SIZE,
  )

  function updateSearch(value) {
    setSearch(value)
    setPage(1)
  }

  function removeNotification(id) {
    setNotifications((current) => current.filter((notification) => notification.id !== id))
  }

  function saveEditedNotification(updates) {
    setNotifications((current) =>
      current.map((notification) =>
        notification.id === editingId
          ? {
              ...notification,
              title: updates.title,
              description: updates.description,
              type: updates.type,
              recipients: updates.recipients,
            }
          : notification,
      ),
    )
    setEditingId(null)
  }

  function saveNewNotification(updates) {
    const today = new Date().toISOString().slice(0, 10)
    setNotifications((current) => [
      {
        id: nextNotificationId(current),
        title: updates.title,
        description: updates.description,
        type: updates.type,
        recipients: updates.recipients,
        status: updates.scheduleDate ? 'scheduled' : 'sent',
        date: updates.scheduleDate ?? today,
        delivered: 0,
      },
      ...current,
    ])
    setIsCreating(false)
  }

  const viewingNotification = notifications.find((notification) => notification.id === viewingId) ?? null
  const editingNotification = notifications.find((notification) => notification.id === editingId) ?? null

  return (
    <div className="notifications-page">
      <div className="notifications-page__header">
        <h2 className="notifications-page__title">Notification Management</h2>
        <button
          type="button"
          className="notifications-page__create-button"
          onClick={() => setIsCreating(true)}
        >
          <Icon name="action-add-icon" size={13} />
          Create
        </button>
      </div>

      <div className="notifications-page__kpi-grid">
        {kpiSummary.map((kpi) => (
          <div className="notifications-page__kpi-card" key={kpi.id}>
            <p className="notifications-page__kpi-label">{kpi.label}</p>
            <p className={`notifications-page__kpi-value notifications-page__kpi-value--${kpi.tone}`}>
              {kpi.value}
            </p>
          </div>
        ))}
      </div>

      <div className="notifications-page__panel">
        <div className="notifications-page__toolbar">
          <SearchInput
            value={search}
            onChange={(event) => updateSearch(event.target.value)}
            placeholder="Search notifications…"
          />
        </div>

        <div className="notifications-page__table-scroll">
          <NotificationsTable
            notifications={pageNotifications}
            onView={(notification) => setViewingId(notification.id)}
            onEdit={(notification) => setEditingId(notification.id)}
            onDelete={removeNotification}
          />
        </div>

        <Pagination
          page={safePage}
          pageCount={pageCount}
          totalCount={filteredNotifications.length}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      </div>

      {viewingNotification && (
        <NotificationDetailsModal
          notification={viewingNotification}
          onClose={() => setViewingId(null)}
          onEdit={() => {
            setEditingId(viewingNotification.id)
            setViewingId(null)
          }}
        />
      )}

      {editingNotification && (
        <NotificationFormModal
          mode="edit"
          notification={editingNotification}
          onClose={() => setEditingId(null)}
          onSave={saveEditedNotification}
        />
      )}

      {isCreating && (
        <NotificationFormModal mode="create" onClose={() => setIsCreating(false)} onSave={saveNewNotification} />
      )}
    </div>
  )
}

export default NotificationsPage
