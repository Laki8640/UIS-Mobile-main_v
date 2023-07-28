

import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) => SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) => json.encode(data.toJson());

class SignUpResponseModel {
  dynamic status;
  dynamic message;
  dynamic data;

  SignUpResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
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
// {
// "status": "success",
// "message": "Successfully Registered",
// "data": {
// "user_id": 14
// }
// }
class Data {
  int userId;

  Data({
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
