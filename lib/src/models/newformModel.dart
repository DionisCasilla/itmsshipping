// To parse this JSON data, do
//
//     final newFormModel = newFormModelFromJson(jsonString);

import 'dart:convert';

NewFormModel newFormModelFromJson(String str) => NewFormModel.fromJson(json.decode(str));

String newFormModelToJson(NewFormModel data) => json.encode(data.toJson());

class NewFormModel {
  NewFormModel({
    required this.success,
    required this.message,
    required this.result,
  });

  bool success;
  String message;
  List<ResultData> result;

  factory NewFormModel.fromJson(Map<String, dynamic> json) => NewFormModel(
        success: json["success"],
        message: json["message"],
        result: List<ResultData>.from(json["result"].map((x) => ResultData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class ResultData {
  ResultData({
    required this.description,
    required this.code,
    required this.enabled,
    this.requered = false,
    required this.id,
    // this.createdDate,
    required this.information,
  });

  String description;
  String code;
  bool enabled;
  bool requered;
  String id;
  // CreatedDate createdDate;
  List<InformationModel> information;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        description: json["description"],
        code: json["code"],
        enabled: json["enabled"] ?? false,
        requered: json["requered"] ?? false,
        id: json["id"],
        //   createdDate: json["createdDate"] == null ? null : createdDateValues.map[json["createdDate"]],
        information: List<InformationModel>.from(json["information"].map((x) => InformationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "code": code,
        "enabled": enabled,
        "id": id,
        //  "createdDate": createdDate == null ? null : createdDateValues.reverse[createdDate],
        "information": List<dynamic>.from(information.map((x) => x.toJson())),
      };
}

class InformationModel {
  InformationModel({this.description, this.enabled, this.requered = false, this.order, this.values, this.type, this.id, this.information
      // this.createdDate,
      });

  String? description;
  bool? enabled;
  bool requered = false;
  int? order;
  String? values;
  String? type;
  String? id;
  dynamic information;
  // CreatedDate createdDate;

  factory InformationModel.fromJson(Map<String, dynamic> json) => InformationModel(
      description: json["description"] ?? "",
      enabled: json["enabled"] ?? false,
      requered: json["requered"] ?? false,
      order: json["order"] ?? 0,
      values: json["values"] ?? "",
      type: json["type"] ?? "",
      id: json["id"] ?? "",
      information: json["information"]
      // createdDate: json["createdDate"] == null ? null : createdDateValues.map[json["createdDate"]],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "enabled": enabled,
        "order": order,
        "values": values,
        "type": type,
        "id": id,
        // "createdDate": createdDate == null ? null : createdDateValues.reverse[createdDate],
      };
}
