// To parse this JSON data, do
//
//     final CreateFormViewModel = CreateFormViewModelFromJson(jsonString);

import 'dart:convert';

CreateFormViewModel createFormViewModelFromJson(String str) => CreateFormViewModel.fromJson(json.decode(str));

String createFormViewModelToJson(CreateFormViewModel data) => json.encode(data.toJson());

class CreateFormViewModel {
  String status;
  String message;
  Data data;

  CreateFormViewModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateFormViewModel.fromJson(Map<String, dynamic> json) => CreateFormViewModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int formId;

  Data({
    required this.formId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    formId: json["form_id"],
  );

  Map<String, dynamic> toJson() => {
    "form_id": formId,
  };
}
