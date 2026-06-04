class AppUrls {
  static const String _base = "http://localhost:10081/";

  static String getBaseUrl() => _base;

  ///auth
  static String getLoginUrl() => "${_base}auth/login";
  static String refreshTokenUrl() => "${_base}auth/refresh-token";
  static String getSignupUrl() => "${_base}auth/signup";

  ///users
  static String getProfile() => "${_base}users/profile";
  static String updateProfile() => "${_base}users/update-profile";
  static String deleteProfile() => "${_base}users/delete-profile";
}