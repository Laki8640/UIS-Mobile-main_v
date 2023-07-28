abstract class BaseService<T> {
  static const String baseUrl = 'https://uis.sataware.dev/api';

  ///profile url
  static const String signUpUrl = '$baseUrl/register';
  static const String loginUrl = '$baseUrl/login';
  static const String checkUserStatusUrl = '$baseUrl/user/status/';
  static const String updateProfileUrl = '$baseUrl/user/updateProfile/';

  ///form url
  static const String createFormUrl = '$baseUrl/forms/create/';
  static const String updateFormUrl = '$baseUrl/forms/update/';

  static const String getAllFormsUrl = '$baseUrl/forms/';
  static const String deleteFormUrl = '$baseUrl/forms/delete/';

  ///get country,city,state
  static const String countryUrl = '$baseUrl/countries';
  // static const String cityUrl = '$baseUrl/countries';
  static const String stateUrl = '$baseUrl/states';
}
