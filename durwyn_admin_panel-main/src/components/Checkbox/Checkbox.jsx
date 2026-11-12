import Icon from '../Icon/Icon.jsx'
import './Checkbox.css'

function Checkbox({ id, label, checked, onChange }) {
  return (
    <label className="checkbox" htmlFor={id}>
      <span className="checkbox__box">
        <input
          id={id}
          type="checkbox"
          className="checkbox__input"
          checked={checked}
          onChange={onChange}
        />
        {checked && <Icon name="check-icon" size={13} className="checkbox__check" />}
      </span>
      <span className="checkbox__label">{label}</span>
    </label>
  )
}

export default Checkbox
