import 'package:flutter/foundation.dart';
import 'package:openseasapp/src/models/appLoginModel.dart';
import 'package:openseasapp/src/models/newformModel.dart';
import 'package:openseasapp/src/models/userListModel.dart';
import 'package:openseasapp/src/provider/appProvider.dart';

class AppBloc with ChangeNotifier {
  final _appProvider = AppProvider();
  static final AppBloc _instancia = AppBloc._internal();

  factory AppBloc() {
    return _instancia;
  }

  AppBloc._internal() {
    getIniInfo();
    notifyListeners();
  }

  //
  ResultAppLogin appLogin = ResultAppLogin();
  List<UserModel> userListModel = [];
  List<ResultData> newform = [];

  getIniInfo() async {
    final respuesta = await _appProvider.loginApp();
    appLogin = respuesta.result;
    userListModel = await _appProvider.listUser();
    newform = await _appProvider.newForm();

    notifyListeners();
  }
}
