import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import SearchInput from '../../components/SearchInput/SearchInput.jsx'
import ContactsTable from '../../components/ContactsTable/ContactsTable.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import ContactDetailsModal from '../../components/ContactDetailsModal/ContactDetailsModal.jsx'
import EditContactModal from '../../components/EditContactModal/EditContactModal.jsx'
import ConfirmActionModal from '../../components/ConfirmActionModal/ConfirmActionModal.jsx'
import Toast from '../../components/Toast/Toast.jsx'
import { contacts as initialContacts, statusLabels } from '../../data/mockContacts.js'
import './EmergencyContactsPage.css'

const PAGE_SIZE = 8

function downloadCsv(rows) {
  const header = ['ID', 'Contact', 'Relationship', 'Assigned User', 'Phone', 'Status']
  const lines = rows.map((contact) =>
    [
      contact.id,
      contact.name,
      contact.relationship,
      contact.assignedUserName,
      contact.phone,
      statusLabels[contact.status],
    ]
      .map((value) => `"${String(value).replace(/"/g, '""')}"`)
      .join(','),
  )
  const csv = [header.join(','), ...lines].join('\n')
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = 'emergency-contacts.csv'
  link.click()
  URL.revokeObjectURL(url)
}

function EmergencyContactsPage() {
  const [contacts, setContacts] = useState(initialContacts)
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const [viewingId, setViewingId] = useState(null)
  const [editingId, setEditingId] = useState(null)
  const [removingId, setRemovingId] = useState(null)
  const [toast, setToast] = useState(null)

  const filteredContacts = useMemo(() => {
    const term = search.trim().toLowerCase()
    if (term.length === 0) return contacts
    return contacts.filter(
      (contact) =>
        contact.name.toLowerCase().includes(term) ||
        contact.assignedUserName.toLowerCase().includes(term) ||
        contact.relationship.toLowerCase().includes(term),
    )
  }, [contacts, search])

  const pageCount = Math.max(1, Math.ceil(filteredContacts.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pageContacts = filteredContacts.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  function updateSearch(value) {
    setSearch(value)
    setPage(1)
  }

  function toggleStatus(id) {
    const contact = contacts.find((candidate) => candidate.id === id)
    if (!contact) return
    const nextStatus = contact.status === 'active' ? 'inactive' : 'active'
    setContacts((current) =>
      current.map((candidate) => (candidate.id === id ? { ...candidate, status: nextStatus } : candidate)),
    )
    setToast(`${contact.name} ${nextStatus === 'active' ? 'activated' : 'deactivated'}.`)
  }

  function requestRemoveContact(id) {
    setRemovingId(id)
  }

  function confirmRemoveContact() {
    setContacts((current) => current.filter((contact) => contact.id !== removingId))
    setRemovingId(null)
  }

  function saveContact(updates) {
    setContacts((current) =>
      current.map((contact) => (contact.id === editingId ? { ...contact, ...updates } : contact)),
    )
    setEditingId(null)
  }

  const viewingContact = contacts.find((contact) => contact.id === viewingId) ?? null
  const editingContact = contacts.find((contact) => contact.id === editingId) ?? null
  const removingContact = contacts.find((contact) => contact.id === removingId) ?? null

  return (
    <div className="contacts-page">
      <div className="contacts-page__header">
        <div>
          <h2 className="contacts-page__title">Emergency Contacts</h2>
          <p className="contacts-page__subtitle">{contacts.length} contacts</p>
        </div>
        <button type="button" className="contacts-page__add-button">
          <Icon name="action-add-icon" size={13} />
          Add Contact
        </button>
      </div>

      <div className="contacts-page__panel">
        <div className="contacts-page__toolbar">
          <SearchInput
            value={search}
            onChange={(event) => updateSearch(event.target.value)}
            placeholder="Search contacts…"
            className="contacts-page__search"
          />
          <button
            type="button"
            className="contacts-page__export-button"
            onClick={() => downloadCsv(filteredContacts)}
          >
            <Icon name="action-export-icon" size={13} />
            Export
          </button>
        </div>

        <div className="contacts-page__table-scroll">
          <ContactsTable
            contacts={pageContacts}
            onView={(contact) => setViewingId(contact.id)}
            onEdit={(contact) => setEditingId(contact.id)}
            onToggleStatus={toggleStatus}
            onDelete={requestRemoveContact}
          />
        </div>

        <Pagination
          page={safePage}
          pageCount={pageCount}
          totalCount={filteredContacts.length}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      </div>

      {viewingContact && <ContactDetailsModal contact={viewingContact} onClose={() => setViewingId(null)} />}

      {editingContact && (
        <EditContactModal contact={editingContact} onClose={() => setEditingId(null)} onSave={saveContact} />
      )}

      {removingContact && (
        <ConfirmActionModal
          type="removeContact"
          user={removingContact}
          onClose={() => setRemovingId(null)}
          onConfirm={confirmRemoveContact}
        />
      )}

      {toast && <Toast message={toast} onClose={() => setToast(null)} />}
    </div>
  )
}

export default EmergencyContactsPage
