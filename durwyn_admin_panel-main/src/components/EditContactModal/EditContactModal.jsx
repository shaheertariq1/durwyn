import { useState } from 'react'
import './EditContactModal.css'

// Overlay form for editing a contact's core fields, opened from the "Edit"
// action on the emergency contacts row menu.
function EditContactModal({ contact, onClose, onSave }) {
  const [name, setName] = useState(contact.name)
  const [relationship, setRelationship] = useState(contact.relationship)
  const [phone, setPhone] = useState(contact.phone)

  function handleSubmit(event) {
    event.preventDefault()
    onSave({ name: name.trim(), relationship: relationship.trim(), phone: phone.trim() })
  }

  return (
    <div className="edit-contact-modal__overlay" onMouseDown={onClose}>
      <form
        className="edit-contact-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Edit Contact"
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={handleSubmit}
      >
        <div className="edit-contact-modal__header">
          <p className="edit-contact-modal__title">Edit Contact</p>
          <button type="button" className="edit-contact-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="edit-contact-modal__body">
          <div className="edit-contact-modal__field">
            <label className="edit-contact-modal__label" htmlFor="edit-contact-name">
              Name
            </label>
            <input
              id="edit-contact-name"
              className="edit-contact-modal__input"
              value={name}
              onChange={(event) => setName(event.target.value)}
            />
          </div>

          <div className="edit-contact-modal__field">
            <label className="edit-contact-modal__label" htmlFor="edit-contact-relationship">
              Relationship
            </label>
            <input
              id="edit-contact-relationship"
              className="edit-contact-modal__input"
              value={relationship}
              onChange={(event) => setRelationship(event.target.value)}
            />
          </div>

          <div className="edit-contact-modal__field">
            <label className="edit-contact-modal__label" htmlFor="edit-contact-phone">
              Phone
            </label>
            <input
              id="edit-contact-phone"
              className="edit-contact-modal__input"
              value={phone}
              onChange={(event) => setPhone(event.target.value)}
            />
          </div>
        </div>

        <div className="edit-contact-modal__actions">
          <button
            type="button"
            className="edit-contact-modal__button edit-contact-modal__button--cancel"
            onClick={onClose}
          >
            Cancel
          </button>
          <button type="submit" className="edit-contact-modal__button edit-contact-modal__button--save">
            Save
          </button>
        </div>
      </form>
    </div>
  )
}

export default EditContactModal
