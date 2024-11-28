class AppConfig {
  AppConfig._();
  // static const String baseUrl = 'https://yourapi.com'; // Replace with the actual API URL
  static const String baseUrl = 'https://api.group.llc:4001/api/user'; // Replace with the actual API URL
  static const int timeoutDuration = 5000; // Optional: Timeout for API requests in milliseconds
  static const bool enableLogging = true; // Optional: Flag to enable/disable logging for debugging
}

class EndPoints {
  EndPoints._();
  static const userLogin = '/login';
  static const userSignUp = '/signUp';
  static const userForgotPassword = '/forgotPassword';
  static const userVerifyOTP = '/verifyOTP';
  static const userUpdatePassword = '/updatePassword';
  static const userSendOTP = '/sendOtp';
  static const rawDataPassing = '/rawDataPassing';
  static const requestModelPassing = '/requestModelPassing';
}
