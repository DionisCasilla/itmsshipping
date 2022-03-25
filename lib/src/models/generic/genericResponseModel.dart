import 'dart:convert';

class GenericResponse {
  GenericResponse({
    required this.success,
    required this.message,
    this.result,
  });

  dynamic result;
  String message = "Error en el servicio";
  bool success = false;

  factory GenericResponse.fromJson(Map<String, dynamic> json, dynamic modelData) => GenericResponse(
        result: modelData ?? {}, //json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] ?? "",
        success: json["success"] ?? false,
      );

  // Map<String, dynamic> toJson() => {
  //       "data": data == null ? null : data.toJson(),
  //       "message": message,
  //       "result": result,
  //     };
}
