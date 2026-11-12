// Temporary mock auth layer standing in for a real backend endpoint.
// Replace `loginRequest` with an actual API call once one exists.
const MOCK_NETWORK_DELAY_MS = 900

export function loginRequest({ email, password }) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (password.length < 6) {
        reject(new Error('Invalid email or password.'))
        return
      }
      resolve({ email })
    }, MOCK_NETWORK_DELAY_MS)
  })
}

export function requestPasswordReset({ email }) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (!email.toLowerCase().endsWith('@troublecheat.com')) {
        reject(new Error('No account found with that email.'))
        return
      }
      resolve({ email })
    }, MOCK_NETWORK_DELAY_MS)
  })
}

// Mock OTP: "123456" always succeeds, standing in for the emailed code.
const MOCK_OTP_CODE = '123456'

export function verifyOtpRequest({ email, code }) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (code !== MOCK_OTP_CODE) {
        reject(new Error('Invalid or expired code. Please try again.'))
        return
      }
      resolve({ email })
    }, MOCK_NETWORK_DELAY_MS)
  })
}

export function resendOtpRequest({ email }) {
  return new Promise((resolve) => {
    setTimeout(() => resolve({ email }), MOCK_NETWORK_DELAY_MS)
  })
}

export function resetPasswordRequest({ password }) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (password.length < 6) {
        reject(new Error('Password must be at least 6 characters.'))
        return
      }
      resolve({ success: true })
    }, MOCK_NETWORK_DELAY_MS)
  })
}
