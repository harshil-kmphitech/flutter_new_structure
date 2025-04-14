class AppConfig {
  AppConfig._();

  static const String baseUrl = 'https://kmclientapp.co.in:3030/api';
  static const sendTime = Duration(minutes: 1);
  static const receiveTime = Duration(minutes: 1);
  static const connectTime = Duration(seconds: 20);
}

class EndPoints {
  EndPoints._();
  static const refreshToken = '/auth/refreshToken';
  static const userLogin = '/auth/login';
  static const userSignUp = '/signUp';
  static const userForgotPassword = '/forgotPassword';
  static const userVerifyOTP = '/verifyOTP';
  static const userUpdatePassword = '/updatePassword';
  static const userSendOTP = '/sendOtp';
  static const rawDataPassing = '/rawDataPassing';
  static const requestModelPassing = '/requestModelPassing';
}
