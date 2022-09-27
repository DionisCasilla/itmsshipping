import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class InternetAccessBloc with ChangeNotifier {
  bool? isConnected;

  temporizadorTurno() {
    Timer(const Duration(seconds: 2), () => getTurnoInfo(0));
  }

  Future<void> getTurnoInfo(int i) async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        //setState(() {
        isConnected = true;
        // print(isConnected);
        //});
      }
    } on SocketException catch (err) {
      //setState(() {
      isConnected = false;
      // });
      if (kDebugMode) {
        print(err);
      }
    }
    // print(_isConnected);
    notifyListeners();
  }
}
