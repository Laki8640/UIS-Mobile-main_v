import 'dart:developer';

import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/views/Api/api_handlers.dart';
import 'package:universal_identification_system/views/Api/api_routs.dart';
import 'package:universal_identification_system/views/Api/model/response_model/create_profile_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/edit_form_response_model.dart';

class FormRepo extends BaseService {
  Future createFormRepo({required Map<String, dynamic> body}) async {
    log('BaseService.createFormUrl+PreferenceManager.getId() ==> ${BaseService.createFormUrl + PreferenceManager.getId()}');

    Map<String, String>? header = {
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Accept": "*/*",
      "Content-Type": "multipart/form-data"
    };

    var response = await ApiService().getResponse(
        apiType: APIType.aImageForm,
        url: BaseService.createFormUrl + PreferenceManager.getId(),
        body: body,
        header: header);

    log('response ==> ${response}');

    CreateFormViewModel createFormViewModel =
        CreateFormViewModel.fromJson(response);
    return createFormViewModel;
  }

  Future editFormRepo(
      {required Map<String, dynamic> body, String formId = ''}) async {
    log('BaseService.createFormUrl+PreferenceManager.getId() ==> ${BaseService.updateFormUrl + PreferenceManager.getId() + '/' + formId}');

    Map<String, String>? header = {
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Accept": "*/*",
      "Content-Type": "multipart/form-data"
    };

    var response = await ApiService().getResponse(
        apiType: APIType.aImageForm,
        url: BaseService.updateFormUrl +
            PreferenceManager.getId() +
            '/' +
            formId,
        body: body,
        header: header);

    log('response ==> ${response}');

    EditFormResponseModel editFormResponseModel =
        EditFormResponseModel.fromJson(response);
    return editFormResponseModel;
  }
}
