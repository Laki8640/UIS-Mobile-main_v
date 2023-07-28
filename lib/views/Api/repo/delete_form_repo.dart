import 'dart:developer';

import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/views/Api/api_handlers.dart';
import 'package:universal_identification_system/views/Api/api_routs.dart';
import 'package:universal_identification_system/views/Api/model/response_model/delete_form_response_model.dart';

class DeleteFormRepo extends BaseService {
  Future deleteFormRepo({String formId = ''}) async {
    log('DELETE FORM URL==> ${BaseService.deleteFormUrl + PreferenceManager.getId() + '/' + formId}');

    Map<String, String>? header = {
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Accept": "*/*",
      "Content-Type": "application/json"
    };

    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: BaseService.deleteFormUrl + PreferenceManager.getId() + '/' + formId,
      header: header,
    );

    log('response ==> ${response}');

    DeleteFormResponseModel deleteFormResponseModel =
        DeleteFormResponseModel.fromJson(response);
    return deleteFormResponseModel;
  }
}
