import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/bloc/internetAccessBloc.dart';

// import 'package:openseasapp/src/constants/appimages.dart';
// import 'package:openseasapp/src/constants/colors.dart';
import 'package:openseasapp/src/constants/constants.dart';
import 'package:openseasapp/src/helper/cresponsive.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';
// import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:openseasapp/src/models/saveFormModel.dart';
import 'package:openseasapp/src/models/userListModel.dart';
import 'package:openseasapp/src/pages/newformPage.dart';

import 'package:openseasapp/src/pages/scanformulario.dart';
import 'package:openseasapp/src/preferencias/usuarioPrefes.dart';
import 'package:openseasapp/src/provider/appProvider.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:provider/provider.dart';
import 'package:image/image.dart' as Imag;
import 'package:path_provider/path_provider.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:provider/provider.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SelectOperationPage extends StatefulWidget {
  final String title;

  SelectOperationPage({Key? key, this.title = 'Chouse you action'}) : super(key: key);

  @override
  State<SelectOperationPage> createState() => _SelectOperationPageState();
}

class _SelectOperationPageState extends State<SelectOperationPage> {
  final _appProvider = AppProvider();

  final _fn = GlobalHelpper();

  final _prefe = PreferenciasUsuario();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _OrdenesPendiente = _prefe.listaEnviosPendiente ?? [];

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
                    label: UserModel.instance.userLangID == "ENU" ? "Shipping Form" : "Registrar Paquete",
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
                    label: UserModel.instance.userLangID == "ENU" ? "Delivery" : "Control de entregas",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScanOrderPage()),
                      );
                    }),
                SizedBox(
                  height: widthheight(ctn: context, fSize: 6),
                ),
                kDebugMode
                    ? btnAcciones(
                        context: context,
                        iconData: FeatherIcons.truck,
                        label: "Printer",
                        onClick: () async {
                          await connect();
                          bool conecctionStatus = await PrintBluetoothThermal.connectionStatus;

                          if (conecctionStatus) {
                            const PaperSize paper = PaperSize.mm58;
                            final profile = await CapabilityProfile.load();
                            PrintBluetoothThermal.writeBytes(await demoReceipt(paper: paper, profile: profile));
                          }
                        })
                    : const SizedBox(),
                SizedBox(
                  height: widthheight(ctn: context, fSize: 6),
                ),
                Consumer<InternetAccessBloc>(
                  builder: (_, internet, __) {
                    if ((internet.isConnected == true) && _OrdenesPendiente.isNotEmpty) {
                      return btnAcciones(
                          context: context,
                          iconData: FeatherIcons.send,
                          label: "Pending to send (${_OrdenesPendiente.length})",
                          onClick: () async {
                            final _alertaImpresion = Alertas(titulo: "Sending", ctn: context);
                            try {
                              await connect();

                              _alertaImpresion.showAlert();
                              bool conecctionStatus = await PrintBluetoothThermal.connectionStatus;

                              if (conecctionStatus) {
                                const PaperSize paper = PaperSize.mm80;
                                final profile = await CapabilityProfile.load();

                                for (var item in _OrdenesPendiente) {
                                  final _datos = jsonDecode(item);
                                  final _response = await AppProvider().saveNewForm(datos: _datos).timeout(const Duration(seconds: 30));
                                  if (_response.success == true) {
                                    await _fn.printReciver(tipo: 1, datos2: _response.result);
                                    await Future.delayed(const Duration(seconds: 3));
                                    _prefe.listaEnviosPendiente.removeWhere((element) => element.contains(item));
                                  } else {
                                    _alertaImpresion.disspose();
                                    final _msg = UserModel.instance.userLangID == "ENU" ? "Uops!, An unexpected error occurred" : "Uops!, Ocurrio un error inesperado";
                                    final _alertaImpresionError = Alertas(titulo: _msg, ctn: context, tipo: 3);
                                    await Future.delayed(const Duration(seconds: 3));
                                    _alertaImpresionError.disspose();
                                    return;
                                  }
                                  // await _fn.printReciver(tipo: 1, datos2: _response.result);
                                  // await Future.delayed(const Duration(seconds: 3));
                                }
                                // _prefe.setlistaEnviosPendiente = [];
                                _alertaImpresion.disspose();
                                setState(() {});
                              }
                            } catch (e) {
                              _alertaImpresion.disspose();
                            }
                          });
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: widthheight(ctn: context, fSize: 6),
                ),
                Text(Provider.of<AppBloc>(context, listen: false).appLogin!.currentAppVersion ?? "")
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

  Future<List<int>> demoReceipt({
    required PaperSize paper,
    required CapabilityProfile profile,
  }) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    // Print image
    final ByteData data = await rootBundle.load(AppImages.openseasIco);
    final Uint8List imgBytes = data.buffer.asUint8List();
    final image = Imag.decodeImage(imgBytes);
    // final imagefirma = Imag.decodeImage(imgBytes);
    bytes += ticket.image(image!);

    // Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse(datos.ordenInfo!.paqueteEntregadoFirma.toString())).load(datos.ordenInfo!.paqueteEntregadoFirma.toString())).buffer.asUint8List();
    // final imagefirma = Imag.decodeImage(bytes2);

    // Print QR Code from image
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 200;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());
    final _im = await qrimg(qrData: "asas");

    bytes += ticket.image(_im!);
    bytes += ticket.hr();
    bytes += ticket.feed(2);

    // } catch (e) {
    //   print(e);
    // }

    // bytes += ticket.feed(2);
    // bytes += ticket.cut();
    return bytes;
  }

  Future<void> connect() async {
    // setState(() {
    //   _connceting = true;
    // });
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;

    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: listResult[0].macAdress);
  }

  Future<Imag.Image?> qrimg({required String qrData}) async {
    // String qrData = "google.com";
    const double qrSize = 200;
    // try {
    final uiImg = await QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: false,
    ).toImageData(qrSize);
    final dir = await getTemporaryDirectory();
    final pathName = '${dir.path}/qr_tmp.png';
    final qrFile = File(pathName);
    final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());

    return Imag.decodeImage(imgFile.readAsBytesSync());
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }
}
