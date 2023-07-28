import 'dart:convert';
import 'dart:developer';

import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/views/Api/api_handlers.dart';
import 'package:universal_identification_system/views/Api/api_routs.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_all_form_response_model.dart';

class GetAllFormRepo extends BaseService {
  Future getAllFormRepo() async {
    log('URL GET ALL FORM REPo ==> ${BaseService.getAllFormsUrl + PreferenceManager.getId()}');

    Map<String, String>? header = {
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Accept": "*/*",
      "Content-Type": "application/json"
    };

    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: BaseService.getAllFormsUrl + PreferenceManager.getId(),
      header: header,
    );

    log('response ==> ${response}');

    GetAllFormResponseModel getAllFormResponseModel =
        GetAllFormResponseModel.fromJson(response);
    return getAllFormResponseModel;
  }
}
