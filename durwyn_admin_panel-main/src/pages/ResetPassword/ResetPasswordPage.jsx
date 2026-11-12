import { useId, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import TextField from '../../components/TextField/TextField.jsx'
import Button from '../../components/Button/Button.jsx'
import { resetPasswordRequest } from '../../data/mockAuth.js'
import './ResetPasswordPage.css'

function validate({ newPassword, confirmPassword }) {
  const errors = {}
  if (!newPassword) {
    errors.newPassword = 'Password is required.'
  } else if (newPassword.length < 6) {
    errors.newPassword = 'Password must be at least 6 characters.'
  }

  if (!confirmPassword) {
    errors.confirmPassword = 'Please confirm your password.'
  } else if (newPassword && confirmPassword !== newPassword) {
    errors.confirmPassword = 'Passwords do not match.'
  }
  return errors
}

function ResetPasswordPage({ onBack, onDone }) {
  const newPasswordId = useId()
  const confirmPasswordId = useId()

  const [newPassword, setNewPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [showNewPassword, setShowNewPassword] = useState(false)
  const [showConfirmPassword, setShowConfirmPassword] = useState(false)
  const [errors, setErrors] = useState({})
  const [submitting, setSubmitting] = useState(false)
  const [submitError, setSubmitError] = useState(null)
  const [resetDone, setResetDone] = useState(false)

  async function handleSubmit(event) {
    event.preventDefault()

    const nextErrors = validate({ newPassword, confirmPassword })
    setErrors(nextErrors)
    if (Object.keys(nextErrors).length > 0) return

    setSubmitting(true)
    setSubmitError(null)
    try {
      await resetPasswordRequest({ password: newPassword })
      setResetDone(true)
    } catch (requestError) {
      setSubmitError(requestError.message)
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="reset-password-page">
      <div className="reset-password-page__panel">
        <div className="reset-password-page__brand">
          <Icon name="login-brand-icon" width={67} height={60} />
        </div>

        <div className="reset-password-page__heading">
          <p className="reset-password-page__title">Trouble Cheat</p>
          <p className="reset-password-page__subtitle">Admin Portal</p>
        </div>

        <div className="reset-password-card">
          {resetDone ? (
            <div className="reset-password-card__success" role="status">
              <span className="reset-password-card__success-icon" aria-hidden="true">
                <Icon name="check-circle-icon" size={28} />
              </span>
              <p className="reset-password-card__success-title">Password reset!</p>
              <p className="reset-password-card__success-sub">
                Your password has been successfully reset.
              </p>
              <Button onClick={onDone}>Back to Login</Button>
            </div>
          ) : (
            <>
              <button
                type="button"
                className="reset-password-card__back"
                onClick={onBack}
                aria-label="Back to verification"
              >
                <span aria-hidden="true">←</span> Back
              </button>

              <p className="reset-password-card__title">New Password</p>

              <form className="reset-password-form" onSubmit={handleSubmit} noValidate>
                {submitError && (
                  <p className="reset-password-form__banner" role="alert">
                    {submitError}
                  </p>
                )}

                <TextField
                  id={newPasswordId}
                  label="Enter new password"
                  icon="lock-icon"
                  type={showNewPassword ? 'text' : 'password'}
                  placeholder="Enter new password"
                  autoComplete="new-password"
                  value={newPassword}
                  error={errors.newPassword}
                  onChange={(event) => setNewPassword(event.target.value)}
                  trailing={
                    <button
                      type="button"
                      className="reset-password-form__toggle-visibility"
                      onClick={() => setShowNewPassword((value) => !value)}
                      aria-label={showNewPassword ? 'Hide password' : 'Show password'}
                      aria-pressed={showNewPassword}
                    >
                      <Icon name={showNewPassword ? 'eye-off-icon' : 'eye-icon'} size={20} />
                    </button>
                  }
                />

                <TextField
                  id={confirmPasswordId}
                  label="Confirm new password"
                  icon="lock-icon"
                  type={showConfirmPassword ? 'text' : 'password'}
                  placeholder="Confirm new password"
                  autoComplete="new-password"
                  value={confirmPassword}
                  error={errors.confirmPassword}
                  onChange={(event) => setConfirmPassword(event.target.value)}
                  trailing={
                    <button
                      type="button"
                      className="reset-password-form__toggle-visibility"
                      onClick={() => setShowConfirmPassword((value) => !value)}
                      aria-label={showConfirmPassword ? 'Hide password' : 'Show password'}
                      aria-pressed={showConfirmPassword}
                    >
                      <Icon name={showConfirmPassword ? 'eye-off-icon' : 'eye-icon'} size={20} />
                    </button>
                  }
                />

                <Button type="submit" loading={submitting} loadingText="Resetting…">
                  Reset Password
                </Button>
              </form>
            </>
          )}
        </div>
      </div>
    </div>
  )
}

export default ResetPasswordPage
