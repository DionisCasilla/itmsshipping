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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    //print("bluetooth enabled: $result");
//     if (true) {
//       //    _msj = "Bluetooth enabled, please search and connect";
//       print("Bluetooth enabled, please search and connect");
//     } else {
// //_msj = "Bluetooth not enabled";
//       print("Bluetooth not enabled");
//     }

    // setState(() {
    // //  _info = platformVersion + " ($porcentbatery% battery)";
    // });
  }

  // Future<void> printTest() async {
  //   var dio = Dio();
  //   // final response = await dio.download();
  //   final bool result = await PrintBluetoothThermal.bluetoothEnabled;
  //   int conecctionStatus2 = await PrintBluetoothThermal.batteryLevel;
  //   bool conecctionStatus = await PrintBluetoothThermal.connectionStatus;
  //   // final _infoPost = {"FormID": form.formId, "UserID": UserModel.instance.userId, "SignName": form.recieverName, "SignUrl": _url};
  //   final _infoPost = {
  //     "FormID": "91AB8A05-C867-4E64-AB98-AD2C8D3EA517",
  //     "UserID": "0003",
  //     "SignName": "JUAN ARELIS RODRIGUEZ",
  //     "SignUrl": "https://res.cloudinary.com/dfbwtygxk/image/upload/v1648179601/itms/shipping/firmas/hfjq6zzkwta8ot2mxdsz.png"
  //   };
  //   final resp = await _appProvider.saveForm(infoPost: _infoPost);
  //   if (resp.success) {
  //     if (conecctionStatus) {
  //       //  final ticket = await _generatePdf(datos: resp.result); // _printer(datos: resp.result);
  //       // print(ticket);

  //       // final a = await File(ticket.path).readAsBytesSync();
  //       // await printTest();
  //       const PaperSize paper = PaperSize.mm58;
  //       final profile = await CapabilityProfile.load();
  //       // await PrintBluetoothThermal.writeBytes(await demoReceipt(paper, profile));
  //       final result = await PrintBluetoothThermal.writeBytes(await demoReceipt(paper: paper, profile: profile, datos: resp.result));
  //       // print("print result: $result");
  //     } else {
  //       //no connected
  //     }
  //   }
  // }

  // Future<List<int>> _printer({SaveFormModel? datos, String? file}) async {
  //   final profile = await CapabilityProfile.getAvailableProfiles();
  //   final profile2 = await CapabilityProfile.load();
  //   // print(profile);
  //   final generator = Generator(PaperSize.mm58, profile2);
  //   List<int> bytes = [];

  //   // Print image:
  //   final ByteData data = await rootBundle.load(file!);
  //   final Uint8List imgBytes = data.buffer.asUint8List();
  //   final image = Imag.decodeImage(imgBytes);
  //   bytes += generator.image(image!);
  //   // Print image using an alternative (obsolette) command
  //   final _img = Image.asset(AppImages.openseasIco).image;
  //   // bytes += generator.imageRaster();

  //   // bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  //   // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ', styles: PosStyles(codeTable: 'CP1252'));
  //   // bytes += generator.text(
  //   //   'Special 2: blåbærgrød',
  //   //   styles: PosStyles(codeTable: 'CP1252'),
  //   // );

  //   // bytes += generator.text(datos.empresa!.interTexto.toString(),
  //   //     styles: const PosStyles(
  //   //       bold: true,
  //   //       height: PosTextSize.size2,
  //   //     ));
  //   // bytes += generator.text(datos.empresa!.interDireccion.toString(), styles: const PosStyles(bold: true, height: PosTextSize.size2, align: PosAlign.center));
  //   // bytes += generator.text(datos.empresa!.interTelefono.toString(),
  //   //     styles: const PosStyles(
  //   //       bold: true,
  //   //       height: PosTextSize.size2,
  //   //     ));
  //   // bytes += generator.text(datos.empresa!.interEmail.toString(),
  //   //     styles: const PosStyles(
  //   //       bold: true,
  //   //       height: PosTextSize.size2,
  //   //     ));
  //   // bytes += generator.feed(1);
  //   // bytes += generator.text("PROOF OF DELIVERY", styles: const PosStyles(bold: true, height: PosTextSize.size2, align: PosAlign.center));
  //   // bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true));
  //   // bytes += generator.text('Underlined text', styles: const PosStyles(underline: true, width: Po), linesAfter: 1);
  //   // bytes += generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
  //   // bytes += generator.text('Align center', styles: const PosStyles(align: PosAlign.center));
  //   // bytes += generator.text('Align right', styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

  //   // bytes += generator.row([
  //   //   PosColumn(
  //   //     text: 'col3',
  //   //     width: 3,
  //   //     styles: PosStyles(align: PosAlign.center, underline: true),
  //   //   ),
  //   //   PosColumn(
  //   //     text: 'col6',
  //   //     width: 6,
  //   //     styles: PosStyles(align: PosAlign.center, underline: true),
  //   //   ),
  //   //   PosColumn(
  //   //     text: 'col3',
  //   //     width: 3,
  //   //     styles: PosStyles(align: PosAlign.center, underline: true),
  //   //   ),
  //   // ]);

  //   // bytes += generator.text('Text size 200%',
  //   //     styles: const PosStyles(
  //   //       height: PosTextSize.size1,
  //   //       width: PosTextSize.size1,
  //   //     ));

  //   // // Print barcode
  //   // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
  //   // bytes += generator.barcode(Barcode.upcA(barData));

  //   // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
  //   // ticket.text(
  //   //   'hello ! 中文字 # world @ éphémère &',
  //   //   styles: PosStyles(codeTable: PosCodeTable.westEur),
  //   //   containsChinese: true,
  //   // );

  //   bytes += generator.feed(2);
  //   bytes += generator.cut();

  //   return bytes;
  // }

  // Future<File> _generatePdf({required SaveFormModel datos}) async {
  //   final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  //   final font = await PdfGoogleFonts.nunitoExtraLight();
  //   late PdfImage _logoImage;
  //   Uint8List logobytes;
  //   ByteData _bytes = await rootBundle.load(AppImages.openseasIco);
  //   logobytes = _bytes.buffer.asUint8List();

  //   // final ByteData data = await rootBundle.load(AppImages.openseasIco);
  //   // final img = pw.MemoryImage(
  //   //   (await rootBundle.load(AppImages.openseasIco)).buffer.asUint8List(),
  //   // );
  //   _logoImage = PdfImage.file(
  //     pdf.document,
  //     bytes: logobytes,
  //   );

  //   pdf.addPage(
  //     pw.Page(
  //       // pageFormat: format,
  //       build: (context) {
  //         return pw.Column(
  //           children: [
  //             pw.Flexible(child: pw.Image(pw.RawImage(bytes: logobytes, width: 100, height: 100))),
  //             // pw.Flexible(child:  pw.Image(pw.ImageImage(img)),),
  //             pw.SizedBox(
  //               width: double.infinity,
  //               child: pw.FittedBox(
  //                 child: pw.Text(datos.empresa!.interDireccion.toString(), style: pw.TextStyle(font: font)),
  //               ),
  //             ),
  //             pw.SizedBox(height: 20),
  //             //  pw.Flexible(child: pw.FlutterLogo())
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //   final output = await getTemporaryDirectory();
  //   final file = File("${output.path}/${datos.ordenInfo!.paqueteId.toString()}.pdf");
  //   // final file = File("example.pdf");
  //   return file.writeAsBytes(await pdf.save());
  // }
}
