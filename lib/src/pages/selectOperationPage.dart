import 'dart:io';
import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// import 'package:openseasapp/src/constants/appimages.dart';
// import 'package:openseasapp/src/constants/colors.dart';
import 'package:openseasapp/src/constants/constants.dart';
import 'package:openseasapp/src/helper/cresponsive.dart';
// import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:openseasapp/src/models/saveFormModel.dart';
import 'package:openseasapp/src/pages/newformPage.dart';
import 'package:openseasapp/src/pages/printerPage.dart';
import 'package:openseasapp/src/pages/scanformulario.dart';
import 'package:openseasapp/src/provider/appProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:dio/dio.dart';

import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class SelectOperationPage extends StatelessWidget {
  final String title;

  SelectOperationPage({Key? key, this.title = 'Chouse you action'}) : super(key: key);
  final _appProvider = AppProvider();

  @override
  Widget build(BuildContext context) {
    initPlatformState();
    return Scaffold(
      backgroundColor: colorE5E5E5,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(widthheight(ctn: context, fSize: 80)), // here the desired height
        child: AppBar(
          // foregroundColor: colore83435,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 34),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.openseasIco,
                  width: widthheight(ctn: context, fSize: 60),
                  // height: widthheight(ctn: context, fSize: 660, tipo: 2),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          backgroundColor: colorE5E5E5,
          centerTitle: true,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
      ),
      body: Container(
        color: colorE5E5E5,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: widthheight(ctn: context, fSize: 34),
                ),
                btnAcciones(
                    context: context,
                    iconData: FeatherIcons.fileText,
                    label: "Shipping Form",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewFormPage()),
                      );
                    }),
                SizedBox(
                  height: widthheight(ctn: context, fSize: 6),
                ),
                btnAcciones(
                    context: context,
                    iconData: FeatherIcons.truck,
                    label: "Delivery",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScanOrderPage()),
                      );
                    }),
                SizedBox(
                  height: widthheight(ctn: context, fSize: 6),
                ),
                //  btnAcciones(context: context, iconData: FeatherIcons.truck, label: "Printer", onClick: () async => printTest())
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector btnAcciones({required BuildContext context, required String label, required IconData iconData, required VoidCallback onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: widthheight(ctn: context, fSize: 94),
        decoration: const BoxDecoration(
          color: colorFCFCFC,
          // border: Border(top: BorderSide(), bottom: BorderSide()),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              spreadRadius: 8,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              spreadRadius: 8,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.s,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color050855,
                child: Icon(iconData, size: widthheight(ctn: context, fSize: 22), color: Colors.white),
              ),
              SizedBox(
                width: widthheight(ctn: context, fSize: 24),
              ),
              Text(
                label, // "User APP",
                style: textos(ctn: context, customcolor: color050855, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int porcentbatery = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // platformVersion = await PrintBluetoothThermal.platformVersion;
      // porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
  }
}
