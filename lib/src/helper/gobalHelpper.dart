import 'dart:io';
import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:openseasapp/src/bloc/appBloc.dart';
import 'package:openseasapp/src/helper/cresponsive.dart';
import 'package:openseasapp/src/models/formsavemode.dart';
import 'package:openseasapp/src/models/saveFormModel.dart';
import 'package:openseasapp/src/models/userListModel.dart';
import 'package:openseasapp/src/provider/appProvider.dart';
import 'package:openseasapp/src/widgets/ddlIpotecca.dart';
import 'package:openseasapp/src/widgets/loading_alert_dialog.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:path_provider/path_provider.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:signature/signature.dart';

import '../constants/appImages.dart';
import '../constants/colors.dart';
import '../widgets/txtG.dart';
import 'package:image/image.dart' as Imag;

class GlobalHelpper {
  String _mindatetime = '${DateTime.now().year - 100}-01-01';

  String _maxdatetime = '${DateTime.now().year + 16}-12-31';
  String _initdate = DateTime.now().toString();
  // String fORMATDATE = 'dd/MM/yyyy';

  DateTimePickerLocale _locale = DateTimePickerLocale.es;

  Future<bool> get isInDebugMode async {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  String convetirFechaSistema(String fecha) {
    if (fecha == null) {
      throw ArgumentError.notNull('string');
    }

    if (fecha.isEmpty) {
      return fecha;
    }
    // print(fecha);
    final sp = fecha.split("/");

    final formatoFecha = "${sp[2].toString()}-${sp[1].toString()}-${sp[0].toString()}";

    return formatoFecha;
  }

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError.notNull('string');
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  String cedulaFormat(String string) {
    String _string = "";
    if (string == null) {
      throw ArgumentError.notNull('string');
    }

    if (string.isEmpty) {
      return string;
    }

    if (string.length == 13 && string.contains("-")) {
      _string = string;
    }

    if (string.length == 11) {
      _string = string.substring(0, 2) + "-" + string.substring(3, 10) + "-" + string.substring(string.length, -1);
    }

    return _string;
  }

  Future<void> seleccionFecha({required BuildContext context, TextEditingController? txtController, int tipo = 0, String fORMATDATE = "dd/MM/yyyy"}) async {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('Listo', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)),
        cancel: const Text('Cancelar', style: TextStyle(fontSize: 18, color: Colors.red)),
      ),
      minDateTime: tipo == 0 ? DateTime.parse(_mindatetime) : DateTime.parse(_mindatetime),
      maxDateTime: tipo == 0 ? DateTime.parse(_maxdatetime) : DateTime.parse(_initdate),
      initialDateTime: txtController!.text == "" ? DateTime.parse(_initdate) : DateTime.parse(this.convetirFechaSistema(txtController.text)),
      dateFormat: fORMATDATE,
      locale: _locale,
      onConfirm: (DateTime dateTime, List<int> i) {
        txtController.text = DateFormat(fORMATDATE).format(dateTime).toString();
      },
    );
  }

  Future<void> showValidation({required BuildContext ctn, String titulo = "Alerta", String msg = "", GlobalKey<ScaffoldState>? globalKey, int tipo = 0}) async {
    dynamic scaffold;
    if (tipo == 0) {
      scaffold = Scaffold.of(ctn);
    } else {
      scaffold = globalKey!.currentState;
    }
    Future.delayed(
        Duration.zero,
        () => scaffold.showSnackBar(SnackBar(
              content: SingleChildScrollView(
                child: Container(
                  //color: Color565050,
                  //height: widthHeight(ctn: ctn, fSize: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(titulo, style: textos(ctn: ctn, customcolor: Colors.white, fSize: 24)),
                      Divider(
                        height: widthheight(ctn: ctn, fSize: 25),
                        color: Colors.white,
                      ),
                      Text(msg,
                          style: textos(
                            ctn: ctn,
                            fSize: 16.0,
                            fontWeight: FontWeight.w400,
                            customcolor: Colors.white,
                            fontFamily: 'Inter',
                          )),
                    ],
                  ),
                ),
              ),
              // backgroundColor: color202832,
            )));
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  int daysBetween({required DateTime from, required DateTime to}) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory? dir = await getExternalStorageDirectory();

    path = '${dir!.path}/$uniqueFileName';

    // print(path);

    return path;
  }

  Widget generarField(
      {required BuildContext ctn,
      required dynamic elemento,
      TextEditingController? textEditingController,
      Function? selectData,
      GroupController? controller,
      SignatureController? signatureController}) {
    Widget _elementos = const SizedBox();

    switch (elemento.type) {
      case "STRING":
        _elementos = TxtG(
          controller: textEditingController ?? TextEditingController(),
          id: elemento.id,
          label: elemento.description,
          // onChangedText: (String s) => elemento.selectData(s),
        );

        break;
      case "NUMBER":
        _elementos = TxtG(
          id: elemento.id,
          label: elemento.description,
          textInputType: TextInputType.number,
          controller: textEditingController,
          // onChangedText: (String s) => elemento.selectData(s),
        );

        break;
      case "DECIMAL":
        _elementos = TxtG(
          id: elemento.id,
          label: elemento.description,
          textInputType: TextInputType.number,
          controller: textEditingController,
          // onChangedText: (String s) => elemento.selectData(s),
        );

        break;
      case "TEXT":
        _elementos = TxtG(
          id: elemento.id,
          lineOnText: 3,
          label: elemento.description,
          // textInputType: TextInputType.number,
          controller: textEditingController,
          // onChangedText: (String s) => elemento.selectData(s),
        );

        break;
      case "CHECKBOXLIST":
        // GroupController controller = GroupController();
        List<DDLIpItems> _elementosLista = [];

        final _valores = elemento.values.split("|");

        _valores.map((list) {
          _elementosLista.add(DDLIpItems(id: list, descripcion: list, select: false));
        }).toList();

        _elementos = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              elemento.description,
              style: textos(ctn: ctn, fSize: 16, fontWeight: FontWeight.w500, fontFamily: "Poppins", customcolor: color050855),
            ),
            SimpleGroupedChips<String>(
              controller: controller ?? GroupController(isMultipleSelection: true),
              values: _valores,
              itemTitle: _valores,
              onItemSelected: (a) {
                //  print(a);
                final _a = a as List<String>;

                selectData!(_a.join("|"));
              },
              chipGroupStyle: ChipGroupStyle.minimize(
                backgroundColorItem: Colors.red.shade600,
                selectedColorItem: color050855.withOpacity(0.6),
                itemTitleStyle: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.w900, fontFamily: "Poppins", customcolor: color050855),
              ),
            ),
          ],
        );
        // onChangedText: (String s) => elemento.selectData(s),

        break;
      case "DATE":
        final _tipo = elemento.values == "0" ? 0 : 1;
        _elementos = InkWell(
          onTap: () async {
            await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: _tipo);
            FocusScope.of(ctn).requestFocus(FocusNode());
          },
          child: TxtG(
            txtonTap: () async {
              await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: _tipo);
              FocusScope.of(ctn).requestFocus(FocusNode());
            },
            id: elemento.id,
            lineOnText: 1,
            label: elemento.description,
            isReadOnly: true,
            // textInputType: TextInputType.number,
            controller: textEditingController,
            // onChangedText: (String s) => elemento.selectData(s),
          ),
        );
        break;
      case "YEAR":
        _elementos = InkWell(
          onTap: () async {
            await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: 1, fORMATDATE: "yyyy");
            FocusScope.of(ctn).requestFocus(FocusNode());
          },
          child: TxtG(
            id: elemento.id,
            lineOnText: 1,
            label: elemento.description,
            isReadOnly: true,
            // textInputType: TextInputType.number,
            controller: textEditingController,
            txtonTap: () async {
              await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: 1, fORMATDATE: "yyyy");
              FocusScope.of(ctn).requestFocus(FocusNode());
            },
            // onChangedText: (String s) => elemento.selectData(s),
          ),
        );
        break;
      case "TIME":
        _elementos = InkWell(
          onTap: () async {
            await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: 1, fORMATDATE: "hh:mm");
            FocusScope.of(ctn).requestFocus(FocusNode());
          },
          child: TxtG(
            id: elemento.id,
            lineOnText: 1,
            label: elemento.description,
            isReadOnly: true,
            // textInputType: TextInputType.number,
            controller: textEditingController,
            txtonTap: () async {
              await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: 1, fORMATDATE: "hh:mm");
              FocusScope.of(ctn).requestFocus(FocusNode());
            },
            // onChangedText: (String s) => elemento.selectData(s),
          ),
        );
        break;
      case "DATETIME":
        _elementos = InkWell(
          onTap: () async {
            await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: 1, fORMATDATE: "dd/MM/yyy hh:mm");
            FocusScope.of(ctn).requestFocus(FocusNode());
          },
          child: TxtG(
            id: elemento.id,
            lineOnText: 1,
            label: elemento.description,
            isReadOnly: true,
            // textInputType: TextInputType.number,
            controller: textEditingController,
            txtonTap: () async {
              await GlobalHelpper().seleccionFecha(context: ctn, txtController: textEditingController, tipo: 1, fORMATDATE: "dd/MM/yyy hh:mm");
              FocusScope.of(ctn).requestFocus(FocusNode());
            },
            // onChangedText: (String s) => elemento.selectData(s),
          ),
        );
        break;
      case "LIST":
        List<DDLIpItems> _elementosLista = [];

        final _valores = elemento.values.split("|");

        _valores.map((list) {
          _elementosLista.add(DDLIpItems(id: list, descripcion: list));
        }).toList();

        _elementos = DDLIp(
            id: elemento.id,
            label: elemento.description,
            itemsList: _elementosLista,
            itemSelect: (a) {
              final dataselect = a as DDLIpItems;
              // print(dataselect.descripcion);
              selectData!(dataselect.descripcion);
            }

            //  (item) async {
            //   print(item!);

            //   selectData!(item.descripcion);

            // }
            );

        break;
      case "LIST 2":
        List<DDLIpItems> _elementosLista = [];

        final _valores = elemento.information;

        _valores.map((list) {
          _elementosLista.add(DDLIpItems(id: list["id"].toString(), descripcion: list["description"]));
        }).toList();

        _elementos = DDLIp(
            id: elemento.id,
            label: elemento.description,
            itemsList: _elementosLista,
            itemSelect: (a) {
              final dataselect = a as DDLIpItems;
              // print(dataselect.descripcion);
              selectData!(dataselect.id);
            }

            //  (item) async {
            //   print(item!);

            //   selectData!(item.descripcion);

            // }
            );

        break;
      case "LISTMULTISELECT":
        List<String> _elementosLista = [];
        List<String> _selectLista = [];

        final _valores = elemento.values.split("|");

        _valores.map((items) {
          _elementosLista.add(items);
        }).toList();

        _elementos = MultipleSearchSelection(
          items: _elementosLista, // List<String>
          // initialPickedItems: List<DDLIpItems> [],
          fuzzySearch: FuzzySearch.jaro,
          padding: const EdgeInsets.all(20),
          title: Text(
            elemento.description,
            style: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.w900, fontFamily: "Poppins", customcolor: color050855),
          ),
          titlePadding: const EdgeInsets.symmetric(vertical: 10),
          searchItemTextContentPadding: const EdgeInsets.symmetric(horizontal: 10),
          maximumShowItemsHeight: 200,
          hintText: 'Type here to search',
          hintTextStyle: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.w900, fontFamily: "Poppins", customcolor: color050855),
          selectAllTextStyle: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.w900, fontFamily: "Poppins", customcolor: color050855),
          selectAllBackgroundColor: Colors.white,
          selectAllOnHoverBackgroundColor: Colors.blue[300],
          selectAllOnHoverTextColor: Colors.white,
          selectAllOnHoverFontWeight: FontWeight.bold,
          // clearAllTextStyle: kStyleDefault.copyWith(
          //   color: Colors.red,
          // ),
          clearAllOnHoverFontWeight: FontWeight.bold,
          clearAllOnHoverBackgroundColor: Colors.white,
          pickedItemTextStyle: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.bold, fontFamily: "Poppins", customcolor: color050855),
          pickedItemBackgroundColor: Colors.red[300]!.withOpacity(0.5),
          pickedItemBorderRadius: 6,
          pickedItemFontWeight: FontWeight.bold,
          pickedItemTextColor: color050855,
          showedItemTextStyle: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.w900, fontFamily: "Poppins", customcolor: color050855),
          showedItemsBackgroundColor: Colors.grey.withOpacity(0.1),
          showShowedItemsScrollbar: false,
          searchItemTextStyle: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.w900, fontFamily: "Poppins", customcolor: color050855),
          noResultsWidget: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'No items found',
              style: textos(ctn: ctn, fSize: 14, fontWeight: FontWeight.w900, fontFamily: "Poppins", customcolor: color050855),
            ),
          ),
          onTapShowedItem: () {},

          onPickedChange: (items) {},
          onItemAdded: (item) {
            _selectLista.add(item);
            //print(_selectLista);
            selectData!(_selectLista.join("|"));
            //    selectData!(_selectLista);
          },
          onItemRemoved: (item) {
            _selectLista.remove(item);
            selectData!(_selectLista.join("|"));
            //  selectData!(_selectLista);
            //  print('$item removed from picked items');
          },
        );

        break;
      case "Signature":
        final _sig = SignatureController();
        _elementos = Padding(
          padding: EdgeInsets.only(right: widthheight(ctn: ctn, fSize: 40), left: widthheight(ctn: ctn, fSize: 40)),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Text(
              elemento.description,
              style: textos(ctn: ctn, fSize: 16, fontWeight: FontWeight.w500, fontFamily: "Poppins", customcolor: color050855),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Signature(
                controller: signatureController!,
                height: widthheight(ctn: ctn, fSize: 180),
                width: widthheight(ctn: ctn, fSize: 300),
                backgroundColor: Colors.white70,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.undo),
                  color: color050855,
                  onPressed: () {
                    signatureController.undo();
                    // setState(() => signatureController.undo());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.redo),
                  color: color050855,
                  onPressed: () {
                    // setState(() => signatureController.redo());
                    signatureController.redo();
                  },
                ),
                //CLEAR CANVAS
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.red,
                  onPressed: () {
                    signatureController.clear();
                  },
                ),
              ],
            )
          ]),
        );
        break;

      default:
    }
    return _elementos;
  }

  Future<bool> updateAPP(
    BuildContext context,
  ) async {
    // final _prefe=PreferenciasUsuario();

    Dialog dialogWithImage = Dialog(
        backgroundColor: Colors.black54,
        insetPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: CupertinoActionSheet(
          title: Column(
            children: [
              Text(
                "Update Requered",
                style: textos(ctn: context, fSize: 20, customcolor: Colors.black),
              ),
              SizedBox(
                height: widthheight(ctn: context, fSize: 5),
              ),
              // Text(
              //    ResultVersionesProveedoresApp.instance.mensaje??"Hemos aplicado mejoras al producto, favor actualizar tu UNIBE App y disfruta lo nuevo que te trae.",
              //     style: textos(
              //       ctn: context,
              //       fSize: 16,
              //       color: Colors.black26
              //     ))
            ],
          ),
          actions: <Widget>[
            // CupertinoActionSheetAction(
            //   child: Text('Cambiar foto'),
            //   onPressed: () {/** */},
            // ),
            CupertinoActionSheetAction(
              child: Text(
                'Actualizar ahora',
                style: textos(
                  ctn: context,
                  fSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, true);
                if (Platform.isIOS) {
                  //  launchURL(destino: UtilsModel.instance.urlIos);
                } else if (Platform.isAndroid) {
                  // onClickInstallApk(
                  //     "https://codikasensorsstorage.blob.core.windows.net/apkproveedores/app-debug.apk");
                  // launchURL(destino: "");
                }
              },
            ),
            // CupertinoActionSheetAction(
            //   child: Text(
            //     'Posponer',
            //     style: textos(
            //       ctn: context,
            //       fSize: 16,
            //     ),
            //   ),
            //   onPressed: () => Navigator.pop(context,false),
            // ),
          ],
        ));
    return await showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => dialogWithImage);
  }

  Future<bool> userKeyValid(
    BuildContext context,
  ) async {
    TextEditingController _controller = TextEditingController();
    bool approve = false;
    final _appProvider = AppProvider();
    // final _prefe=PreferenciasUsuario();

    Dialog dialogWithImage = Dialog(
        backgroundColor: Colors.black54,
        insetPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: CupertinoActionSheet(
          title: Column(
            children: [
              Text(
                UserModel.instance.userLangID == "ENU" ? "User Key" : "Clave",
                style: textos(ctn: context, fSize: 20, customcolor: Colors.black),
              ),
              SizedBox(
                height: widthheight(ctn: context, fSize: 5),
              ),
            ],
          ),
          actions: <Widget>[
            TxtG(
              controller: _controller,
              isObscureText: true,
              cheight: 120,
              prefixIconF: FeatherIcons.logIn,
              prefixIconClick: () async => await () {},
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.go,
              onSubmitted: (String e) async => await () {},
            ),

            // is
            CupertinoActionSheetAction(
              child: Text(
                UserModel.instance.userLangID == "ENU" ? 'Done!' : "OK",
                style: textos(ctn: context, fSize: 16, customcolor: Colors.green, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                final _alerta = Alertas(titulo: UserModel.instance.userLangID == "ENU" ? 'Loading' : "Cargando", ctn: context);
                _alerta.showAlert();
                final respuesta = await _appProvider.userkeyValidate(userkey: _controller.text);
                if (respuesta.success) {
                  await Provider.of<AppBloc>(context, listen: false).getFormPending();
                  await Provider.of<AppBloc>(context, listen: false).formLoad(language: UserModel.instance.userLangID);
                }
                _alerta.disspose();
                Navigator.pop(context, respuesta.success);
                // print(respuesta);
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                UserModel.instance.userLangID == "ENU" ? 'Close' : "Cerrar",
                style: textos(
                  ctn: context,
                  fSize: 16,
                ),
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ));
    approve = await showDialog(barrierDismissible: true, context: context, builder: (BuildContext context) => dialogWithImage) ?? false;

    return approve;
  }

  Future<bool> errorOpenAPP(
    BuildContext context,
  ) async {
    TextEditingController _controller = TextEditingController();
    bool approve = false;
    // final _appProvider = AppProvider();
    // final _prefe=PreferenciasUsuario();

    Dialog dialogWithImage = Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SizedBox(
            // height: widthheight(ctn: context, fSize: ),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text(
              "Error try to open the App",
              style: textos(ctn: context, fSize: 16, customcolor: color050855),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please try later",
              style: textos(ctn: context, fSize: 16, customcolor: color050855),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        )));
    approve = await showDialog(barrierDismissible: true, context: context, builder: (BuildContext context) => Center(child: SingleChildScrollView(child: dialogWithImage))) ?? true;

    return approve;
  }

  Future<void> connect() async {
    // setState(() {
    //   _connceting = true;
    // });
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;

    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: listResult[0].macAdress);
  }

  Future<List<int>> receiptSaveForm({required PaperSize paper, required CapabilityProfile profile, required SaveFormModel datos}) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];
    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);

    // Print image
    final ByteData data = await rootBundle.load(AppImages.openseasIco);
    final Uint8List imgBytes = data.buffer.asUint8List();
    final image = Imag.decodeImage(imgBytes);

    bytes += ticket.image(image!);

    Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse(datos.ordenInfo!.paqueteEntregadoFirma.toString())).load(datos.ordenInfo!.paqueteEntregadoFirma.toString())).buffer.asUint8List();
    final imagefirma = Imag.decodeImage(bytes2);

    bytes += ticket.text(datos.empresa!.interDireccion, styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text(datos.empresa!.interTelefono, styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text(datos.empresa!.interEmail, styles: const PosStyles(align: PosAlign.center));

    bytes += ticket.hr(len: 30);
    bytes += ticket.text('PROOF OF DELIVERY', styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.hr(len: 30);

    bytes += ticket.row([
      PosColumn(text: "VOUCHER NO.", width: 5),
      PosColumn(text: datos.ordenInfo!.trackPaqueteId.toString(), width: 7, styles: const PosStyles(bold: true)),
    ]);
    bytes += ticket.row([
      PosColumn(text: "DATE", width: 5),
      PosColumn(text: datos.ordenInfo!.paqueteEntregadoFecha.toString(), width: 7),
    ]);
    bytes += ticket.text("SENDER NAME:", styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.text(datos.ordenInfo!.paqueteSenderNombre.toString(), styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.text("RECIEVER NAME:", styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.text(datos.ordenInfo!.paqueteRecieverNombre.toString(), styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.text(datos.ordenInfo!.paqueteContenido.toString(), styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.hr(len: 30);
    bytes += ticket.image(imagefirma!);
    bytes += ticket.hr(ch: '=', len: 30);
    bytes += ticket.text('Thank you!', styles: const PosStyles(align: PosAlign.center, bold: true, width: PosTextSize.size4));
    bytes += ticket.text(timestamp, styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.cut();

    return bytes;
  }

  Future<List<int>> receiptNewForm({required PaperSize paper, required CapabilityProfile profile, required SaveFormModel2 datos}) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];
    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);

    // Print image
    final ByteData data = await rootBundle.load(AppImages.openseasIco);
    final Uint8List imgBytes = data.buffer.asUint8List();
    final image = Imag.decodeImage(imgBytes);
    Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse(datos.ordenInfo!.paqueteEntregadoFirma.toString())).load(datos.ordenInfo!.paqueteFirmado.toString())).buffer.asUint8List();
    final imagefirma = Imag.decodeImage(bytes2);

    final _imgQR = await qrimg(qrData: datos.ordenInfo!.paqueteId.toString());
    // final imagefirma = Imag.decodeImage(imgBytes);

    bytes += ticket.image(image!);
    bytes += ticket.text(datos.ordenInfo!.paqueteCiudadTexto, styles: const PosStyles(align: PosAlign.center, bold: true));
    bytes += ticket.text(datos.empresa!.interDireccion, styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.text(datos.empresa!.interTelefono, styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.text(datos.empresa!.interEmail, styles: const PosStyles(align: PosAlign.left));

    // bytes += ticket.hr();
    // bytes += ticket.text('PROOF OF DELIVERY', styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.hr(len: 30);
    bytes += ticket.row([
      PosColumn(text: "VOUCHER NO:", width: 5),
      PosColumn(text: datos.ordenInfo!.paqueteId.toString(), width: 7, styles: const PosStyles(bold: true)),
    ]);
    bytes += ticket.row([
      PosColumn(text: "DATE:", width: 5),
      PosColumn(text: datos.ordenInfo!.paqueteContenidoFecha1.toString(), width: 7),
    ]);
    bytes += ticket.row([
      PosColumn(text: "SENDER NAME:", width: 6),
      PosColumn(text: datos.ordenInfo!.paqueteSenderNombre.toString(), width: 6),
    ]);
    bytes += ticket.row([
      PosColumn(text: "RECIEVER NAME:", width: 6),
      PosColumn(text: datos.ordenInfo!.paqueteRecieverNombre.toString(), width: 6),
    ]);
    bytes += ticket.row([
      PosColumn(text: "CONTENT:", width: 5),
      PosColumn(text: "${datos.ordenInfo!.paqueteContenidoPaquetes.toString()} ${datos.ordenInfo!.paqueteContenidoTipo.toString()}", width: 7),
    ]);
    // b
    // bytes += ticket.text("SENDER NAME:", styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text(datos.ordenInfo!.paqueteSenderNombre.toString(), styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text("RECIEVER NAME:", styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text(datos.ordenInfo!.paqueteRecieverNombre.toString(), styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text("CONTENT:", styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text("${datos.ordenInfo!.paqueteContenidoPaquetes.toString()} ${datos.ordenInfo!.paqueteContenidoTipo.toString()}", styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.hr(len: 30);
    bytes += ticket.image(imagefirma!);
    bytes += ticket.hr(ch: '_', len: 30);
    bytes += ticket.text(datos.ordenInfo!.paqueteId.toString(), styles: const PosStyles(align: PosAlign.center));

    bytes += ticket.feed(1);
    bytes += ticket.hr(len: 30);
    bytes += ticket.text(datos.empresa!.empresaName.toString(), styles: const PosStyles(align: PosAlign.center, bold: true));
    bytes += ticket.image(_imgQR!);
    bytes += ticket.text(datos.ordenInfo!.paqueteId.toString(), styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.text(datos.ordenInfo!.paqueteNumero.toString(), styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.hr(ch: '=', len: 30);
    bytes += ticket.feed(2);
    bytes += ticket.cut();
    return bytes;
  }

  Future<List<int>> tmpreceiptNewForm({required PaperSize paper, required CapabilityProfile profile, required Map datos}) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];
    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);

    // Print image
    final ByteData data = await rootBundle.load(AppImages.openseasIco);
    final Uint8List imgBytes = data.buffer.asUint8List();
    final image = Imag.decodeImage(imgBytes);
    // Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse(datos.ordenInfo!.paqueteEntregadoFirma.toString())).load(datos.ordenInfo!.paqueteFirmado.toString())).buffer.asUint8List();
    final imagefirma = Imag.decodeImage(datos["shippingform-04-09"]);
    // final _guid = uuid.v4();
    // data = await element.signatureController.toPngBytes();
    // final tempDir = await getTemporaryDirectory();
    // File file = await File('${tempDir.path}/$_guid.jpeg').create();
    // // file.writeAsBytesSync(data!);

    // final _url = await AppProvider().uploadImage(image: file, guid: _guid);

    final _imgQR = await qrimg(qrData: datos["guid"] ?? datos["shippingform-01-06"]);
    // final imagefirma = Imag.decodeImage(imgBytes);

    bytes += ticket.image(image!);
    bytes += ticket.text("Voucher Temporal", styles: const PosStyles(align: PosAlign.center, bold: true));
    // bytes += ticket.text(datos.empresa!.interDireccion, styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text(datos.empresa!.interTelefono, styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text(datos.empresa!.interEmail, styles: const PosStyles(align: PosAlign.left));

    // bytes += ticket.hr();
    // bytes += ticket.text('PROOF OF DELIVERY', styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.hr(len: 30);
    bytes += ticket.row([
      PosColumn(text: "VOUCHER:", width: 2),
      PosColumn(text: datos["guid"] ?? datos["shippingform-01-06"], width: 10, styles: const PosStyles(bold: true)),
    ]);
    bytes += ticket.row([
      PosColumn(text: "DATE:", width: 3),
      PosColumn(text: DateTime.now().toString(), width: 9),
    ]);
    bytes += ticket.row([
      PosColumn(text: "SENDER:", width: 3),
      PosColumn(text: datos["shippingform-01-02"], width: 9),
    ]);
    bytes += ticket.row([
      PosColumn(text: "RECIEVER:", width: 3),
      PosColumn(text: datos["shippingform-02-02"], width: 9),
    ]);
    bytes += ticket.row([
      PosColumn(text: "CONTENT:", width: 3),
      PosColumn(text: "${datos["shippingform-03-01"]}", width: 9),
    ]);
    // b
    // bytes += ticket.text("SENDER NAME:", styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text(datos.ordenInfo!.paqueteSenderNombre.toString(), styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text("RECIEVER NAME:", styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text(datos.ordenInfo!.paqueteRecieverNombre.toString(), styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text("CONTENT:", styles: const PosStyles(align: PosAlign.left));
    // bytes += ticket.text("${datos.ordenInfo!.paqueteContenidoPaquetes.toString()} ${datos.ordenInfo!.paqueteContenidoTipo.toString()}", styles: const PosStyles(align: PosAlign.left));
    bytes += ticket.hr(len: 30);
    bytes += ticket.image(imagefirma!);
    bytes += ticket.hr(ch: '_', len: 30);
    bytes += ticket.text(datos["guid"] ?? datos["shippingform-01-06"], styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text('Thank you!', styles: const PosStyles(align: PosAlign.center, bold: true, width: PosTextSize.size4));
    // bytes += ticket.text(timestamp, styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.feed(1);
    bytes += ticket.hr(len: 30);
    // bytes += ticket.text(datos.empresa!.empresaName.toString(), styles: const PosStyles(align: PosAlign.center, bold: true));
    bytes += ticket.image(_imgQR!);
    bytes += ticket.text(datos["guid"] ?? datos["shippingform-01-06"], styles: const PosStyles(align: PosAlign.center));
    // bytes += ticket.text(datos.ordenInfo!.paqueteNumero.toString(), styles: const PosStyles(align: PosAlign.center));
    bytes += ticket.hr(ch: '=', len: 30);
    bytes += ticket.feed(2);
    bytes += ticket.cut();
    return bytes;
  }

  Future<void> printReciver({
    SaveFormModel? datos,
    SaveFormModel2? datos2,
    int tipo = 0,
  }) async {
    try {
      final bool result = await PrintBluetoothThermal.bluetoothEnabled;
      // final bool result = await PrintBluetoothThermal.bluetoothEnabled;
      // int conecctionStatus2 = await PrintBluetoothThermal.batteryLevel;
      await connect();
      bool conecctionStatus = await PrintBluetoothThermal.connectionStatus;

      if (conecctionStatus) {
        const PaperSize paper = PaperSize.mm80;
        final profile = await CapabilityProfile.load();

        await PrintBluetoothThermal.writeBytes(tipo == 0 ? await receiptSaveForm(paper: paper, profile: profile, datos: datos!) : await receiptNewForm(paper: paper, profile: profile, datos: datos2!));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Imag.Image?> qrimg({required String qrData, double qrSize = 200}) async {
    // String qrData = "google.com";
    // const double qrSize = 200;
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

class Alertas {
  final String titulo;
  final String subtitulo;
  final String textToCopy;
  final int tipo;
  final BuildContext ctn;
  final bool barrierDismissible;

  ///[tipo]
  ///muestra el header 1-Cargando 2-Completado 3- Error

  Alertas({required this.titulo, required this.ctn, this.subtitulo = "", this.tipo = 1, this.barrierDismissible = false, this.textToCopy = ""});

  void showAlert() {
    showDialog(
        context: ctn,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return LoadingAlertDialog(
            loadingTitle: titulo,
            subTitle: subtitulo,
            tipo: tipo,
            textToCopy: textToCopy,
          );
        });
  }

  void disspose() {
    Navigator.pop(ctn);
  }
}
