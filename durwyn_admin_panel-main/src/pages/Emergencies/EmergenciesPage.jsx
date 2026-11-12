import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import SearchInput from '../../components/SearchInput/SearchInput.jsx'
import FilterPills from '../../components/FilterPills/FilterPills.jsx'
import EmergenciesTable from '../../components/EmergenciesTable/EmergenciesTable.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import EmergencyDetailsModal from '../../components/EmergencyDetailsModal/EmergencyDetailsModal.jsx'
import AssignResponderModal from '../../components/AssignResponderModal/AssignResponderModal.jsx'
import EscalateEmergencyModal from '../../components/EscalateEmergencyModal/EscalateEmergencyModal.jsx'
import CloseCaseModal from '../../components/CloseCaseModal/CloseCaseModal.jsx'
import CancelEmergencyModal from '../../components/CancelEmergencyModal/CancelEmergencyModal.jsx'
import {
  emergencies as initialEmergencies,
  priorityLabels,
  statusLabels,
  responseLabels,
} from '../../data/mockEmergencies.js'
import './EmergenciesPage.css'

const PAGE_SIZE = 8
const PRIORITY_ORDER = ['low', 'medium', 'high', 'critical']

const FILTER_OPTIONS = [
  { value: 'all', label: 'all' },
  { value: 'active', label: statusLabels.active.toLowerCase() },
  { value: 'resolved', label: statusLabels.resolved.toLowerCase() },
  { value: 'cancelled', label: statusLabels.cancelled.toLowerCase() },
]

function downloadCsv(rows) {
  const header = ['ID', 'Name', 'Type', 'Priority', 'Status', 'Duration', 'Started', 'Contact', 'Response']
  const lines = rows.map((emergency) =>
    [
      emergency.id,
      emergency.name,
      emergency.type,
      priorityLabels[emergency.priority],
      statusLabels[emergency.status],
      emergency.duration,
      emergency.started,
      emergency.contact,
      responseLabels[emergency.response],
    ]
      .map((value) => `"${String(value).replace(/"/g, '""')}"`)
      .join(','),
  )
  const csv = [header.join(','), ...lines].join('\n')
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = 'emergencies.csv'
  link.click()
  URL.revokeObjectURL(url)
}

function EmergenciesPage() {
  const [emergencies, setEmergencies] = useState(initialEmergencies)
  const [search, setSearch] = useState('')
  const [filter, setFilter] = useState('all')
  const [page, setPage] = useState(1)
  const [viewingId, setViewingId] = useState(null)
  const [assigningId, setAssigningId] = useState(null)
  const [escalatingId, setEscalatingId] = useState(null)
  const [closingId, setClosingId] = useState(null)
  const [cancelingId, setCancelingId] = useState(null)

  const activeCount = useMemo(
    () => emergencies.filter((emergency) => emergency.status === 'active').length,
    [emergencies],
  )
  const resolvedCount = useMemo(
    () => emergencies.filter((emergency) => emergency.status === 'resolved').length,
    [emergencies],
  )

  const filteredEmergencies = useMemo(() => {
    const term = search.trim().toLowerCase()
    return emergencies.filter((emergency) => {
      const matchesSearch =
        term.length === 0 ||
        emergency.name.toLowerCase().includes(term) ||
        emergency.type.toLowerCase().includes(term)
      const matchesFilter = filter === 'all' || emergency.status === filter
      return matchesSearch && matchesFilter
    })
  }, [emergencies, search, filter])

  const pageCount = Math.max(1, Math.ceil(filteredEmergencies.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pageEmergencies = filteredEmergencies.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  function updateSearch(value) {
    setSearch(value)
    setPage(1)
  }

  function updateFilter(value) {
    setFilter(value)
    setPage(1)
  }

  const viewingEmergency = emergencies.find((emergency) => emergency.id === viewingId) ?? null
  const assigningEmergency = emergencies.find((emergency) => emergency.id === assigningId) ?? null
  const escalatingEmergency = emergencies.find((emergency) => emergency.id === escalatingId) ?? null
  const closingEmergency = emergencies.find((emergency) => emergency.id === closingId) ?? null
  const cancelingEmergency = emergencies.find((emergency) => emergency.id === cancelingId) ?? null

  function requestClose(id) {
    const emergency = emergencies.find((candidate) => candidate.id === id)
    if (!emergency) return
    // Reopening a resolved case has no confirmation step in the design; only
    // closing an active case walks through the Close Case modal.
    if (emergency.status === 'resolved') {
      setEmergencies((current) =>
        current.map((candidate) => (candidate.id === id ? { ...candidate, status: 'active' } : candidate)),
      )
      return
    }
    setViewingId(null)
    setClosingId(id)
  }

  function confirmClose() {
    setEmergencies((current) =>
      current.map((emergency) => (emergency.id === closingId ? { ...emergency, status: 'resolved' } : emergency)),
    )
    setClosingId(null)
  }

  function requestCancel(id) {
    setCancelingId(id)
  }

  function confirmCancel() {
    setEmergencies((current) =>
      current.map((emergency) => (emergency.id === cancelingId ? { ...emergency, status: 'cancelled' } : emergency)),
    )
    setCancelingId(null)
  }

  function requestAssign(id) {
    setAssigningId(id)
  }

  function confirmAssign({ responder, priority }) {
    setEmergencies((current) =>
      current.map((emergency) =>
        emergency.id === assigningId ? { ...emergency, response: 'responded', responder, priority } : emergency,
      ),
    )
    setAssigningId(null)
  }

  function requestEscalate(id) {
    setEscalatingId(id)
  }

  function confirmEscalate({ escalateTo }) {
    setEmergencies((current) =>
      current.map((emergency) => {
        if (emergency.id !== escalatingId) return emergency
        const nextIndex = Math.min(PRIORITY_ORDER.indexOf(emergency.priority) + 1, PRIORITY_ORDER.length - 1)
        return { ...emergency, priority: PRIORITY_ORDER[nextIndex], escalatedTo: escalateTo }
      }),
    )
    setEscalatingId(null)
  }

  return (
    <div className="emergencies-page">
      <div className="emergencies-page__header">
        <div>
          <h2 className="emergencies-page__title">Emergency Monitoring</h2>
          <p className="emergencies-page__subtitle">
            <span className="emergencies-page__active-stat">
              <span className="emergencies-page__live-dot" aria-hidden="true" />
              {activeCount} Active
            </span>
            <span className="emergencies-page__resolved-stat">· {resolvedCount} Resolved today</span>
          </p>
        </div>
        <button
          type="button"
          className="emergencies-page__export-button"
          onClick={() => downloadCsv(filteredEmergencies)}
        >
          <Icon name="action-export-icon" size={13} />
          Export
        </button>
      </div>

      <div className="emergencies-page__panel">
        <div className="emergencies-page__toolbar">
          <SearchInput
            value={search}
            onChange={(event) => updateSearch(event.target.value)}
            placeholder="Search user or type…"
            className="emergencies-page__search"
          />
          <FilterPills options={FILTER_OPTIONS} value={filter} onChange={updateFilter} />
        </div>

        <div className="emergencies-page__table-scroll">
          <EmergenciesTable
            emergencies={pageEmergencies}
            onViewDetails={setViewingId}
            onRequestClose={requestClose}
            onRequestCancel={requestCancel}
            onRequestAssign={requestAssign}
            onRequestEscalate={requestEscalate}
            onDownload={(emergency) => downloadCsv([emergency])}
          />
        </div>

        <Pagination
          page={safePage}
          pageCount={pageCount}
          totalCount={filteredEmergencies.length}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      </div>

      {viewingEmergency && (
        <EmergencyDetailsModal
          emergency={viewingEmergency}
          onClose={() => setViewingId(null)}
          onRequestClose={requestClose}
          onDownload={(emergency) => downloadCsv([emergency])}
        />
      )}

      {assigningEmergency && (
        <AssignResponderModal emergency={assigningEmergency} onClose={() => setAssigningId(null)} onAssign={confirmAssign} />
      )}

      {escalatingEmergency && (
        <EscalateEmergencyModal
          emergency={escalatingEmergency}
          onClose={() => setEscalatingId(null)}
          onEscalate={confirmEscalate}
        />
      )}

      {closingEmergency && (
        <CloseCaseModal emergency={closingEmergency} onClose={() => setClosingId(null)} onConfirm={confirmClose} />
      )}

      {cancelingEmergency && (
        <CancelEmergencyModal emergency={cancelingEmergency} onClose={() => setCancelingId(null)} onConfirm={confirmCancel} />
      )}
    </div>
  )
}

export default EmergenciesPage
