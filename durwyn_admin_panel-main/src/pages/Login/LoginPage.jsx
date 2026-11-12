import { useEffect, useId, useState } from 'react'
import logoFull from '../../assets/logo-full.png'
import Icon from '../../components/Icon/Icon.jsx'
import TextField from '../../components/TextField/TextField.jsx'
import Checkbox from '../../components/Checkbox/Checkbox.jsx'
import Button from '../../components/Button/Button.jsx'
import { loginRequest } from '../../data/mockAuth.js'
import './LoginPage.css'

const REDIRECT_DELAY_MS = 1200

const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
const REMEMBERED_EMAIL_KEY = 'durwyn_remembered_email'

function validate({ email, password }) {
  const errors = {}
  if (!email.trim()) {
    errors.email = 'Email address is required.'
  } else if (!EMAIL_PATTERN.test(email)) {
    errors.email = 'Enter a valid email address.'
  }
  if (!password) {
    errors.password = 'Password is required.'
  } else if (password.length < 6) {
    errors.password = 'Password must be at least 6 characters.'
  }
  return errors
}

function LoginPage({ onForgotPassword, onLoginSuccess }) {
  const emailId = useId()
  const passwordId = useId()
  const rememberId = useId()

  const [email, setEmail] = useState(
    () => localStorage.getItem(REMEMBERED_EMAIL_KEY) ?? '',
  )
  const [password, setPassword] = useState('')
  const [rememberMe, setRememberMe] = useState(
    () => localStorage.getItem(REMEMBERED_EMAIL_KEY) !== null,
  )
  const [showPassword, setShowPassword] = useState(false)
  const [errors, setErrors] = useState({})
  const [submitting, setSubmitting] = useState(false)
  const [submitError, setSubmitError] = useState(null)
  const [submitted, setSubmitted] = useState(false)

  useEffect(() => {
    if (!submitted) return undefined
    const timer = setTimeout(() => onLoginSuccess?.(), REDIRECT_DELAY_MS)
    return () => clearTimeout(timer)
  }, [submitted, onLoginSuccess])

  async function handleSubmit(event) {
    event.preventDefault()

    const nextErrors = validate({ email, password })
    setErrors(nextErrors)
    if (Object.keys(nextErrors).length > 0) return

    setSubmitting(true)
    setSubmitError(null)
    try {
      await loginRequest({ email, password })
      if (rememberMe) {
        localStorage.setItem(REMEMBERED_EMAIL_KEY, email)
      } else {
        localStorage.removeItem(REMEMBERED_EMAIL_KEY)
      }
      setSubmitted(true)
    } catch (error) {
      setSubmitError(error.message)
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="login-page">
      <div className="login-page__panel">
        <div className="login-page__brand">
          <div className="login-page__logo-badge">
            <img src={logoFull} alt="Trouble Cheat" className="login-page__logo" />
          </div>
        </div>

        <div className="login-page__heading">
          <p className="login-page__subtitle">Admin Portal</p>
        </div>

        <div className="login-card">
          {submitted ? (
            <div className="login-card__success" role="status">
              <p>Signed in successfully.</p>
              <p className="login-card__success-sub">Redirecting to the dashboard…</p>
            </div>
          ) : (
            <form className="login-form" onSubmit={handleSubmit} noValidate>
              {submitError && (
                <p className="login-form__banner" role="alert">
                  {submitError}
                </p>
              )}

              <TextField
                id={emailId}
                label="Email address"
                icon="mail-icon"
                type="email"
                placeholder="Email address"
                autoComplete="email"
                value={email}
                error={errors.email}
                onChange={(event) => setEmail(event.target.value)}
              />

              <TextField
                id={passwordId}
                label="Password"
                icon="lock-icon"
                type={showPassword ? 'text' : 'password'}
                placeholder="Password"
                autoComplete="current-password"
                value={password}
                error={errors.password}
                onChange={(event) => setPassword(event.target.value)}
                trailing={
                  <button
                    type="button"
                    className="login-form__toggle-visibility"
                    onClick={() => setShowPassword((value) => !value)}
                    aria-label={showPassword ? 'Hide password' : 'Show password'}
                    aria-pressed={showPassword}
                  >
                    <Icon name={showPassword ? 'eye-off-icon' : 'eye-icon'} size={20} />
                  </button>
                }
              />

              <div className="login-form__row">
                <Checkbox
                  id={rememberId}
                  label="Remember me"
                  checked={rememberMe}
                  onChange={(event) => setRememberMe(event.target.checked)}
                />
                <button
                  type="button"
                  className="login-form__forgot"
                  onClick={onForgotPassword}
                >
                  Forgot password?
                </button>
              </div>

              <Button type="submit" loading={submitting} loadingText="Signing in…">
                Sign in to Dashboard
              </Button>
            </form>
          )}
        </div>
      </div>
    </div>
  )
}

export default LoginPage
