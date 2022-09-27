import 'package:feather_icons/feather_icons.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/bloc/internetAccessBloc.dart';

import 'package:openseasapp/src/constants/appimages.dart';
import 'package:openseasapp/src/constants/colors.dart';
// import 'package:openseasapp/src/helper/animation_fade_route.dart';
import 'package:openseasapp/src/helper/cresponsive.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:openseasapp/src/models/userListModel.dart';
import 'package:openseasapp/src/pages/selectOperationPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String? title;

  HomePage({Key? key, this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _router = FluroRouter();

  final _helpper = GlobalHelpper();

  @override
  Widget build(BuildContext context) {
    Provider.of<InternetAccessBloc>(context).temporizadorTurno();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(widthheight(ctn: context, fSize: 120)), // here the desired height
          child: AppBar(
            // : colorE5E5E5,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 34),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.openseasIco,
                    width: widthheight(ctn: context, fSize: 100),
                    // height: widthheight(ctn: context, fSize: 660, tipo: 2),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            backgroundColor: colorE5E5E5,
            centerTitle: true,
            elevation: 0.0,
          ),
        ),
        body: Container(
            color: colorE5E5E5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SELECT USER TO CONTINUE",
                      style: textos(ctn: context, customcolor: color050855, fontWeight: FontWeight.w700, fSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(child: SingleChildScrollView(child: Consumer<AppBloc>(builder: (_, appBloc, __) {
                      if (appBloc.userListModel.isEmpty) return const SizedBox();

                      return Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        // direction: Axis.horizontal,
                        runSpacing: 10,
                        spacing: 10,
                        children: appBloc.userListModel
                            .map((user) => Hero(
                                  tag: Key(user.userId.toString()),
                                  child: CardUser(
                                    img: AppImages.userIco,
                                    onTap: () async {
                                      UserModel.instance.interId = user.interId;
                                      UserModel.instance.userId = user.userId;
                                      UserModel.instance.userName = user.userName;
                                      UserModel.instance.userLangID = user.userLangID;

                                      if (user.keyRequered) {
                                        final _approve = await _helpper.userKeyValid(context);
                                        if (_approve) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SelectOperationPage()),
                                          );
                                        } else {
                                          // _helpper.showValidation(ctn: context, tipo: 0, titulo: "Access denied", msg: "User key is requered!");
                                          final _alerta2 = Alertas(
                                              titulo: UserModel.instance.userLangID == 'ENU' ? "Access denied" : "Acceso denegado",
                                              subtitulo: UserModel.instance.userLangID == 'ENU' ? "User key is requered!" : "Clave de usuario requerida!",
                                              ctn: context,
                                              tipo: _approve ? 2 : 3);
                                          _alerta2.showAlert();
                                          await Future.delayed(const Duration(seconds: 2));
                                          _alerta2.disspose();
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SelectOperationPage()),
                                        );
                                      }

                                      // Navigator.pushNamed(context, '/operation');
                                    },
                                    username: user.userName,
                                    roll: user.userRole,
                                  ),
                                ))
                            .toList(),
                      );
                    }))),
                  ],
                ),
              ),
            )));
  }
}

class CardUser extends StatelessWidget {
  final VoidCallback onTap;
  final String username;
  final String roll;
  final String img;

  const CardUser({Key? key, required this.onTap, required this.username, required this.img, required this.roll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widthheight(ctn: context, fSize: 148),
        height: widthheight(ctn: context, fSize: 150),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 38,
              backgroundColor: color050855,
              child: Icon(FeatherIcons.user, size: 40, color: Colors.white),
            ),
            SizedBox(
              height: widthheight(ctn: context, fSize: 10),
            ),
            Center(
              child: Text(
                username, // "User APP",
                style: textos(ctn: context, customcolor: color050855, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                roll, // "User APP",
                style: textos(ctn: context, customcolor: color000000_50, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
