// To parse this JSON data, do
//
//     final deleteFormResponseModel = deleteFormResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteFormResponseModel deleteFormResponseModelFromJson(String str) =>
    DeleteFormResponseModel.fromJson(json.decode(str));

String deleteFormResponseModelToJson(DeleteFormResponseModel data) =>
    json.encode(data.toJson());

class DeleteFormResponseModel {
  String status;
  String message;
  List<dynamic> data;

  DeleteFormResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteFormResponseModel.fromJson(Map<String, dynamic> json) =>
      DeleteFormResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
