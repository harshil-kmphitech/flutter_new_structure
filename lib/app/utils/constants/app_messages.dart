class AppMessages {
  AppMessages._();
  // Page Titles
  static const loginPageTitle = 'Login';
  static const registerPageTitle = 'Register';
  static const forgotPasswordPageTitle = 'Forgot Password';
  static const verifyCodePageTitle = 'Verify Code';
  static const resetPasswordPageTitle = 'Reset Password';

  // Form Labels
  static const emailLabel = 'Email';
  static const passwordLabel = 'Password';
  static const confirmPasswordLabel = 'Confirm Password';
  static const nameLabel = 'Name';
  static const phoneNumberLabel = 'Phone Number';
  static const newPasswordLabel = 'New Password';
  static const codeLabel = 'Verification Code';

  // Button Texts
  static const loginButton = 'Login';
  static const registerButton = 'Register';
  static const sendResetLinkButton = 'Send Reset Link';
  static const verifyButton = 'Verify Code';
  static const resetPasswordButton = 'Reset Password';

  // Redirect Texts
  static const registerRedirect = 'Don\'t have an account? Register';
  static const forgotPasswordRedirect = 'Forgot your password?';

  // Validation and Error Messages
  static const loginSuccess = 'Login successful';
  static const loginFailed = 'Login failed. Please try again';
  static const registerSuccess = 'Registration successful';
  static const registerFailed = 'Registration failed. Please try again';
  static const passwordResetEmailSent = 'Password reset email sent';
  static const passwordResetFailed = 'Failed to send reset email';
  static const passwordResetSuccess = 'Password reset successful';
  static const passwordMismatch = 'Passwords do not match';
  static const codeVerificationSuccess = 'Code verification successful';
  static const codeVerificationFailed = 'Code verification failed';
  static const emptyEmail = 'Please enter a email address';
  static const invalidEmail = 'Please enter a valid email address';
  static const emptyPassword = 'Please enter password';
  static const emptyName = 'Name should not be empty';
  static const emptyPhoneNumber = 'Please enter phone number';
  static const emptyConfirmPassword = 'Please enter confirm password';
  static const emptyVerificationCode = 'Please enter verification code';

  static const apiError = 'An error occurred. Please try again later';
  static const apiErrorDescription = 'Oops! Something went wrong. Please try again later.';
}
