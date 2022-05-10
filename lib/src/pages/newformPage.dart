import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:openseasapp/src/models/formsavemode.dart';
import 'package:openseasapp/src/models/newformModel.dart';
import 'package:openseasapp/src/provider/appProvider.dart';
import 'package:openseasapp/src/widgets/btnIpoteca.dart';
import 'package:openseasapp/src/widgets/customStepper/my_StepProgress.dart';
import 'package:openseasapp/src/widgets/customStepper/stepper_Model.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../constants/appImages.dart';
import '../constants/colors.dart';
import '../helper/cresponsive.dart';

class NewFormPage extends StatefulWidget {
  const NewFormPage({Key? key}) : super(key: key);

  @override
  State<NewFormPage> createState() => _NewFormPageState();
}

class _NewFormPageState extends State<NewFormPage> {
  int _curStep = 0;
  List<StepperModel> _steps = [];
  PageController _pageController = PageController();
  List<ResultData> _listItems = [];
  List<GroupFomularioModel> _frm1 = [];
  List<Formulario> _frm2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listItems = Provider.of<AppBloc>(context, listen: false).newform;

    _steps = _listItems.map((form) {
      List<Formulario> _frm2 = [];

      form.information
          .map((e) => _frm2.add(Formulario(
                information: e,
                id: e.id!,
                type: e.type!,
                requered: e.requered,
              )))
          .toList();
      _frm1.add(GroupFomularioModel(id: form.id, formularios: _frm2));
      return StepperModel(
          titulo: form.description,
          contenido: SingleChildScrollView(
              child: Column(
            children: [
              Column(
                children: _frm2,
              ),
              BtnIpotecca(
                label: form.code == "4" ? "Send Form" : "Next",
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
            pageController2: _pageController,
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
    final formCurrent = _frm1[_curStep];

    print(formCurrent.id);
    List<String> cERROR = [];

    formCurrent.formularios.forEach((campos) {
      if (campos.requered) {
        //  if (campos.information.description!.isNotEmpty ) loaninfo.informationValue = campos.information.description;
        String valor = "${campos.textEditingController.text}${campos.selectData}";
        if (valor.isEmpty) cERROR.add(campos.information.description.toString() + " is requered");
      }
    });

    if (cERROR.isNotEmpty) {
      final _alerta = Alertas(ctn: context, titulo: "Error", subtitulo: cERROR.join("\n"), barrierDismissible: false, tipo: 3);
      _alerta.showAlert();
      await Future.delayed(Duration(seconds: 3));
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

    _pageController.animateToPage(_curStep, duration: const Duration(milliseconds: 400), curve: Curves.linearToEaseOut);

    // return _curStep;
  }

  Future<void> _saveform() async {
    final _alerta = Alertas(titulo: "Saving Form", ctn: context);
    _alerta.showAlert();
    Map datos = {};

    for (var formGrupo in _frm1) {
      formGrupo.formularios.forEach((element) {
        String valor = "${element.textEditingController.text}${element.selectData}";
        datos.addAll(NewFomrToSave(key: element.id, value: valor).toJson());
      });
    }

    // print(datos);

    //var json = jsonEncode(datos);
    // print(json);
    final _response = await AppProvider().saveNewForm(datos: datos);

    _alerta.disspose();

    final _alerta2 = Alertas(titulo: _response.message, ctn: context, tipo: _response.success ? 2 : 3);
    _alerta2.showAlert();

    await Future.delayed(const Duration(seconds: 3));
    if (_response.success) {
      GlobalHelpper().printReciver(tipo: 1, datos2: _response.result);
      Navigator.pop(context);
    }

    _alerta2.disspose();
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
  InformationModel information;
  final textEditingController = TextEditingController();
  final signatureController = SignatureController();

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
        selectData: (String a) {
          print(a);
          selectData = a;
        });
  }
}

class GroupFomularioModel {
  final String id;
  final List<Formulario> formularios;

  GroupFomularioModel({required this.id, required this.formularios});
}
