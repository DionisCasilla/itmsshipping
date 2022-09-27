import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';

import 'package:openseasapp/src/models/newformModel.dart';
import 'package:openseasapp/src/models/userListModel.dart';
import 'package:openseasapp/src/preferencias/usuarioPrefes.dart';
import 'package:openseasapp/src/provider/appProvider.dart';
import 'package:openseasapp/src/widgets/btnIpoteca.dart';
import 'package:openseasapp/src/widgets/customStepper/my_StepProgress.dart';
import 'package:openseasapp/src/widgets/customStepper/stepper_Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../constants/appImages.dart';
import '../constants/colors.dart';
import '../helper/cresponsive.dart';
import 'package:uuid/uuid.dart';

class NewFormPage extends StatefulWidget {
  const NewFormPage({Key? key}) : super(key: key);

  @override
  State<NewFormPage> createState() => _NewFormPageState();
}

class _NewFormPageState extends State<NewFormPage> {
  int _curStep = 0;
  List<StepperModel> _steps = [];
  PageController pageController = PageController();
  List<ResultData> _listItems = [];
  List<GroupFomularioModel> frm1 = [];
  List<Formulario> frm2 = [];
  final _prefe = PreferenciasUsuario();
  String _guidNew = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var uuid = const Uuid();
    _guidNew = uuid.v4();
    _listItems = Provider.of<AppBloc>(context, listen: false).newform;

    _steps = _listItems.map((form) {
      List<Formulario> _frm2 = [];

      form.information.removeWhere((element) => element.enabled == false);

      form.information
          .map((e) => _frm2.add(Formulario(
                information: e,
                id: e.id!,
                type: e.type!,
                requered: e.requered,
              )))
          .toList();
      frm1.add(GroupFomularioModel(id: form.id, formularios: _frm2));
      return StepperModel(
          titulo: form.description,
          contenido: SingleChildScrollView(
              child: Column(
            children: [
              Column(
                children: _frm2,
              ),
              BtnIpotecca(
                label: form.code == "04" ? "Send Form" : "Next",
                onPressed: _clickSiguiente,
                tipoBtn: 1,
                borderR: true,
              )
            ],
          )));
    }).toList();
  }

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
      body: Container(
        color: colorE5E5E5,
        child: SizedBox(
          child: MyStepProgress(
            onStepCancel: () {
              // print("sdsd");
            },
            onStepContinue: () => _clickSiguiente,
            steppers: _steps,
            width: MediaQuery.of(context).size.width,
            curStep: _curStep,
            activeColor: colore83435, // Colors.yellow,
            lineWidth: 6,
            pageController2: pageController,
            //  _curStep
            setCurrent: (int i) {
              setState(() {
                _curStep = i;
              });
            },
          ),
        ),
      ),
    );
  }

  _clickSiguiente() async {
    // Vibrate.feedback(FeedbackType.impact);
    final formCurrent = frm1[_curStep];

    // print(formCurrent.id);
    List<String> cERROR = [];

    for (var campos in formCurrent.formularios) {
      if (campos.requered) {
        //  if (campos.information.description!.isNotEmpty ) loaninfo.informationValue = campos.information.description;
        if (campos.type == "Signature") {
          // print(campos.signatureController.value.length);
          if (campos.signatureController.value.isEmpty) cERROR.add(campos.information.description.toString() + " is requered");
        } else {
          String valor = "${campos.textEditingController.text}${campos.selectData}";
          if (valor.isEmpty) cERROR.add(campos.information.description.toString() + " is requered");
        }
      }
    }

    if (cERROR.isNotEmpty) {
      final _alerta = Alertas(ctn: context, titulo: "Error", subtitulo: cERROR.join("\n"), barrierDismissible: false, tipo: 3);
      _alerta.showAlert();
      await Future.delayed(const Duration(seconds: 3));
      _alerta.disspose();
      return;
    }

    if (_curStep < _steps.length - 1) {
      setState(() {
        _curStep += 1;
      });
    } else {
      await _saveform();
    }

    pageController.animateToPage(_curStep, duration: const Duration(milliseconds: 400), curve: Curves.linearToEaseOut);

    // return _curStep;
  }

  Future<void> _saveform() async {
    try {
      final _alerta = Alertas(titulo: "Saving Form", ctn: context);
      _alerta.showAlert();
      Map datos = {};
      Uint8List? data;

      for (var formGrupo in frm1) {
        for (var element in formGrupo.formularios) {
          if (element.type == "Signature") {
            var uuid = const Uuid();
            final _guid = uuid.v4();
            data = await element.signatureController.toPngBytes();
            final tempDir = await getTemporaryDirectory();
            File file = await File('${tempDir.path}/$_guid.jpeg').create();
            file.writeAsBytesSync(data!);

            final _url = await AppProvider().uploadImage(image: file, guid: _guid);
            String valor = _url.result;
            datos.addAll(NewFomrToSave(key: element.id, value: valor).toJson());
          } else {
            String valor = "${element.textEditingController.text}${element.selectData}";
            datos.addAll(NewFomrToSave(key: element.id, value: valor).toJson());
          }
        }
      }
      final _response = await AppProvider().saveNewForm(datos: datos).timeout(const Duration(seconds: 30));

      _alerta.disspose();
      String _msg = "";

      //log(jsonEncode(_response));
      if (_response.success == false) {
        if (_response.errorModel != null && (_response.errorModel!.tipo! > 1)) {
          _msg = UserModel.instance.userLangID == "ENU" ? "Uops!, An unexpected error occurred" : "Uops!, Ocurrio un error inesperado";
        }

        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(_msg),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(UserModel.instance.userLangID == "ENU" ? "Send later" : 'Enviar mas tarde'),
                  onPressed: () async {
                    final _alertaImpresion = Alertas(titulo: "Printting", ctn: context);
                    _alertaImpresion.showAlert();
                    datos["shippingform-04-09"] = data;
                    datos["guid"] = _guidNew;
                    // print(datos);
                    List<String> _OrdenesPendiente = _prefe.listaEnviosPendiente ?? [];

                    _OrdenesPendiente.removeWhere((orden) => orden.contains(_guidNew));
                    bool conecctionStatus = await PrintBluetoothThermal.connectionStatus;

                    if (conecctionStatus) {
                      const PaperSize paper = PaperSize.mm80;
                      final profile = await CapabilityProfile.load();

                      //  for (var item in _OrdenesPendiente) {
                      //final _datos = jsonDecode(item);
                      await PrintBluetoothThermal.writeBytes(await GlobalHelpper().tmpreceiptNewForm(paper: paper, profile: profile, datos: datos));
                      // await Future.delayed(const Duration(seconds: 3));
                      // }
                      _prefe.setlistaEnviosPendiente = [];
                      _alertaImpresion.disspose();
                      // _alertaImpresion.disspose();
                      setState(() {});
                    }

                    _OrdenesPendiente.add(json.encode(datos).toString());
                    _prefe.setlistaEnviosPendiente = _OrdenesPendiente;

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(),
                TextButton(
                  child: Text(UserModel.instance.userLangID == "ENU" ? "Try again" : 'Volver a intentar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      await Future.delayed(const Duration(seconds: 3));
      if (_response.success) {
        await GlobalHelpper().printReciver(tipo: 1, datos2: _response.result);
        Navigator.pop(context);
      }
    } on TimeoutException catch (_) {
      // A timeout occurred.
    } on SocketException catch (_) {}
  }
}

class NewFomrToSave {
  final String key;
  final String value;

  NewFomrToSave({required this.key, required this.value});

  @override
  Map toJson() {
    return {key.toString(): value.toString()};
  }
}

class Formulario extends StatelessWidget {
  final InformationModel information;
  final textEditingController = TextEditingController();
  final signatureController = SignatureController(penStrokeWidth: 2, penColor: Colors.black, exportBackgroundColor: Colors.white);

  String selectData = "";
  String id = "";
  String type = "";
  bool requered = false;

  // TextEditingController textEditingController;

  Formulario({Key? key, required this.information, required this.type, required this.id, required this.requered}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //  print(information);

    return GlobalHelpper().generarField(
        ctn: context,
        elemento: information,
        textEditingController: textEditingController,
        signatureController: signatureController,
        selectData: (String a) {
          // print(a);
          selectData = a;
        });
  }
}

class GroupFomularioModel {
  final String id;
  final List<Formulario> formularios;

  GroupFomularioModel({required this.id, required this.formularios});
}
