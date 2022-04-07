import 'package:flutter/material.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:openseasapp/src/models/newformModel.dart';
import 'package:openseasapp/src/widgets/btnIpoteca.dart';
import 'package:openseasapp/src/widgets/customStepper/my_StepProgress.dart';
import 'package:openseasapp/src/widgets/customStepper/stepper_Model.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listItems = Provider.of<AppBloc>(context, listen: false).newform;
    _steps = _listItems
        .map((form) => StepperModel(
            titulo: form.description,
            contenido: SingleChildScrollView(
                child: Column(
              children: [
                Column(children: form.information.map((e) => GlobalHelpper().generarField(ctn: context, elemento: e)).toList()),
                BtnIpotecca(
                  label: "Next",
                  onPressed: _clickSiguiente,
                  tipoBtn: 1,
                  borderR: true,
                )
              ],
            ))))
        .toList();
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
      body: SizedBox(
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
    );
  }

  // List<StepperModel> mySteps() {
  //   final _listItems = Provider.of<AppBloc>(context, listen: false).newform;
  //   _steps = _listItems.map((form) => StepperModel(titulo: form.description, contenido: Container())).toList();

  //   return _steps;
  // }

  _clickSiguiente() {
    // Vibrate.feedback(FeedbackType.impact);
_steps[_curStep].contenido

    setState(() {
      if (_curStep < _steps.length - 1) {
        _curStep += 1;
      } else {
        _curStep = 0;
        // Navigator.pushReplacement(
        //     context,
        //     FadeRoute(
        //         page: HomePage(
        //       selectMenu: "Citas",
        //       selectMenuId: 4,
        //     )));
      }

      _pageController.animateToPage(_curStep, duration: const Duration(milliseconds: 400), curve: Curves.linearToEaseOut);
    });
    // return _curStep;
  }
}
