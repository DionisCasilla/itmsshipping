// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../setup/setup.dart';

class BtnIpotecca extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final int tipoBtn;
  final bool borderR;
  final EdgeInsetsGeometry margin;

  /// [tipoBtn] 1 con fondo, 2 sin fondo,  .

  BtnIpotecca({Key? key, required this.label, required this.onPressed, this.tipoBtn = 1, this.borderR = false, this.margin = const EdgeInsets.all(25)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      animationDuration: Duration(seconds: 1),
      onPrimary: color050855,
      primary: color050855,
      // minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: borderR ? const BorderRadius.all(Radius.zero) : const BorderRadius.all(Radius.circular(80))),
    );

    return Container(
        color: Colors.transparent,
        width: double.infinity,
        height: widthheight(ctn: context, fSize: 50, tipo: 2),
        margin: margin,
        child: tipoBtn == 1
            ? ElevatedButton(
                autofocus: true,
                style: raisedButtonStyle,
                onPressed: onPressed,
                child: Text(label, style: textos(ctn: context, fontWeight: FontWeight.w700, fontFamily: "Poppins", customcolor: Colors.white)),
              )
            : tipoBtn == 2
                ? OutlinedButton(
                    // autofocus: true,
                    style: OutlinedButton.styleFrom(
                      animationDuration: Duration(seconds: 1),
                      shape: const StadiumBorder(),
                      side: const BorderSide(width: 2, color: color050855),
                    ),
                    onPressed: onPressed,
                    child: Text(label, style: textos(ctn: context, fontWeight: FontWeight.w700, fontFamily: "Poppins", customcolor: color050855)),
                  )
                : tipoBtn == 3
                    ? ElevatedButton(
                        // autofocus: true,
                        style: ElevatedButton.styleFrom(
                            animationDuration: Duration(seconds: 1),
                            onPrimary: Colors.green.shade500,
                            primary: Colors.green.shade500,
                            // minimumSize: const Size(88, 36),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(borderRadius: borderR ? const BorderRadius.all(Radius.zero) : const BorderRadius.all(Radius.circular(80)))),

                        onPressed: onPressed,
                        child: Text(label, style: textos(ctn: context, fontWeight: FontWeight.w700, fontFamily: "Poppins", customcolor: Colors.white)),
                      )
                    : InkWell(
                        onTap: onPressed,
                        child: Container(
                          child: Text(label, style: textos(ctn: context, fontWeight: FontWeight.w700, fontFamily: "Poppins", customcolor: color050855)),
                        ),
                      ));
  }
}
