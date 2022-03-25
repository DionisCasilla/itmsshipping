// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  UserListModel({
    required this.result,
  });

  List<FormDataResult> result;

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        result: json["result"] == null ? [] : List<FormDataResult>.from(json["result"].map((x) => FormDataResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? [] : List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class FormDataResult {
  FormDataResult({
    required this.interId,
    required this.formId,
    required this.formNumber,
    required this.senderName,
    required this.recieverName,
    required this.recieverAddress,
    required this.recieverCity,
    required this.recieverPhone,
    required this.packageType,
    required this.packageContent,
    required this.currencyId,
    required this.invoiceValue,
  });

  String interId;
  String formId;
  String formNumber;
  String senderName;
  String recieverName;
  String recieverAddress;
  String recieverCity;
  String recieverPhone;
  String packageType;
  String packageContent;
  String currencyId;
  int invoiceValue;

  factory FormDataResult.fromJson(Map<String, dynamic> json) => FormDataResult(
        interId: json["InterID"] ?? "",
        formId: json["FormID"] ?? "",
        formNumber: json["FormNumber"] ?? "",
        senderName: json["SenderName"] ?? "",
        recieverName: json["RecieverName"] ?? "",
        recieverAddress: json["RecieverAddress"] ?? "",
        recieverCity: json["RecieverCity"] ?? "",
        recieverPhone: json["RecieverPhone"] ?? "",
        packageType: json["PackageType"] ?? "",
        packageContent: json["PackageContent"] ?? "",
        currencyId: json["CurrencyID"] ?? "",
        invoiceValue: json["InvoiceValue"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "InterID": interId == null ? null : interId,
        "FormID": formId == null ? null : formId,
        "FormNumber": formNumber == null ? null : formNumber,
        "SenderName": senderName == null ? null : senderName,
        "RecieverName": recieverName == null ? null : recieverName,
        "RecieverAddress": recieverAddress == null ? null : recieverAddress,
        "RecieverCity": recieverCity == null ? null : recieverCity,
        "RecieverPhone": recieverPhone == null ? null : recieverPhone,
        "PackageType": packageType == null ? null : packageType,
        "PackageContent": packageContent == null ? null : packageContent,
        "CurrencyID": currencyId == null ? null : currencyId,
        "InvoiceValue": invoiceValue == null ? null : invoiceValue,
      };
}
