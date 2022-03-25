import 'package:animate_do/animate_do.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/pages/homePage.dart';
import 'package:openseasapp/src/setup/setup.dart';
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
          delay: const Duration(seconds: 6),
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
    Future.delayed(
        const Duration(seconds: 7),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ));
    // await Provider.of<AppBloc>(context, listen: false).getIniInfo();
  }
}
