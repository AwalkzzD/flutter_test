class AppApiCalls {
  AppApiCalls._();

  /// Timeout Constants
  static const int defaultResponseCacheTimeout = 10;

  static const int connectionTimeout = 5;
  static const int readTimeout = 5;
  static const int writeTimeout = 5;

  /// API BaseUrl
  static const String usersApiBaseUrl = "https://dummyapi.online/";

  /// API Endpoints
  static const String getUsers = "api/users";
}
