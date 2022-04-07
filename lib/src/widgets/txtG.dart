import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:openseasapp/src/constants/colors.dart';

import '../helper/cresponsive.dart';

class TxtG extends StatelessWidget {
  String? label;
  String hintText;
  TextInputType textInputType;
  TextEditingController? controller;
  Function? onChangedStream;
  Function? onChangedText;
  VoidCallback? txtonTap;
  bool isObscureText;
  int lineOnText;
  String maskString;
  String? id;
  VoidCallback? onclickTap;
  bool isReadOnly;
  List<TextInputFormatter>? textInputFormatter;
  dynamic prefixIconF;
  double? prefixIconFZise;
  IconData? suffixIconF;
  Widget? suffixWi;
  double? suffixIconFZise;
  Color colorIcon;
  VoidCallback? prefixIconClick;

  TxtG(
      {Key? key,
      this.label,
      this.hintText = "",
      this.textInputType = TextInputType.text,
      this.controller,
      this.txtonTap,
      this.onChangedText,
      this.onChangedStream,
      this.isObscureText = false,
      this.lineOnText = 1,
      this.maskString = "",
      this.isReadOnly = false,
      this.id,
      this.textInputFormatter,
      this.colorIcon = color050855,
      this.prefixIconF,
      this.prefixIconFZise = 20,
      this.suffixIconFZise = 20,
      this.suffixIconF,
      this.prefixIconClick,
      this.onclickTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (lineOnText == 1 ? 8 : 10.0), bottom: (lineOnText == 1 ? 0 : 10.0)),
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: widthheight(ctn: context, fSize: (lineOnText == 1 ? 90 : 60 * double.parse(lineOnText.toString())), tipo: 2),
        width: widthheight(ctn: context, fSize: 328),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          //color: Colors.red,
          borderRadius: BorderRadius.circular(
            widthheight(ctn: context, fSize: 8),
          ),
          // border: Border.all(color: Colo)
        ),
        child: Stack(
          fit: StackFit.expand,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label != null
                ? Positioned(
                    //  top: widthheight(ctn: context, fSize: 1, tipo: 2),
                    left: widthheight(ctn: context, fSize: 20, tipo: 2),
                    // bottom: widthheight(ctn: context, fSize: 20, tipo: 2),
                    child: Text(
                      label ?? "",
                      style: textos(ctn: context, fSize: 16, fontWeight: FontWeight.w500, fontFamily: "Poppins", customcolor: color050855),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.only(top: widthheight(ctn: context, fSize: lineOnText == 1 ? 16 : 18), left: widthheight(ctn: context, fSize: 14), right: widthheight(ctn: context, fSize: 16)),
              child: TxtGeneric(
                // isDense: false,
                txtController: controller ?? TextEditingController(),
                inputType: textInputType,
                isBorder: true,
                txtonTap: txtonTap ?? () {},
                isObscureText: isObscureText,
                lineOnText: lineOnText,
                maskString: maskString,
                isReadOnly: isReadOnly,
                textInputFormatter: textInputFormatter ?? [],
                prefixIconF: prefixIconF,
                prefixIconFZise: prefixIconFZise!,
                prefixIconClick: prefixIconClick,
                // isFillColor: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TxtGeneric extends StatefulWidget {
  final String? label;
  final bool isBorder;
  final bool isDense;
  final bool isFillColor;
  final bool? isObscureText;
  final EdgeInsets txtPaddingAll;
  final double? txtRadiusBorder;
  final TextEditingController? txtController;
  final dynamic prefixIconF;
  final double? prefixIconFZise;
  final IconData? suffixIconF;
  final Widget? suffixWi;
  final double? suffixIconFZise;
  final Color? colorIcon;
  final Stream? txtStream;
  final Function? onChangedStream;
  final Function? onChangedText;
  final VoidCallback? txtonTap;
  final TextInputType inputType;
  final FocusNode? txtfocusNode;
  final EdgeInsets containerPadding;
  final int lineOnText;
  final Color? borderColor;
  final String maskString;
  final String? hintText;
  final bool isReadOnly;
  final TextInputAction textInputAction;
  final Function? onSubmitted;
  final FocusNode? focusNode;
  final int? maxlengthText;
  final List<TextInputFormatter>? textInputFormatter;
  final VoidCallback? prefixIconClick;

  const TxtGeneric(
      {this.label,
      this.isBorder = false,
      this.isDense = false,
      this.txtPaddingAll = const EdgeInsets.all(4),
      this.containerPadding = const EdgeInsets.all(0),
      this.txtRadiusBorder = 10.0,
      this.txtController,
      this.prefixIconF,
      this.prefixIconFZise = 20,
      this.suffixIconFZise = 20,
      this.suffixIconF,
      this.colorIcon = Colors.black,
      this.isFillColor = true,
      this.txtStream,
      this.onChangedStream,
      this.inputType = TextInputType.text,
      this.textInputAction = TextInputAction.go,
      this.isObscureText = false,
      this.txtonTap,
      this.onChangedText,
      this.lineOnText = 1,
      this.txtfocusNode,
      this.suffixWi,
      this.maskString = '',
      this.borderColor,
      this.hintText,
      this.onSubmitted,
      this.focusNode,
      this.textInputFormatter,
      this.prefixIconClick,
      this.maxlengthText = null,
      this.isReadOnly = false});

  @override
  _TxtGenericState createState() => _TxtGenericState();
}

class _TxtGenericState extends State<TxtGeneric> {
  bool _focus = false;
  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: widget.maskString.toString(), filter: {"#": RegExp(r'[0-9]')});
    return widget.txtStream != null
        ? StreamBuilder(
            stream: widget.txtStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Padding(
                  padding: widget.txtPaddingAll,
                  child: TextField(
                    maxLength: widget.maxlengthText,
                    // focusNode: widget.focusNode,
                    textInputAction: widget.textInputAction,
                    readOnly: widget.isReadOnly,
                    inputFormatters: widget.maskString.toString() != "" ? [maskFormatter] : widget.textInputFormatter,
                    maxLines: widget.lineOnText,
                    controller: widget.txtController,
                    keyboardType: widget.inputType,
                    decoration: _decoracion(isBoder: widget.isBorder, errorMessage: snapshot.error.toString(), isFillColor: _focus),
                    onChanged: (as) => widget.onChangedStream,
                    onTap: widget.txtonTap,
                    style: textos(ctn: context, fSize: 16, customcolor: color050855),
                    obscureText: widget.isObscureText ?? false,
                    onSubmitted: (as) => widget.onSubmitted,
                  )
                  // focusNode: widget.txtfocusNode),
                  );
            },
          )
        : Padding(
            padding: widget.txtPaddingAll,
            child: Focus(
              child: TextField(
                maxLength: widget.maxlengthText,
                // focusNode: widget.focusNode,
                readOnly: widget.isReadOnly,
                inputFormatters: widget.maskString.toString() != "" ? [maskFormatter] : widget.textInputFormatter,
                maxLines: widget.lineOnText,
                controller: widget.txtController!,
                keyboardType: widget.inputType,
                decoration: _decoracion(isBoder: widget.isBorder, isFillColor: _focus),
                obscureText: widget.isObscureText ?? false,
                textInputAction: widget.textInputAction,
                //bloc.changeEmail,
                style: textos(ctn: context, fSize: 16, customcolor: color050855),
                onTap: widget.txtonTap!,
                onChanged: (as) => widget.onChangedText,
                onSubmitted: (a) => widget.onSubmitted ?? () {},
              ),
            ),
          );
  }

  OutlineInputBorder _customBorder(bool isBorder, bool isFocus, Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: color050855,
          width: 2,
        ));
  }

  InputDecoration _decoracion({required bool isBoder, String? errorMessage, bool isFillColor = false}) {
    // print('${widget.txtController.text.isEmpty} ${!isFillColor}');
    //String _b;
    const streamEmpty = false;
    final focus = widget.txtStream != null ? (isFillColor && !streamEmpty) : (!isFillColor && widget.txtController!.text.isEmpty);

    //print(_b);

    return widget.isBorder
        ? InputDecoration(
            contentPadding: widget.containerPadding,
            // isDense: widget.isDense,
            filled: true,
            fillColor: Colors.white,
            border: _customBorder(isBoder, focus, colorCED4DA),
            enabledBorder: _customBorder(isBoder, focus, widget.borderColor ?? colorCED4DA),
            focusedBorder: _customBorder(isBoder, focus, widget.borderColor ?? colorCED4DA),
            focusColor: Colors.black,
            errorText: errorMessage ?? null,
            prefixIcon: widget.prefixIconF != null
                ? IconButton(
                    icon: Icon(
                      widget.prefixIconF,
                      size: widget.prefixIconFZise,
                      color: widget.colorIcon,
                    ),
                    onPressed: widget.prefixIconClick ?? () {},
                  )
                : null,
            suffixIcon: widget.suffixIconF != null
                ? IconButton(
                    icon: Icon(
                      widget.suffixIconF,
                      size: widget.suffixIconFZise,
                    ),
                    onPressed: widget.prefixIconClick ?? () {},
                    color: widget.colorIcon,
                  )
                : null,
            hintText: widget.hintText ?? widget.label,
            labelText: widget.label ?? null,
          )
        : InputDecoration(
            contentPadding: widget.containerPadding,
            isDense: widget.isDense,
            errorText: errorMessage,
            prefixIcon: widget.prefixIconF != null
                ? Icon(
                    widget.prefixIconF,
                    size: widget.prefixIconFZise,
                    color: widget.colorIcon,
                  )
                : null,
            suffixIcon: widget.suffixIconF != null
                ? Icon(
                    widget.suffixIconF,
                    size: widget.suffixIconFZise,
                    color: widget.colorIcon,
                  )
                : widget.suffixWi,
            focusColor: Colors.transparent,
            hintText: widget.hintText ?? widget.label,
            labelText: widget.label);
  }
}
