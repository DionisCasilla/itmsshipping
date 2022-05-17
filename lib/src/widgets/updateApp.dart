import 'package:flutter/material.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/constants/colors.dart';
import 'package:openseasapp/src/helper/cresponsive.dart';
import 'package:provider/provider.dart';
import 'package:r_upgrade/r_upgrade.dart';

class ActualizacionPage extends StatefulWidget {
  @override
  _ActualizacionPageState createState() => _ActualizacionPageState();
}

class _ActualizacionPageState extends State<ActualizacionPage> {
  double download = 0.0;
  int? id;
  bool? isAutoRequestInstall = false;

  // UpgradeMethod? upgradeMethod;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RUpgrade.setDebug(false);
    onClickInstallApk(Provider.of<AppBloc>(context, listen: false).appLogin.config!.urldonwload);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
            top: widthheight(ctn: context, fSize: 12), left: widthheight(ctn: context, fSize: 16), right: widthheight(ctn: context, fSize: 16), bottom: widthheight(ctn: context, fSize: 0)),
        backgroundColor: Colors.white, //Color.fromRGBO(255, 255, 255, 0.35),
        content: StreamBuilder(
            stream: RUpgrade.stream,
            builder: (_, AsyncSnapshot<DownloadInfo> snapshot) {
              return SizedBox(
                  height: widthheight(ctn: context, fSize: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Descargado ${snapshot.data == null ? 0 : snapshot.data!.percent}%',
                        style: textos(ctn: context, fSize: 16, customcolor: color050855),
                      ),
                      LinearProgressIndicator(
                        value: snapshot.data == null ? 0 : snapshot.data!.percent! / 100,

                        //semanticsLabel: 'Linear progress indicator',
                      ),
                    ],
                  ));
            }));
  }

  void onClickInstallApk(String apkFilePath) async {
    try {
      String fileName = apkFilePath.substring(apkFilePath.lastIndexOf("/") + 1);
      final donw = await RUpgrade.upgrade(apkFilePath,
          fileName: fileName, isAutoRequestInstall: true, notificationStyle: NotificationStyle.none, useDownloadManager: true, upgradeFlavor: RUpgradeFlavor.hotUpgrade);

      print(donw);
      // upgradeMethod = UpgradeMethod.all;
      // Dio dio = Dio();

      // String fileName = apkFilePath.substring(apkFilePath.lastIndexOf("/") + 1);
      // final savePath = await GlobalHelpper().getFilePath(fileName);
      // await dio.download(apkFilePath, savePath, onReceiveProgress: (rec, total) {
      //   //  setState(() {
      //   // print(rec);
      //   // downloading = true;
      //   // download = (rec / total) * 100;
      //   // downloadingStr =
      //   //   "Downloading Image : $rec" ;
      //   setState(() {
      //     download = (rec / total) * 100;
      //   });
      // });

      // if (apkFilePath.isEmpty) {
      //   //print('make sure the apk file is set');
      //   return;
      // }

      // var status = await Permission.storage.request();
      // // Map<PermissionGroup, PermissionStatus> permissions =
      // //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);

      // print(savePath);
      // print(status);
      // if (status.isGranted) {
      //   // final result = await InstallPlugin.installApk(savePath, 'com.itmsrd.openseasapp');
      //   // print(result);

      //   InstallPlugin.installApk(savePath, 'com.itmsrd.openseasapp').then((result) {
      //     print('install apk $result');
      //   }).catchError((error) {
      //     print('install apk error: $error');
      //   });
      // } else {
      //   print('Permission request fail!');
      //   Navigator.pop(context);
      // }
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }
}
