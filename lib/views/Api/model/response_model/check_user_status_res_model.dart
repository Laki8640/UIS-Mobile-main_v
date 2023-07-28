// To parse this JSON data, do
//
//     final checkUserStatusResponseModel = checkUserStatusResponseModelFromJson(jsonString);

import 'dart:convert';

CheckUserStatusResponseModel checkUserStatusResponseModelFromJson(String str) => CheckUserStatusResponseModel.fromJson(json.decode(str));

String checkUserStatusResponseModelToJson(CheckUserStatusResponseModel data) => json.encode(data.toJson());

class CheckUserStatusResponseModel {
  String status;
  String message;
  dynamic data;

  CheckUserStatusResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CheckUserStatusResponseModel.fromJson(Map<String, dynamic> json) => CheckUserStatusResponseModel(
    status: json["status"],
    message: json["message"],
    data:json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String status;

  Data({
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
