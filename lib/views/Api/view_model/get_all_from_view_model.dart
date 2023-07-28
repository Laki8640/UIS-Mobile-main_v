import 'dart:developer';

import 'package:get/get.dart';
import 'package:universal_identification_system/constant/common_circularIndicator.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/delete_form_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_all_form_response_model.dart';
import 'package:universal_identification_system/views/Api/repo/delete_form_repo.dart';
import 'package:universal_identification_system/views/Api/repo/get_all_form_repo.dart';

import '../../../constant/common_snackBar.dart';

class GetAllFormViewModel extends GetxController {
  bool isLoader = false;

  ///for get all form
  ApiResponse _apiResponseAllForm =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponseAllForm;

  Future<void> getAllFormViewModel() async {
    _apiResponseAllForm = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetAllFormResponseModel response =
          await GetAllFormRepo().getAllFormRepo();

      _apiResponseAllForm = ApiResponse.complete(response);
      // CommonSnackBar.showSnackBar(
      //     title: response.status, message: response.message);
    } catch (e) {
      _apiResponseAllForm = ApiResponse.error(message: e.toString());
      CommonSnackBar.showSnackBar(title: 'Something Went Wrong', message: '');
      log('e-------->>>>>>${e}');
    }
    update();
  }

  ///for get all form
  ApiResponse _apiResponseDeleteForm =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponseDeleteForm => _apiResponseDeleteForm;

  Future<void> deleteFormViewModel({String formId = ''}) async {
    CommonCircular.showCircularIndicatorLoader();

    _apiResponseDeleteForm = ApiResponse.loading(message: 'Loading');
    update();
    try {
      DeleteFormResponseModel response =
          await DeleteFormRepo().deleteFormRepo(formId: formId);

      _apiResponseDeleteForm = ApiResponse.complete(response);
      CommonCircular.hideCircularIndicatorLoader();
      CommonSnackBar.showSnackBar(
          title: response.status, message: response.message);
    } catch (e) {
      CommonCircular.hideCircularIndicatorLoader();
      _apiResponseDeleteForm = ApiResponse.error(message: e.toString());
      CommonSnackBar.showSnackBar(title: 'Something Went Wrong', message: '');
      log('e-------->>>>>>${e}');
    }
    update();
  }
}
