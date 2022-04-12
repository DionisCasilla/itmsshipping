import 'package:animate_do/animate_do.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
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
  final _router = FluroRouter();

  @override
  void initState() {
    // TODO: implement initState
    // animateController.addListener(() {
    //   print("object");
    //   if (animateController.isCompleted) {}
    // });
    super.initState();

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
    //  _router.navigateTo(context, "/home");
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  getInitData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    final _version = double.tryParse("$version");
    await Provider.of<AppBloc>(context, listen: false).getIniInfo();

    print(Provider.of<AppBloc>(context, listen: false).appLogin.config!.appversion);
    if (_version! < Provider.of<AppBloc>(context, listen: false).appLogin.config!.appversion) {
      await Future.delayed(Duration.zero, () => _actualizar());
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
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
