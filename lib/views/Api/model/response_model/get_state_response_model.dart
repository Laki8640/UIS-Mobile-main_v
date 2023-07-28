import 'dart:convert';

StateResponseModel stateResponseModelFromJson(String str) =>
    StateResponseModel.fromJson(json.decode(str));

String stateResponseModelToJson(StateResponseModel data) =>
    json.encode(data.toJson());

class StateResponseModel {
  String status;
  String message;
  List<StateClass> data;

  StateResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StateResponseModel.fromJson(Map<String, dynamic> json) =>
      StateResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<StateClass>.from(
            json["data"].map((x) => StateClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StateClass {
  int id;
  String name;

  StateClass({
    required this.id,
    required this.name,
  });

  factory StateClass.fromJson(Map<String, dynamic> json) => StateClass(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
