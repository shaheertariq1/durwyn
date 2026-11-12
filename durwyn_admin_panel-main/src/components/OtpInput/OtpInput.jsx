import { useEffect, useRef, useState } from 'react'
import './OtpInput.css'

const DIGIT_PATTERN = /^[0-9]$/

// Segmented one-time-code input: `length` single-digit boxes with
// auto-advance, backspace-to-previous and multi-digit paste support.
// Pass a changing `key` prop (e.g. a resend counter) to reset and refocus.
function OtpInput({
  length = 6,
  onChange,
  onComplete,
  error,
  disabled = false,
  label = 'One-time verification code',
}) {
  const [digits, setDigits] = useState(() => Array(length).fill(''))
  const inputRefs = useRef([])

  useEffect(() => {
    inputRefs.current[0]?.focus()
  }, [])

  function updateDigits(nextDigits) {
    setDigits(nextDigits)
    const value = nextDigits.join('')
    onChange?.(value)
    if (value.length === length && !nextDigits.includes('')) {
      onComplete?.(value)
    }
  }

  function handleChange(index, event) {
    const raw = event.target.value
    const char = raw.slice(-1)
    if (char && !DIGIT_PATTERN.test(char)) return

    const next = [...digits]
    next[index] = char
    updateDigits(next)

    if (char && index < length - 1) {
      inputRefs.current[index + 1]?.focus()
    }
  }

  function handleKeyDown(index, event) {
    if (event.key === 'Backspace' && !digits[index] && index > 0) {
      const next = [...digits]
      next[index - 1] = ''
      updateDigits(next)
      inputRefs.current[index - 1]?.focus()
    } else if (event.key === 'ArrowLeft' && index > 0) {
      inputRefs.current[index - 1]?.focus()
    } else if (event.key === 'ArrowRight' && index < length - 1) {
      inputRefs.current[index + 1]?.focus()
    }
  }

  function handlePaste(event) {
    const pasted = event.clipboardData.getData('text').replace(/\D/g, '').slice(0, length)
    if (!pasted) return
    event.preventDefault()

    const next = Array(length).fill('')
    for (let i = 0; i < pasted.length; i += 1) next[i] = pasted[i]
    updateDigits(next)

    const focusIndex = Math.min(pasted.length, length - 1)
    inputRefs.current[focusIndex]?.focus()
  }

  return (
    <div
      className={`otp-input${error ? ' otp-input--error' : ''}`}
      role="group"
      aria-label={label}
    >
      {digits.map((digit, index) => (
        <input
          key={index}
          ref={(el) => (inputRefs.current[index] = el)}
          type="text"
          inputMode="numeric"
          autoComplete={index === 0 ? 'one-time-code' : 'off'}
          maxLength={1}
          className="otp-input__box"
          value={digit}
          disabled={disabled}
          aria-label={`Digit ${index + 1} of ${length}`}
          aria-invalid={error ? 'true' : 'false'}
          onChange={(event) => handleChange(index, event)}
          onKeyDown={(event) => handleKeyDown(index, event)}
          onPaste={handlePaste}
        />
      ))}
    </div>
  )
}

export default OtpInput
