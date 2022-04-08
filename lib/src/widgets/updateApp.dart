import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:install_plugin_v2/install_plugin_v2.dart';
import 'package:openseasapp/src/helper/cresponsive.dart';
import 'package:openseasapp/src/helper/gobalHelpper.dart';
import 'package:permission_handler/permission_handler.dart';

class ActualizacionPage extends StatefulWidget {
  @override
  _ActualizacionPageState createState() => _ActualizacionPageState();
}

class _ActualizacionPageState extends State<ActualizacionPage> {
  double download = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onClickInstallApk("");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
            top: widthheight(ctn: context, fSize: 12), left: widthheight(ctn: context, fSize: 16), right: widthheight(ctn: context, fSize: 16), bottom: widthheight(ctn: context, fSize: 0)),
        backgroundColor: Colors.white, //Color.fromRGBO(255, 255, 255, 0.35),
        content: Container(
          height: widthheight(ctn: context, fSize: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Descargado ${download.toInt()}%',
                style: textos(ctn: context, fSize: 16),
              ),
              LinearProgressIndicator(
                value: download / 100,

                //semanticsLabel: 'Linear progress indicator',
              ),
            ],
          ),
        ));
  }

  void onClickInstallApk(String apkFilePath) async {
    try {
      Dio dio = Dio();

      String fileName = apkFilePath.substring(apkFilePath.lastIndexOf("/") + 1);
      final savePath = await GlobalHelpper().getFilePath(fileName);
      await dio.download(apkFilePath, savePath, onReceiveProgress: (rec, total) {
        //  setState(() {
        // print(rec);
        // downloading = true;
        // download = (rec / total) * 100;
        // downloadingStr =
        //   "Downloading Image : $rec" ;
        setState(() {
          download = (rec / total) * 100;
        });
      });

      if (apkFilePath.isEmpty) {
        //print('make sure the apk file is set');
        return;
      }

      var status = await Permission.storage.request();
      // Map<PermissionGroup, PermissionStatus> permissions =
      //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);

      // print(savePath);
      // print(status);
      if (status.isGranted) {
        final result = await InstallPlugin.installApk(savePath, 'com.itmsrd.openseasapp');
        print(result);

        //     .then((result) {
        //   print('install apk $result');
        // }).catchError((error) {
        //   print('install apk error: $error');
        // });
      } else {
        print('Permission request fail!');
        Navigator.pop(context);
      }
    } catch (e) {
      // print(e.toString());
      Navigator.pop(context);
    }
  }
}
