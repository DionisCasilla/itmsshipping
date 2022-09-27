import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/bloc/internetAccessBloc.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:openseasapp/src/pages/homePage.dart';
import 'package:openseasapp/src/setup/setup.dart';
import 'package:openseasapp/src/widgets/updateApp.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../constants/appImages.dart';

class SplashAppPage extends StatefulWidget {
  const SplashAppPage({Key? key}) : super(key: key);

  @override
  State<SplashAppPage> createState() => _SplashAppPageState();
}

class _SplashAppPageState extends State<SplashAppPage> {
  late AnimationController animateController;
  final _appBloc = AppBloc();
  final _router = FluroRouter();

  @override
  void initState() {
    // TODO: implement initState
    AppBloc();
    super.initState();

    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<InternetAccessBloc>(context).temporizadorTurno();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: ZoomIn(
            //delay: const Duration(seconds: 6),
            child: Image.asset(
              AppImages.openseasIco,
              width: widthheight(ctn: context, fSize: 260),
              // height: widthheight(ctn: context, fSize: 660, tipo: 2),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  getInitData() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      await _appBloc.getIniInfo();
      //String appName = packageInfo.appName;
      //  String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      final _version = int.tryParse(buildNumber);
      Provider.of<AppBloc>(context, listen: false).appLogin?.currentAppVersion = "Ver: " + version + "." + _version.toString();
      if (Provider.of<AppBloc>(context, listen: false).appLogin != null) {
        if (Provider.of<AppBloc>(context, listen: false).appLogin!.config!.appversion > _version!) {
          await Future.delayed(Duration.zero, () => _actualizar());
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        await GlobalHelpper().errorOpenAPP(context);
        SystemNavigator.pop();
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return GlobalHelpper().errorOpenAPP(context);
        //     });
      }
    } on TimeoutException catch (t) {
      // A timeout occurred.
      // print(t);
    } on SocketException catch (e) {
      print(e);
      // Other exception
    }
  }

  Future<void> _actualizar() async {
    final res = await GlobalHelpper().updateAPP(context);

    //  print(res);
    if (res) {
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ActualizacionPage();
          });
    }
  }
}
