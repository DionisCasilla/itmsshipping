// To parse this JSON data, do
//
//     final formPending = formPendingFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:convert';

FormPending formPendingFromJson(String str) => FormPending.fromJson(json.decode(str));

String formPendingToJson(FormPending data) => json.encode(data.toJson());

class FormPending {
  FormPending({
    this.result,
  });

  List<ResultFormPending>? result;

  factory FormPending.fromJson(Map<String, dynamic> json) => FormPending(
        result: json["result"] == null ? [] : List<ResultFormPending>.from(json["result"].map((x) => ResultFormPending.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class ResultFormPending {
  ResultFormPending({
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
    required this.reicipitUrl,
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
  String reicipitUrl;

  factory ResultFormPending.fromJson(Map<String, dynamic> json) => ResultFormPending(
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
        invoiceValue: json["InvoiceValue"] ?? 0000,
        reicipitUrl: json["ReicipitUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "InterID": interId ?? null,
        "FormID": formId ?? null,
        "FormNumber": formNumber ?? null,
        "SenderName": senderName ?? null,
        "RecieverName": recieverName ?? null,
        "RecieverAddress": recieverAddress ?? null,
        "RecieverCity": recieverCity ?? null,
        "RecieverPhone": recieverPhone ?? null,
        "PackageType": packageType ?? null,
        "PackageContent": packageContent ?? null,
        "CurrencyID": currencyId ?? null,
        "InvoiceValue": invoiceValue ?? null,
        "ReicipitUrl": reicipitUrl ?? null,
      };
}
