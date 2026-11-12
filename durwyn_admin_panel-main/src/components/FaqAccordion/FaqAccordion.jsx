import { useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import './FaqAccordion.css'

// Expand/collapse question list shown on the Help & Support "FAQ" tab.
function FaqAccordion({ items, defaultOpenId }) {
  const [openId, setOpenId] = useState(defaultOpenId ?? null)

  function toggle(id) {
    setOpenId((current) => (current === id ? null : id))
  }

  return (
    <div className="faq-accordion">
      {items.map((item) => {
        const isOpen = openId === item.id
        return (
          <div className="faq-accordion__item" key={item.id}>
            <button
              type="button"
              className="faq-accordion__summary"
              aria-expanded={isOpen}
              aria-controls={`${item.id}-answer`}
              onClick={() => toggle(item.id)}
            >
              <span className="faq-accordion__question">{item.question}</span>
              <Icon
                name="chevron-down-icon"
                size={14}
                className={`faq-accordion__chevron${isOpen ? ' faq-accordion__chevron--open' : ''}`}
              />
            </button>
            {isOpen && (
              <p id={`${item.id}-answer`} className="faq-accordion__answer">
                {item.answer}
              </p>
            )}
          </div>
        )
      })}
    </div>
  )
}

export default FaqAccordion
