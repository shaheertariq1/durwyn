import Icon from '../Icon/Icon.jsx'
import './DocumentationGrid.css'

// Grid of documentation link cards shown on the Help & Support "Documentation" tab.
function DocumentationGrid({ items }) {
  return (
    <div className="documentation-grid">
      {items.map((item) => (
        <div className="documentation-grid__card" key={item.id}>
          <span className="documentation-grid__icon">
            <Icon name={item.icon} size={16} />
          </span>
          <p className="documentation-grid__title">{item.title}</p>
          <p className="documentation-grid__subtitle">{item.subtitle}</p>
          <span className="documentation-grid__link">
            Read more
            <Icon name="chevron-right-icon" size={11} />
          </span>
        </div>
      ))}
    </div>
  )
}

export default DocumentationGrid
