import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:openseasapp/src/constants/endpoint.dart';
import 'package:openseasapp/src/models/userListModel.dart';

import '../helper/gobalHelpper.dart';
import '../models/appLoginModel.dart';
import '../models/generic/genericResponseModel.dart';
import 'package:http/http.dart' as http;

import '../models/reciberForm.Model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class AppProvider {
  Future<GenericResponse> loginApp({String interID = 'OPENSEASSHIPPING'}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlPro : Endpoint.baseUrlDev;
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

      print(decodedata);
      ResultAppLogin.instance.token = respuesta.result.token;
      return respuesta;
      // return listDocumentType;
    } catch (e) {
      print(e);
      return GenericResponse(message: e.toString(), success: false);
    }
  }

  Future<List<UserModel>> listUser() async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlPro : Endpoint.baseUrlDev;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      print(ResultAppLogin.instance.token);
      // print(json.encode(userModel.toJson()));
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
      print(e);
      return [];
    }
  }

  Future<List<FormDataResult>> findFom({required String formId, String type = ""}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlPro : Endpoint.baseUrlDev;
    // UserPefilModel _userRespose = UserPefilModel(data: data, message: message, result: result, statusCode: statusCode);

    try {
      print(ResultAppLogin.instance.token);
      // print(json.encode(userModel.toJson()));
      final url = Uri.parse(_baseUrl + "itmsshipping/findForm/$formId/$type");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${ResultAppLogin.instance.token}'},
      ).timeout(const Duration(minutes: 1));

      final decodedata = json.decode(response.body);
      //  print(decodedata);
      List<FormDataResult> respuesta = [];
      if (decodedata["success"]) {
        respuesta = List<FormDataResult>.from(decodedata["result"].map((x) => FormDataResult.fromJson(x)));
      }

      return respuesta;
      // return listDocumentType;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map> saveForm({required Map infoPost}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlPro : Endpoint.baseUrlDev;
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

      return decodedata;
      // return listDocumentType;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<String> uploadImage({required File image, required String guid}) async {
    final _baseUrl = await GlobalHelpper().isInDebugMode ? Endpoint.baseUrlPro : Endpoint.baseUrlDev;

    final _cloudinary = Cloudinary("776156192642265", "i7GkyXZH6dp2LVb3ztBmsMIqtHE", "dfbwtygxk");
    final response = await _cloudinary.uploadFile(
      filePath: image.path,
      resourceType: CloudinaryResourceType.image,
      fileName: "$guid.jpg",
      folder: "itms/shipping/firmas",
    );

    print(response.secureUrl);
    return response.secureUrl.toString();
  }
}
