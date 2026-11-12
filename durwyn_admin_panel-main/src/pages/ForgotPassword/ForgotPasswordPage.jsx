import { useId, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import TextField from '../../components/TextField/TextField.jsx'
import Button from '../../components/Button/Button.jsx'
import { requestPasswordReset } from '../../data/mockAuth.js'
import './ForgotPasswordPage.css'

const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

function validate(email) {
  if (!email.trim()) return 'Email address is required.'
  if (!EMAIL_PATTERN.test(email)) return 'Enter a valid email address.'
  return null
}

function ForgotPasswordPage({ onBack, onCodeSent }) {
  const emailId = useId()

  const [email, setEmail] = useState('')
  const [error, setError] = useState(null)
  const [submitting, setSubmitting] = useState(false)
  const [submitError, setSubmitError] = useState(null)
  const [submitted, setSubmitted] = useState(false)

  async function handleSubmit(event) {
    event.preventDefault()

    const nextError = validate(email)
    setError(nextError)
    if (nextError) return

    setSubmitting(true)
    setSubmitError(null)
    try {
      await requestPasswordReset({ email })
      setSubmitted(true)
    } catch (requestError) {
      setSubmitError(requestError.message)
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="forgot-password-page">
      <div className="forgot-password-page__panel">
        <div className="forgot-password-page__brand">
          <Icon name="login-brand-icon" width={67} height={60} />
        </div>

        <div className="forgot-password-page__heading">
          <p className="forgot-password-page__title">Trouble Cheat</p>
          <p className="forgot-password-page__subtitle">Admin Portal</p>
        </div>

        <div className="forgot-password-card">
          <button
            type="button"
            className="forgot-password-card__back"
            onClick={onBack}
            aria-label="Back to sign in"
          >
            <span aria-hidden="true">←</span> Back
          </button>

          {submitted ? (
            <div className="forgot-password-card__success" role="status">
              <p className="forgot-password-card__success-title">Reset password</p>
              <p className="forgot-password-card__success-sub">
                If an account exists for {email}, a verification code has been sent.
              </p>
              <Button onClick={() => onCodeSent?.(email)}>Enter verification code</Button>
            </div>
          ) : (
            <>
              <div className="forgot-password-card__intro">
                <p className="forgot-password-card__title">Reset password</p>
                <p className="forgot-password-card__subtitle">
                  We&apos;ll email you a verification code
                </p>
              </div>

              <form className="forgot-password-form" onSubmit={handleSubmit} noValidate>
                {submitError && (
                  <p className="forgot-password-form__banner" role="alert">
                    {submitError}
                  </p>
                )}

                <TextField
                  id={emailId}
                  label="Email address"
                  icon="mail-icon"
                  type="email"
                  placeholder="admin@troublecheat.com"
                  autoComplete="email"
                  value={email}
                  error={error}
                  onChange={(event) => setEmail(event.target.value)}
                />

                <Button type="submit" loading={submitting} loadingText="Sending…">
                  Send Code
                </Button>
              </form>
            </>
          )}
        </div>
      </div>
    </div>
  )
}

export default ForgotPasswordPage
