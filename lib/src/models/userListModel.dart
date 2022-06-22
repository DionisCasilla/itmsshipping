// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  UserListModel({
    required this.listUserModel,
  });

  List<UserModel> listUserModel;

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        listUserModel: json["result"] == null ? [] : List<UserModel>.from(json["result"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": listUserModel == null ? null : List<dynamic>.from(listUserModel.map((x) => x.toJson())),
      };
}

class UserModel {
  UserModel._privateConstructor();

  static final UserModel _instance = UserModel._privateConstructor();

  static UserModel get instance {
    return _instance;
  }

  UserModel({
    required this.interId,
    required this.userId,
    required this.userName,
    required this.userRole,
    required this.userLangID,
    this.keyRequered = false,
  });

  String interId = "";
  String userId = "";
  String userName = "";
  String userRole = "";
  String userLangID = "ENU";
  bool keyRequered = false;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        interId: json["InterID"] ?? "",
        userId: json["UserID"] ?? "",
        userName: json["UserName"] ?? "",
        userRole: json["UserRole"] ?? "",
        userLangID: json["UserLangID"] ?? "ENU",
        keyRequered: json["KeyRequered"] == "true" ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "InterID": interId == null ? null : interId,
        "UserID": userId == null ? null : userId,
        "UserName": userName == null ? null : userName,
        "UserRole": userRole == null ? null : userRole,
      };
}
