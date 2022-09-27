class GenericResponse {
  GenericResponse({required this.success, required this.message, this.result, this.errorModel});

  dynamic result;
  String message = "Error en el servicio";
  bool success = false;
  ErrorModel? errorModel;

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

class ErrorModel {
  final int? tipo;
  final String? message;

  ErrorModel({this.tipo, this.message});
}

enum tipoError { internet, tiempo }
