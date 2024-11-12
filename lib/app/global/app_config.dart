class AppConfig {
  AppConfig._();
  // static const String baseUrl = 'https://yourapi.com'; // Replace with the actual API URL
  static const String baseUrl = 'https://api.group.llc:4001/api'; // Replace with the actual API URL
  static const int timeoutDuration = 5000; // Optional: Timeout for API requests in milliseconds
  static const bool enableLogging = true; // Optional: Flag to enable/disable logging for debugging
}

class EndPoints {
  EndPoints._();
  static const userLogin = '/user/login';
  static const userSignUp = '/user/signUp';
  static const userForgotPassword = '/user/forgotPassword';
  static const userVerifyOTP = '/user/verifyOTP';
  static const userUpdatePassword = '/user/updatePassword';
  static const userSendOTP = '/user/sendOtp';
}
