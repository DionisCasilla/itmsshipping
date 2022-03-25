import '../constants/colors.dart';
import 'package:flutter/material.dart';

class ThemeOpenSeas {
  bool isDark;

  ThemeOpenSeas({required this.isDark});

  ThemeData get themeData {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme = (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
    //Color txtColor = txtTheme.bodyText1.color;
    ColorScheme colorScheme = ColorScheme(
        // Decide how you want to apply your own custom them, to the MaterialApp
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: color050855,
        // primaryVariant: color050855,
        secondary: color050855,
        // secondaryVariant: color050855,
        background: colorE5E5E5,
        surface: color050855,
        onBackground: color050855,
        onSurface: color050855,
        onError: color050855,
        onPrimary: color050855,
        onSecondary: color050855,
        error: colore83435);

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    var t = ThemeData(
            textTheme: txtTheme,
            colorScheme: colorScheme,
            fontFamily: "Popppins",
            primaryColor: color050855,
            // accentColor: ReferenciaPrimary,
            //appBarTheme: AppBarTheme(color: ReferenciaPrimary),
            scaffoldBackgroundColor: colorE5E5E5)
        //  iconTheme: IconThemeData(color: ReferenciaBlack),
        // inputDecorationTheme: InputDecorationTheme(fillColor: ReferenciaPrimary))
        // We can also add on some extra properties that ColorScheme seems to miss
        .copyWith(
            primaryColor: color050855,
            bottomAppBarColor: color050855,
            bottomAppBarTheme: const BottomAppBarTheme(color: color050855),
            // buttonColor: ReferenciaPrimary,
            // cursorColor: ReferenciaWhite,
            highlightColor: color050855,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: color050855),
            toggleableActiveColor: color050855,
            inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide(color: color050855))),
            iconTheme: const IconThemeData(color: color050855),
            buttonTheme: const ButtonThemeData(buttonColor: color050855, textTheme: ButtonTextTheme.primary));

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}
