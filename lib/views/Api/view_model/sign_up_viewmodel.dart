import 'dart:developer';

import 'package:get/get.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/check_user_status_res_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_country_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_state_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/login_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/sign_up_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/update_profile_view_model.dart';
import 'package:universal_identification_system/views/Api/repo/login_repo.dart';
import 'package:universal_identification_system/views/Api/repo/sign_up_repo.dart';

class SignUpViewModel extends GetxController {
  ///for sign up
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> signUpViewModel({required Map<String, dynamic> body}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      SignUpResponseModel response = await SignUpRepo().signUpRepo(body: body);
      print('==SignUpResponseModel=>$response');

      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      _apiResponse = ApiResponse.error(message: e.toString());
      print(".........   $e");
    }
    update();
  }

  ///for login
  ApiResponse _apiResponseLogin =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponseLogin => _apiResponseLogin;

  Future<void> loginViewModel({required Map<String, dynamic> body}) async {
    _apiResponseLogin = ApiResponse.loading(message: 'Loading');
    update();
    try {
      LoginResponseModel response = await LoginRepo().loginRepo(body: body);
      print('==LoginResponseModel=>$response');

      _apiResponseLogin = ApiResponse.complete(response);
    } catch (e) {
      _apiResponseLogin = ApiResponse.error(message: e.toString());
      print(".........   $e");
    }
    update();
  }

  ///for checkUser status
  ApiResponse _apiResponseCheckUser =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponseCheckUser => _apiResponseCheckUser;

  Future<void> checkUserStatusViewModel(
      {required Map<String, dynamic> body}) async {
    _apiResponseCheckUser = ApiResponse.loading(message: 'Loading');
    update();
    try {
      CheckUserStatusResponseModel response =
          await SignUpRepo().checkUserStatus(body: body);
      print('==LoginResponseModel=>$response');

      _apiResponseCheckUser = ApiResponse.complete(response);
    } catch (e) {
      _apiResponseCheckUser = ApiResponse.error(message: e.toString());
      print(".........   $e");
    }
    update();
  }

  ///for update profile
  ApiResponse _apiResponseUpdateProfile =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponseUpdateProfile => _apiResponseUpdateProfile;

  Future<void> updateProfileViewModel(
      {required Map<String, dynamic> body}) async {
    _apiResponseUpdateProfile = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateProfileViewModel response =
          await SignUpRepo().updateProfile(body: body);
      print('==UpdateProfileViewModel=>$response');

      _apiResponseUpdateProfile = ApiResponse.complete(response);
    } catch (e) {
      _apiResponseUpdateProfile = ApiResponse.error(message: e.toString());
      print(".........   $e");
    }
    update();
  }

  List<Country> country = [];

  setCountry(Country value) {
    country.add(value);
    update();
  }

  List<StateClass> state = [];
  setStates(StateClass value) {
    state.add(value);
    update();
  }

  ///getCountry
  ApiResponse _apiResponseCountries =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponseCountries => _apiResponseCountries;

  ///get state
  ApiResponse _apiResponseStates =
      ApiResponse.initial(message: 'Initialization');
  ApiResponse get apiResponseStates => _apiResponseStates;

  Future<void> getCountryViewModel({required Map<String, dynamic> body}) async {
    _apiResponseCountries = ApiResponse.loading(message: 'Loading');
    update();
    try {
      CountryResponseModel response =
          await SignUpRepo().getCountries(body: body);
      print('==CountryResponseModel=>$response');

      _apiResponseCountries = ApiResponse.complete(response);
    } catch (e) {
      _apiResponseCountries = ApiResponse.error(message: e.toString());
      print(".........   $e");
    }
    update();
  }

  Future<void> getStateViewModel(
      {required Map<String, dynamic> body, String countryCode = ''}) async {
    _apiResponseStates = ApiResponse.loading(message: 'Loading');
    update();

    final countryCodeValue = countryCode.isEmpty
        ? country.isNotEmpty
            ? country.first.id.toString()
            : ''
        : countryCode;

    try {
      StateResponseModel response = await SignUpRepo()
          .getStates(body: body, countryCode: countryCodeValue.toString());
      print('==StateResponseModel=>$response');

      _apiResponseStates = ApiResponse.complete(response);
    } catch (e) {
      _apiResponseStates = ApiResponse.error(message: e.toString());
      print(".........   $e");
    }
    update();
  }
}
