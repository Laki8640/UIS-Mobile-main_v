// To parse this JSON data, do
//
//     final editFormResponseModel = editFormResponseModelFromJson(jsonString);

import 'dart:convert';

EditFormResponseModel editFormResponseModelFromJson(String str) =>
    EditFormResponseModel.fromJson(json.decode(str));

String editFormResponseModelToJson(EditFormResponseModel data) =>
    json.encode(data.toJson());

class EditFormResponseModel {
  String status;
  String message;
  Data data;

  EditFormResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EditFormResponseModel.fromJson(Map<String, dynamic> json) =>
      EditFormResponseModel(
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
