import { useEffect, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import Button from '../../components/Button/Button.jsx'
import OtpInput from '../../components/OtpInput/OtpInput.jsx'
import { verifyOtpRequest, resendOtpRequest } from '../../data/mockAuth.js'
import './VerifyOtpPage.css'

const RESEND_COOLDOWN_SECONDS = 59
const VERIFIED_REDIRECT_DELAY_MS = 1600

function VerifyOtpPage({ email, onBack, onVerified }) {
  const [code, setCode] = useState('')
  const [resetSignal, setResetSignal] = useState(0)
  const [cooldown, setCooldown] = useState(RESEND_COOLDOWN_SECONDS)
  const [submitting, setSubmitting] = useState(false)
  const [resending, setResending] = useState(false)
  const [error, setError] = useState(null)
  const [verified, setVerified] = useState(false)

  useEffect(() => {
    if (cooldown <= 0) return undefined
    const timer = setInterval(() => {
      setCooldown((value) => Math.max(0, value - 1))
    }, 1000)
    return () => clearInterval(timer)
  }, [cooldown])

  useEffect(() => {
    if (!verified) return undefined
    const timer = setTimeout(() => onVerified?.(email), VERIFIED_REDIRECT_DELAY_MS)
    return () => clearTimeout(timer)
  }, [verified, email, onVerified])

  async function verifyCode(value) {
    setSubmitting(true)
    setError(null)
    try {
      await verifyOtpRequest({ email, code: value })
      setVerified(true)
    } catch (requestError) {
      setError(requestError.message)
    } finally {
      setSubmitting(false)
    }
  }

  function handleSubmit(event) {
    event.preventDefault()
    if (code.length !== 6 || submitting) return
    verifyCode(code)
  }

  async function handleResend() {
    if (cooldown > 0 || resending) return
    setResending(true)
    setError(null)
    try {
      await resendOtpRequest({ email })
      setCode('')
      setResetSignal((value) => value + 1)
      setCooldown(RESEND_COOLDOWN_SECONDS)
    } catch (requestError) {
      setError(requestError.message)
    } finally {
      setResending(false)
    }
  }

  return (
    <div className="verify-otp-page">
      <div className="verify-otp-page__panel">
        <div className="verify-otp-page__brand">
          <Icon name="login-brand-icon" width={67} height={60} />
        </div>

        <div className="verify-otp-page__heading">
          <p className="verify-otp-page__title">Trouble Cheat</p>
          <p className="verify-otp-page__subtitle">Admin Portal</p>
        </div>

        <div className="verify-otp-card">
          <button
            type="button"
            className="verify-otp-card__back"
            onClick={onBack}
            aria-label="Back to reset password"
          >
            <span aria-hidden="true">←</span> Back
          </button>

          {verified ? (
            <div className="verify-otp-card__success" role="status">
              <p className="verify-otp-card__success-title">Code verified</p>
              <p className="verify-otp-card__success-sub">Redirecting to sign in…</p>
            </div>
          ) : (
            <>
              <div className="verify-otp-card__intro">
                <p className="verify-otp-card__title">Enter OTP</p>
                <p className="verify-otp-card__subtitle">
                  6-digit code sent to {email || 'your email'}
                </p>
              </div>

              <form className="verify-otp-form" onSubmit={handleSubmit} noValidate>
                {error && (
                  <p className="verify-otp-form__banner" role="alert">
                    {error}
                  </p>
                )}

                <div className="verify-otp-form__code">
                  <OtpInput
                    key={resetSignal}
                    label="6-digit verification code"
                    error={Boolean(error)}
                    disabled={submitting}
                    onChange={setCode}
                    onComplete={verifyCode}
                  />
                  <p className="verify-otp-form__countdown" aria-live="polite">
                    {cooldown > 0 ? `Resend code in ${cooldown}s` : 'You can resend the code now'}
                  </p>
                </div>

                <Button
                  type="submit"
                  loading={submitting}
                  loadingText="Verifying…"
                  disabled={code.length !== 6}
                >
                  Verify Code
                </Button>

                <p className="verify-otp-form__resend">
                  Didn&apos;t receive?{' '}
                  <button
                    type="button"
                    className="verify-otp-form__resend-link"
                    onClick={handleResend}
                    disabled={cooldown > 0 || resending}
                  >
                    {resending ? 'Resending…' : 'Resend'}
                  </button>
                </p>
              </form>
            </>
          )}
        </div>
      </div>
    </div>
  )
}

export default VerifyOtpPage
