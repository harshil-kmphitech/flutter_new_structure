class AppConfig {
  AppConfig._();
  static const String baseUrl = 'https://yourapi.com';
  static const sendTimeout = Duration(minutes: 1);
  static const receiveTimeout = Duration(minutes: 1);
  static const connectTimeout = Duration(seconds: 20);
}
