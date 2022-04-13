import 'dart:io';
import 'dart:typed_data';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:openseasapp/src/constants/appimages.dart';
import 'package:openseasapp/src/constants/colors.dart';
import 'package:openseasapp/src/helper/cresponsive.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:openseasapp/src/models/userListModel.dart';
import 'package:openseasapp/src/provider/appProvider.dart';
import 'package:openseasapp/src/widgets/btnIpoteca.dart';
import 'package:openseasapp/src/widgets/txtG.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../models/reciberForm.Model.dart';

class ScanOrderPage extends StatefulWidget {
  final String title;

  const ScanOrderPage({Key? key, this.title = 'Chouse you action'}) : super(key: key);

  @override
  State<ScanOrderPage> createState() => _ScanOrderPageState();
}

class _ScanOrderPageState extends State<ScanOrderPage> {
  String scanBarcode = 'Unknown';
  final _barcodeController = TextEditingController();
  final _appProvider = AppProvider();
  bool _mostrar = false;
  List<FormDataResult> _formularios = [];

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    // onDrawStart: () => print('onDrawStart called!'),
    // onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: widthheight(ctn: context, fSize: 34),
            ),
            TxtG(
              controller: _barcodeController,
              label: "Scan Form Number",
              hintText: "Scan Form Number",
              prefixIconF: FeatherIcons.camera,
              prefixIconClick: () async => await scanQR(tipo: 0),
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.go,
              onSubmitted: (String e) async => await scanQR(tipo: 1),

              // isObscureText: true,
            ),
            SizedBox(
              height: widthheight(ctn: context, fSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(left: widthheight(ctn: context, fSize: 24)),
              child: Visibility(
                  visible: _mostrar,
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: _formularios.map((e) => formulario(form: e)).toList())),
            )
          ],
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

  Future<void> scanQR({int tipo = 0}) async {
    String barcodeScanRes = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    if (tipo == 0) {
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#FF3BC1D3", "Cancel", true, ScanMode.BARCODE);

        if (barcodeScanRes == "-1") return;
        // print(barcodeScanRes);

      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }
      scanBarcode = barcodeScanRes;
      _barcodeController.text = scanBarcode;
    } else {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    _formularios.clear();
    //  setState(() {

    findForm(formId: _barcodeController.text, type: tipo.toString());
    // });
  }

  findForm({
    String type = "",
    String formId = "",
  }) async {
    final _alerta = Alertas(titulo: "Searching..", ctn: context);
    _alerta.showAlert();
    final _data = await _appProvider.findFom(formId: formId, type: type);
    if (_data.isNotEmpty) {
      _mostrar = true;
      _formularios = _data;
    } else {
      _mostrar = false;
    }
    setState(() {});
//    print(_data);

    _alerta.disspose();
  }

  Widget formulario({required FormDataResult form}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        txtGeneric(texto: "Sender: ", texto2: "${form.senderName}"),
        txtGeneric(texto: "Reciever: ", texto2: " ${form.recieverName}"),
        txtGeneric(texto: "Reciever Address: ", texto2: " ${form.recieverAddress}"),
        txtGeneric(texto: "Reciever City: ", texto2: " ${form.recieverCity}"),
        txtGeneric(texto: "Reciever Phone: ", texto2: " ${form.recieverPhone}"),
        txtGeneric(texto: "Package Type: ", texto2: " ${form.packageType}"),
        txtGeneric(texto: "Package Content: ", texto2: " ${form.packageContent}"),
        txtGeneric(texto: "Amount: ", texto2: " ${form.currencyId}${form.invoiceValue}"),
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Signature(
              controller: _controller,
              height: widthheight(ctn: context, fSize: 180),
              backgroundColor: Colors.white70,
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.undo),
              color: color050855,
              onPressed: () {
                setState(() => _controller.undo());
              },
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              color: color050855,
              onPressed: () {
                setState(() => _controller.redo());
              },
            ),
            //CLEAR CANVAS
            IconButton(
              icon: const Icon(Icons.clear),
              color: Colors.red,
              onPressed: () {
                setState(() => _controller.clear());
              },
            ),
            Expanded(
              child: ElevatedButton(
                autofocus: false,
                style: ElevatedButton.styleFrom(
                  animationDuration: Duration(seconds: 1),
                  onPrimary: Colors.green,
                  primary: Colors.green,
                  // minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(80))),
                ),
                onPressed: () async {
                  final _alerta = Alertas(titulo: "Saving", ctn: context);
                  _alerta.showAlert();
                  final Uint8List? data = await _controller.toPngBytes();
                  final tempDir = await getTemporaryDirectory();
                  File file = await File('${tempDir.path}/$scanBarcode.jpeg').create();
                  file.writeAsBytesSync(data!);

                  final _url = await _appProvider.uploadImage(image: file, guid: form.formId);
                  final _infoPost = {"FormID": form.formId, "UserID": UserModel.instance.userId, "SignName": form.recieverName, "SignUrl": _url};
                  final resp = await _appProvider.saveForm(infoPost: _infoPost);
                  //print(resp);
                  if (resp.success) {
                    GlobalHelpper().printReciver(datos: resp.result);
                  }

                  _alerta.disspose();

                  final _alerta2 = Alertas(titulo: resp.message, ctn: context, tipo: resp.success ? 2 : 3);
                  _alerta2.showAlert();
                  await Future.delayed(const Duration(seconds: 3));
                  _alerta2.disspose();
                  setState(() {
                    _mostrar = false;
                    scanBarcode = "";
                    _barcodeController.text = "";
                    _controller.clear();
                  });
                },
                child: Text("Send Form", style: textos(ctn: context, fontWeight: FontWeight.w700, fontFamily: "Poppins", customcolor: Colors.white)),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        )
      ],
    );
  }

  Padding txtGeneric({required String texto, required String texto2}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            texto,
            style: textos(ctn: context, fSize: 16, fontWeight: FontWeight.w500, fontFamily: "Poppins", customcolor: colore83435),
          ),
          Container(
            width: widthheight(ctn: context, fSize: 200),
            child: Text(
              texto2,
              style: textos(ctn: context, fSize: 16, fontWeight: FontWeight.w500, fontFamily: "Poppins", customcolor: color050855),
            ),
          ),
        ],
      ),
    );
  }
}

/*

    
*/
