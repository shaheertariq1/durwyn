import Icon from '../Icon/Icon.jsx'
import './SearchInput.css'

// Flexible search field with a leading icon, used above the users table.
function SearchInput({ value, onChange, placeholder = 'Search…', className = '', ...rest }) {
  return (
    <label className={`search-input ${className}`.trim()}>
      <Icon name="topnav-search-icon" size={20} />
      <input
        type="search"
        value={value}
        onChange={onChange}
        placeholder={placeholder}
        aria-label={placeholder}
        {...rest}
      />
    </label>
  )
}

export default SearchInput
