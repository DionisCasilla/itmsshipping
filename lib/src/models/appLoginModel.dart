import 'package:flutter/material.dart';

class ResultAppLogin {
  ResultAppLogin._privateConstructor();

  static final ResultAppLogin _instance = ResultAppLogin._privateConstructor();

  static ResultAppLogin get instance {
    return _instance;
  }

  ResultAppLogin({
    this.config,
    this.token = "",
  });

  Config? config;
  String token = "";

  factory ResultAppLogin.fromJson(Map<String, dynamic> json) => ResultAppLogin(
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "config": config == null ? null : config!.toJson(),
        "token": token,
      };
}

class Config {
  Config({this.btnshippingform = false, this.active = false, this.appversion = 1, this.urldonwload = ""});

  bool btnshippingform;
  bool active;
  double appversion;
  String urldonwload;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        btnshippingform: json["btnshippingform"] ?? false,
        active: json["active"] ?? false,
        appversion: double.tryParse(json["appversion"]) ?? 1,
        urldonwload: json["urldonwload"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "btnshippingform": btnshippingform,
        "active": active,
      };
}
