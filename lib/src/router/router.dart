import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:openseasapp/src/pages/SplashPage.dart';
import 'package:openseasapp/src/pages/homePage.dart';
import 'package:openseasapp/src/pages/selectOperationPage.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static void configureRouter() {
    router.define("/", handler: kIsWeb ? _homepage : _SplashPage);
    router.define("/home", handler: _homepage);
    router.define("/operation", handler: _selectoperationpage);
    router.notFoundHandler = _homepage;
  }

  static final Handler _homepage = Handler(handlerFunc: (ctx, params) {
    return HomePage(title: 'Open Seas Shipping');
  });

  static final Handler _selectoperationpage = Handler(handlerFunc: (ctx, params) {
    return SelectOperationPage();
  });

  static final Handler _SplashPage = Handler(handlerFunc: (ctx, params) {
    return SplashAppPage();
  });
}
