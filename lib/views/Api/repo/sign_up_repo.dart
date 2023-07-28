import 'dart:convert';
import 'dart:developer';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/views/Api/model/response_model/check_user_status_res_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_country_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_state_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/update_profile_view_model.dart';

import '../api_handlers.dart';
import '../api_routs.dart';
import '../model/response_model/sign_up_response_model.dart';

class SignUpRepo extends BaseService {
  Future signUpRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
        apiType: APIType.aPost, url: BaseService.signUpUrl, body: body);
    print('++++++++++++++++++++++++RESPONSE   $response');
    SignUpResponseModel signUpResponseModel =
        SignUpResponseModel.fromJson(response);

    log('-----------------------$signUpResponseModel');
    log('-----------------------${BaseService.signUpUrl}');
    return signUpResponseModel;
  }

  Future checkUserStatus({required Map<String, dynamic> body}) async {
    log('BaseService.checkUserStatusUrl+PreferenceManager.getId() ==> ${BaseService.checkUserStatusUrl + PreferenceManager.getId()}');

    var response = await ApiService().getResponse(
        apiType: APIType.aGet,
        url: BaseService.checkUserStatusUrl + PreferenceManager.getId(),
        body: body);
    print('++++++++++++++++++++++++RESPONSE   $response');
    CheckUserStatusResponseModel checkUserStatusResponseModel =
        CheckUserStatusResponseModel.fromJson(response);

    return checkUserStatusResponseModel;
  }

  Future updateProfile({required Map<String, dynamic> body}) async {
    log('BaseService.updateProfileUrl+PreferenceManager.getId() ==> ${BaseService.updateProfileUrl + PreferenceManager.getId()}');

    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        url: BaseService.updateProfileUrl + PreferenceManager.getId(),
        body: body);
    print('++++++++++++++++++++++++RESPONSE   $response');
    UpdateProfileViewModel updateProfileViewModel =
        UpdateProfileViewModel.fromJson(response);

    return updateProfileViewModel;
  }

  Future getCountries({required Map<String, dynamic> body}) async {
    log('BaseService.countryUrl====>${BaseService.countryUrl}');
    var response = await ApiService().getResponse(
        apiType: APIType.aGet, url: BaseService.countryUrl, body: body);
    print('++++++++++++++++++++++++RESPONSE   $response');
    CountryResponseModel countryResponseModel =
        CountryResponseModel.fromJson(response);

    return countryResponseModel;
  }

  Future getStates(
      {required Map<String, dynamic> body, String countryCode = ''}) async {
    log('BaseService.stateUrl====>${BaseService.stateUrl}');
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '${BaseService.stateUrl}/$countryCode',
      body: body,
    );
    print('++++++++++++++++++++++++RESPONSE   $response');
    StateResponseModel stateResponseModel =
        StateResponseModel.fromJson(response);

    return stateResponseModel;
  }
}
