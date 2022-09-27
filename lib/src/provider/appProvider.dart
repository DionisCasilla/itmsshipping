import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:openseasapp/src/constants/endpoint.dart';
import 'package:openseasapp/src/models/formPendingModel.dart';
import 'package:openseasapp/src/models/formsavemode.dart';
import 'package:openseasapp/src/models/newformModel.dart';
import 'package:openseasapp/src/models/userListModel.dart';

import '../helper/gobalHelpper.dart';
import '../models/appLoginModel.dart';
import '../models/generic/genericResponseModel.dart';
import 'package:http/http.dart' as http;

import '../models/reciberForm.Model.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:http_parser/http_parser.dart';

import '../models/saveFormModel.dart';

class AppProvider {
  Future<GenericResponse> loginApp({String interID = 'OPENSEASSHIPPING'}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      // print(json.encode(userModel.toJson()));
      final url = Uri.parse(_baseUrl + "itmsshipping/apptoken/$interID");
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);

      final respuesta = GenericResponse.fromJson(decodedata, decodedata["success"] == true ? ResultAppLogin.fromJson(decodedata["result"]) : null);

      // print(decodedata);
      ResultAppLogin.instance.token = respuesta.result.token;
      return respuesta;
      // return listDocumentType;
    } catch (e) {
      // print(e);
      return GenericResponse(message: e.toString(), success: false);
    }
  }

  Future<List<UserModel>> listUser() async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      final url = Uri.parse(_baseUrl + "itmsshipping/userlist");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);
      //  print(decodedata);
      List<UserModel> respuesta = [];
      if (decodedata["success"]) {
        respuesta = List<UserModel>.from(decodedata["result"].map((x) => UserModel.fromJson(x)));
      }

      return respuesta;
      // return listDocumentType;
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  Future<GenericResponse> userkeyValidate({required String userkey}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      //  print(ResultAppLogin.instance.token);
      // print(json.encode(userModel.toJson()));
      final url = Uri.parse(_baseUrl + "itmsshipping/userkeyvalidate/$userkey/${UserModel.instance.userId}");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);

      final respuesta = GenericResponse.fromJson(decodedata, null);

      return respuesta;
      // return listDocumentType;
    } catch (e) {
      return GenericResponse(message: e.toString(), success: false);
    }
  }

  Future<GenericResponse> findFom({required String formId, String type = ""}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      final url = Uri.parse(_baseUrl + "itmsshipping/findForm/$formId/$type");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);
      //  print(decodedata);
      //    List<FormDataResult> respuesta = [];
      // if (decodedata["success"]) {
      final respuesta = GenericResponse.fromJson(decodedata, decodedata["success"] == true ? List<FormDataResult>.from(decodedata["result"].map((x) => FormDataResult.fromJson(x))) : null);

      // respuesta = List<FormDataResult>.from(decodedata["result"].map((x) => FormDataResult.fromJson(x)));
      //  }

      return respuesta;
      // return listDocumentType;
    } catch (e) {
      print(e);
      return GenericResponse(message: e.toString(), success: false);
    }
  }

  Future<GenericResponse> getFormPending() async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      final url = Uri.parse(_baseUrl + "itmsshipping/findFormPending");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);
      //  print(decodedata);
      //    List<FormDataResult> respuesta = [];
      // if (decodedata["success"]) {
      final respuesta = GenericResponse.fromJson(decodedata, decodedata["success"] == true ? List<ResultFormPending>.from(decodedata["result"].map((x) => ResultFormPending.fromJson(x))) : []);

      // respuesta = List<FormDataResult>.from(decodedata["result"].map((x) => FormDataResult.fromJson(x)));
      //  }

      return respuesta;
      // return listDocumentType;
    } catch (e) {
      print(e);
      return GenericResponse(message: e.toString(), success: false);
    }
  }

  Future<GenericResponse> saveForm({required Map infoPost}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      //   print(ResultAppLogin.instance.token);
      // print(json.encode(userModel.toJson()));
      final url = Uri.parse(_baseUrl + "itmsshipping/saveForm");
      final response = await http.post(
        url,
        body: jsonEncode(infoPost),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);

      final respuesta = GenericResponse.fromJson(decodedata, decodedata["success"] == true ? SaveFormModel.fromJson(decodedata["result"]) : null);

      return respuesta;
      // return listDocumentType;
      // }
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return GenericResponse(message: "", success: false, errorModel: ErrorModel(tipo: 1, message: "TimeOUT"));
    } on SocketException catch (e) {
      // Other exception
      return GenericResponse(message: "", success: false, errorModel: ErrorModel(tipo: 2, message: "Internet"));
    }
  }

  Future<List<ResultData>> newForm({String language = "ENU"}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      //   print(ResultAppLogin.instance.token);
      // print(json.encode(userModel.toJson()));
      final url = Uri.parse(_baseUrl + "itmsshipping/createForm/$language");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);

      //  final respuesta = GenericResponse.fromJson(decodedata, decodedata["success"] == true ? List<ResultData>.from(decodedata["result"].map((x) => ResultData.fromJson(x)))) : null);

      List<ResultData> respuesta = [];
      if (decodedata["success"]) {
        respuesta = List<ResultData>.from(decodedata["result"].map((x) => ResultData.fromJson(x)));
      }
      return respuesta;
      // return listDocumentType;
    } catch (e) {
      return [];
    }
  }

  Future<GenericResponse> saveNewForm({required Map datos}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      //   print(ResultAppLogin.instance.token);
      // print(json.encode(userModel.toJson()));

      Map datosPost = {"RowUsr": UserModel.instance.userId, "formbody": datos};
      final url = Uri.parse(_baseUrl + "itmsshipping/saveNewForm");
      final response = await http.post(
        url,
        body: jsonEncode(datosPost),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);

      final respuesta = GenericResponse.fromJson(decodedata, decodedata["success"] == true ? SaveFormModel2.fromJson(decodedata["result"]) : null);

      return respuesta;
      // List<ResultData> respuesta = [];
      // if (decodedata["success"]) {
      //   respuesta = List<ResultData>.from(decodedata["result"].map((x) => ResultData.fromJson(x)));
      // }
      // return respuesta;
      // return listDocumentType;
      // } catch (e) {
      //   return GenericResponse(message: e.toString(), success: false);
      // }
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return GenericResponse(message: "Time Out", success: false, errorModel: ErrorModel(tipo: 1, message: "TimeOut"));
    } on SocketException catch (_) {
      // Other exception
      return GenericResponse(message: "", success: false, errorModel: ErrorModel(tipo: 2, message: "Internet"));
    }
  }

  Future<GenericResponse> uploadImage({required File image, required String guid}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlDev : Endpoint.baseUrlPro;

    try {
      final _cloudinary = Cloudinary("776156192642265", "i7GkyXZH6dp2LVb3ztBmsMIqtHE", "dfbwtygxk");
      final response = await _cloudinary.uploadFile(
        filePath: image.path,
        resourceType: CloudinaryResourceType.image,
        fileName: guid,
        folder: "itms/shipping/firmas",
      );
      if (response.isSuccessful == false && response.error != null) {
        return GenericResponse(success: false, message: "Error to uplodad", result: "", errorModel: ErrorModel(tipo: response.error!.contains("SocketException") ? 2 : 1));
      } else {
        return GenericResponse(success: true, result: response.secureUrl ?? "", message: "");
      }
      // print(response.secureUrl);

    } on TimeoutException catch (_) {
      // A timeout occurred.
      return GenericResponse(message: "Time Out", success: false, errorModel: ErrorModel(tipo: 1, message: "TimeOut"));
    } on SocketException catch (_) {
      // Other exception
      return GenericResponse(message: "", success: false, errorModel: ErrorModel(tipo: 2, message: "Internet"));
    }
  }
}
