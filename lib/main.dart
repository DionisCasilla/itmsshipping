import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';

import 'package:openseasapp/src/router/router.dart';
import 'package:openseasapp/src/setup/theme.dart';
import 'package:provider/provider.dart';

void main() {
  Flurorouter.configureRouter();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting("es_US");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'es';
    ThemeOpenSeas openSeasTheme = ThemeOpenSeas(isDark: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppBloc()),
      ],
      child: MaterialApp(
        title: 'Open Seas Shipping',
        theme: openSeasTheme.themeData,
        onGenerateRoute: Flurorouter.router.generator,
        initialRoute: "/",
        localizationsDelegates: [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          // ... other locales the app supports
        ],
        locale: Locale("es_US"),
      ),
    );
  }
}
