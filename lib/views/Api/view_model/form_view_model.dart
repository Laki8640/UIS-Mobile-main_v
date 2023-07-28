import 'dart:developer';

import 'package:get/get.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/create_profile_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/edit_form_response_model.dart';
import 'package:universal_identification_system/views/Api/repo/form_repo.dart';

import '../../../constant/common_snackBar.dart';

class FormViewModel extends GetxController {
  bool isLoader = false;

  ///for create form
  ApiResponse _apiResponseCreateForm =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponseCreateForm;

  Future<void> createFormModel({required var body}) async {
    _apiResponseCreateForm = ApiResponse.loading(message: 'Loading');
    update();
    try {
      CreateFormViewModel response =
          await FormRepo().createFormRepo(body: body);

      _apiResponseCreateForm = ApiResponse.complete(response);
      // CommonSnackBar.showSnackBar(
      //     title: response.status, message: response.message);
    } catch (e) {
      _apiResponseCreateForm = ApiResponse.error(message: e.toString());
      CommonSnackBar.showSnackBar(title: 'Something Went Wrong', message: '');
      log('e-------->>>>>>${e}');
    }
    update();
  }

  ///FOR EDIT FORM

  ApiResponse _apiResponseEditForm =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponseEditForm => _apiResponseEditForm;

  Future<void> editFormModel({required var body, String formId = ''}) async {
    _apiResponseEditForm = ApiResponse.loading(message: 'Loading');

    update();
    try {
      EditFormResponseModel response =
          await FormRepo().editFormRepo(body: body, formId: formId);

      _apiResponseEditForm = ApiResponse.complete(response);

      // CommonSnackBar.showSnackBar(
      //     title: response.status, message: response.message);
    } catch (e) {
      _apiResponseEditForm = ApiResponse.error(message: e.toString());
      CommonSnackBar.showSnackBar(title: 'Something Went Wrong', message: '');
      log('e-------->>>>>>${e}');
    }
    update();
  }
}
