// ignore_for_file: unnecessary_this

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openseasapp/src/widgets/customStepper/stepper_Model.dart';

import '../../constants/colors.dart';
import '../../helper/cresponsive.dart';

class MyStepProgress extends StatefulWidget {
  MyStepProgress(
      {Key? key,
      required int curStep,
      required VoidCallback onStepContinue,
      required VoidCallback onStepCancel,
      required List<StepperModel> steppers,
      required double width,
      required Color activeColor,
      required PageController pageController2,
      required Function setCurrent,
      //  ControlsWidgetBuilder controlsBuilder,
      double lineWidth = 4.0})
      : _steppers = steppers,
        _curStep = curStep,
        _width = width,
        _activeColor = activeColor,
        _lineWidth = lineWidth,
        fnsetCurrent = setCurrent,
        _pageController2 = pageController2,
        super(key: key);

  final double _width;
  final List<StepperModel> _steppers;
  int _curStep;
  Function fnsetCurrent;
  final PageController _pageController2;
  // final VoidCallback _onStepContinue(int);
  // final VoidCallback _onStepCancel;

  final Color _activeColor;
  final double _lineWidth;

  @override
  _MyStepProgressState createState() => _MyStepProgressState();
}

class _MyStepProgressState extends State<MyStepProgress> {
  final Color _inactiveColor = Colors.white;

  final Color _inactiveColorLine = colorCED4DA;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: this.widget._width,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.only(
                    top: widthheight(ctn: context, fSize: 40),
                    left: widget._curStep > 0 ? 0.0 : widthheight(ctn: context, fSize: 50),
                    right: widthheight(ctn: context, fSize: 24.0),
                  ),
                  height: widthheight(ctn: context, fSize: 90),
                  color: color050855,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _views(),
                  )),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Positioned(
              top: widthheight(ctn: context, fSize: 0),
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: widthheight(ctn: context, fSize: 40.0), right: widthheight(ctn: context, fSize: 24.0), top: 0),
                height: widthheight(ctn: context, fSize: 30),
                color: color050855,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment,
                  children: _titleViews(),
                ),
              ),
            ),

            // Positioned(
            //   top: widthheight(ctn: context, fSize: 80),
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //       padding: EdgeInsets.only(
            //         //top: 20,
            //         left: widthheight(ctn: context, fSize: 10),
            //         right: widthheight(ctn: context, fSize: 10),
            //       ),
            //       width: double.infinity,
            //       height: MediaQuery.of(context).size.height * 0.06,
            //       color: color050855,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: _subtitleViews(),
            //       )),
            // ),

            Padding(
              padding: EdgeInsets.only(top: widthheight(ctn: context, fSize: 140, tipo: 2)),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      // margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      child: SizedBox(width: double.infinity, child: _pageviewContaiter()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  List<Widget> _views() {
    var list = <Widget>[];
    widget._steppers.asMap().forEach((i, step) {
      // print("Step: ${widget._curStep}");
      //colors according to state
      var circleColor = (widget._curStep > i)
          ? colorCED4DA
          : (widget._curStep == i)
              ? widget._activeColor
              : (widget._curStep > i)
                  ? _inactiveColor
                  : _inactiveColorLine;
      var circleColorlleno = (widget._curStep == i)
          ? colorCED4DA
          : (widget._curStep > i)
              ? color050855
              : _inactiveColorLine;

      var lineColor = widget._curStep > i ? colorCED4DA : _inactiveColorLine;
      // var lineColor2 = _curStep > i + 1 ? _activeColor : _inactiveColorLine;

      // var iconColor = (i == 0 || _curStep > i) ? _activeColor : _inactiveColorLine;

      //line between icons
      if (i == 0) {
        if (widget._curStep > 0) {
          list.add(Align(
              alignment: Alignment.topCenter,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (widget._curStep > 0) {
                      //  Vibrate.feedback(FeedbackType.impact);
                      final step = widget._curStep - 1;
                      widget._curStep = step;
                      widget.fnsetCurrent(step);
                      widget._pageController2.animateToPage(step, duration: const Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
                    }
                    setState(() {});
                  })
              //height: widget._lineWidth,
              // color: Colors.red,
              ));
        }
      }

      list.add(
        //dot with icon view
        AnimatedContainer(
          // curve: Curves.easeInCirc,
          duration: const Duration(milliseconds: 500),
          width: widthheight(ctn: context, fSize: 30),
          height: widthheight(ctn: context, fSize: 30),
          padding: EdgeInsets.zero,
          // margin: EdgeInsets.zero,
          // child: Icon(
          //   step.iconData,
          //   color: iconColor,
          //   size: 15.0,
          // ),
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: circleColorlleno,
              width: widthheight(ctn: context, fSize: 1),
            ),
          ),
          child: Center(
            child: widget._curStep == i || widget._curStep < i
                ? Text(
                    "${i + 1}",
                    style: widget._curStep == i
                        ? textos(ctn: context, fSize: 16, customcolor: Colors.white, fontWeight: FontWeight.w500, fontFamily: "Roboto")
                        : textos(ctn: context, fSize: 16, customcolor: color050855, fontWeight: FontWeight.w500, fontFamily: "Roboto"),
                  )
                : const Icon(Icons.check),
          ),
        ),
      );

      //line between icons
      if (i != widget._steppers.length - 1) {
        list.add(Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            // width: loginWidth,
            height: widget._lineWidth,
            color: lineColor,
            curve: Curves.linearToEaseOut,
          ),
          //    Container(
          // height: widget._lineWidth,
          // color: lineColor,
          // )
        ));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    widget._steppers.asMap().forEach((i, step) {
      if (widget._curStep == i) {
        list.add(Text(step.titulo, style: textos(ctn: context, fSize: 16, customcolor: colore83435, fontWeight: FontWeight.w500))); //stepTitulo));
      } else {
        list.add(Container());
      }
    });
    return list;
  }

  List<Widget> _subtitleViews() {
    List<Widget> list = [];
    widget._steppers.asMap().forEach((i, step) {
      if (widget._curStep == i) {
        if (step.subtitulo == null) return;
        list.add(Text(step.subtitulo!,
            style: textos(
              ctn: context,
              fSize: 16,
            )));
      }
    });
    return list;
  }

  Widget _pageviewContaiter() {
    return PageView.builder(
        //   allowImplicitScrolling: false,
        // pageSnapping: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: widget._pageController2,
        itemCount: widget._steppers.length,
        itemBuilder: (context, int index) {
          return widget._steppers[index].contenido;
        }
        //children: list,
        );
  }

  // onStepContinue() {
  //   setState(() {

  //   });
  // }

  @override
  void dispose() {
    // TO_DO: implement dispose

    super.dispose();
    // widget._pageController2.dispose();
  }
}
