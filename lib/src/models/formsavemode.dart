// To parse this JSON data, do
//
//     final formSavingModel = formSavingModelFromJson(jsonString);

import 'dart:convert';

FormSavingModel formSavingModelFromJson(String str) => FormSavingModel.fromJson(json.decode(str));

String formSavingModelToJson(FormSavingModel data) => json.encode(data.toJson());

class SaveFormModel2 {
  SaveFormModel2({
    this.empresa,
    this.ordenInfo,
  });

  Empresa? empresa;
  FormSavingModel? ordenInfo;

  factory SaveFormModel2.fromJson(Map<String, dynamic> json) => SaveFormModel2(
        empresa: json["empresa"] == null ? null : Empresa.fromJson(json["empresa"]),
        ordenInfo: json["ordenInfo"] == null ? null : FormSavingModel.fromJson(json["ordenInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "empresa": empresa == null ? null : empresa!.toJson(),
        "ordenInfo": ordenInfo == null ? null : ordenInfo!.toJson(),
      };
}

class Empresa {
  Empresa({
    this.interId = "",
    this.masterInterId = "",
    this.interTexto = "",
    this.interCodigoId = "",
    this.interDireccion = "",
    this.interWebSite = "",
    this.interEmail = "",
    this.interTelefono = "",
    this.logoUrl = "",
    this.colorEmpresa = "",
    this.empresaName = "",
  });

  String interId = "";
  String masterInterId = "";
  String interTexto = "";
  String interCodigoId = "";
  String interDireccion = "";
  String interWebSite = "";
  String interEmail = "";
  String interTelefono = "";
  String logoUrl = "";
  String colorEmpresa = "";
  String empresaName = "";

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        interId: json["InterID"] ?? "",
        masterInterId: json["MasterInterID"] ?? "",
        interTexto: json["InterTexto"] ?? "",
        interCodigoId: json["InterCodigoID"] ?? "",
        interDireccion: json["InterDireccion"] ?? "",
        interWebSite: json["InterWebSite"] ?? "",
        interEmail: json["InterEmail"] ?? "",
        interTelefono: json["InterTelefono"] ?? "",
        logoUrl: json["LogoUrl"] ?? "",
        colorEmpresa: json["ColorEmpresa"] ?? "",
        empresaName: json["EmpresaName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "InterID": interId,
        "MasterInterID": masterInterId,
        "InterTexto": interTexto,
        "InterCodigoID": interCodigoId,
        "InterDireccion": interDireccion,
        "InterWebSite": interWebSite,
        "InterEmail": interEmail,
        "InterTelefono": interTelefono,
        "LogoUrl": logoUrl,
        "ColorEmpresa": colorEmpresa,
      };
}

class FormSavingModel {
  FormSavingModel({
    required this.interId,
    required this.paqueteId,
    required this.paqueteNumero,
    required this.paqueteEnvioTipoId,
    required this.paqueteClienteId,
    required this.paqueteEstatusId,
    required this.paqueteTracking,
    required this.paqueteRetenido,
    required this.paqueteFechaEntrega,
    required this.paqueteDestinoId,
    required this.paqueteProveedor,
    required this.paqueteContenido,
    required this.paqueteContenidoPaquetes,
    required this.paqueteContenidoFecha1,
    required this.paqueteContenidoFecha2,
    required this.paqueteContenidoTipoId,
    required this.paqueteContenidoTipo,
    required this.paqueteContenidoL,
    required this.paqueteContenidoW,
    required this.paqueteContenidoH,
    required this.paqueteContenidoTipoCantidad,
    required this.paqueteContenidoTipoValor,
    required this.paqueteContenidoTipoTotal,
    required this.paqueteContenidoManejo,
    required this.paqueteContenidoPeso,
    required this.paqueteContenidoVolumen,
    required this.paqueteContenidoBalance,
    required this.paqueteFacturaTotal,
    required this.paqueteAsegurado,
    required this.paqueteFacturaId,
    required this.paqueteSenderId,
    required this.paqueteSenderNombre,
    required this.paqueteSenderDireccion,
    required this.paqueteSenderTel1,
    required this.paqueteSenderIdetificacionTipo,
    required this.paqueteSenderIdetificacionId,
    required this.paqueteRecieverId,
    required this.paqueteRecieverNombre,
    required this.paqueteRecieverDireccion,
    required this.paqueteRecieverTel1,
    required this.paquetePrioridadId,
    required this.rowAct,
    required this.rowUsr,
    required this.rowCdt,
    required this.rowMdt,
    required this.rowIdx,
    required this.paqueteTrackingEstatusId,
    required this.paqueteCiudadId,
    required this.paqueteCiudadTexto,
    required this.paqueteSenderIdetificacionVence,
    required this.paqueteEntregado,
    required this.paqueteEntregadoFecha,
    required this.paqueteEntregadoNombre,
    required this.paqueteEntregadoUsuarioId,
    required this.paqueteEntregadoUsuarioNombre,
    required this.paqueteEntregadoFirma,
  });

  String interId;
  String paqueteId;
  String paqueteNumero;
  int paqueteEnvioTipoId;
  String paqueteClienteId;
  String paqueteEstatusId;
  String paqueteTracking;
  int paqueteRetenido;
  DateTime paqueteFechaEntrega;
  String paqueteDestinoId;
  String paqueteProveedor;
  String paqueteContenido;
  String paqueteContenidoPaquetes;
  String paqueteContenidoFecha1;
  String paqueteContenidoFecha2;
  String paqueteContenidoTipoId;
  String paqueteContenidoTipo;
  int paqueteContenidoL;
  int paqueteContenidoW;
  int paqueteContenidoH;
  int paqueteContenidoTipoCantidad;
  int paqueteContenidoTipoValor;
  int paqueteContenidoTipoTotal;
  String paqueteContenidoManejo;
  int paqueteContenidoPeso;
  int paqueteContenidoVolumen;
  int paqueteContenidoBalance;
  int paqueteFacturaTotal;
  int paqueteAsegurado;
  String paqueteFacturaId;
  String paqueteSenderId;
  String paqueteSenderNombre;
  String paqueteSenderDireccion;
  String paqueteSenderTel1;
  int paqueteSenderIdetificacionTipo;
  String paqueteSenderIdetificacionId;
  String paqueteRecieverId;
  String paqueteRecieverNombre;
  String paqueteRecieverDireccion;
  String paqueteRecieverTel1;
  int paquetePrioridadId;
  int rowAct;
  String rowUsr;
  DateTime rowCdt;
  DateTime rowMdt;
  int rowIdx;
  int paqueteTrackingEstatusId;
  String paqueteCiudadId;
  String paqueteCiudadTexto;
  String paqueteSenderIdetificacionVence;
  int paqueteEntregado;
  String paqueteEntregadoFecha;
  String paqueteEntregadoNombre;
  String paqueteEntregadoUsuarioId;
  String paqueteEntregadoUsuarioNombre;
  String paqueteEntregadoFirma;

  factory FormSavingModel.fromJson(Map<String, dynamic> json) => FormSavingModel(
        interId: json["InterID"] == null ? null : json["InterID"],
        paqueteId: json["PaqueteID"] == null ? null : json["PaqueteID"],
        paqueteNumero: json["PaqueteNumero"] == null ? null : json["PaqueteNumero"],
        paqueteEnvioTipoId: json["PaqueteEnvioTipoID"] == null ? null : json["PaqueteEnvioTipoID"],
        paqueteClienteId: json["PaqueteClienteID"] == null ? null : json["PaqueteClienteID"],
        paqueteEstatusId: json["PaqueteEstatusID"] == null ? null : json["PaqueteEstatusID"],
        paqueteTracking: json["PaqueteTracking"] == null ? null : json["PaqueteTracking"],
        paqueteRetenido: json["PaqueteRetenido"] == null ? null : json["PaqueteRetenido"],
        paqueteFechaEntrega: json["PaqueteFechaEntrega"] == null ? DateTime.now() : DateTime.parse(json["PaqueteFechaEntrega"]),
        paqueteDestinoId: json["PaqueteDestinoID"] == null ? null : json["PaqueteDestinoID"],
        paqueteProveedor: json["PaqueteProveedor"] == null ? null : json["PaqueteProveedor"],
        paqueteContenido: json["PaqueteContenido"] == null ? null : json["PaqueteContenido"],
        paqueteContenidoPaquetes: json["PaqueteContenidoPaquetes"] == null ? null : json["PaqueteContenidoPaquetes"],
        paqueteContenidoFecha1: json["PaqueteContenidoFecha1"] == null ? null : json["PaqueteContenidoFecha1"],
        paqueteContenidoFecha2: json["PaqueteContenidoFecha2"] == null ? null : json["PaqueteContenidoFecha2"],
        paqueteContenidoTipoId: json["PaqueteContenidoTipoID"] == null ? null : json["PaqueteContenidoTipoID"],
        paqueteContenidoTipo: json["PaqueteContenidoTipo"] == null ? null : json["PaqueteContenidoTipo"],
        paqueteContenidoL: json["PaqueteContenidoL"] == null ? null : json["PaqueteContenidoL"],
        paqueteContenidoW: json["PaqueteContenidoW"] == null ? null : json["PaqueteContenidoW"],
        paqueteContenidoH: json["PaqueteContenidoH"] == null ? null : json["PaqueteContenidoH"],
        paqueteContenidoTipoCantidad: json["PaqueteContenidoTipoCantidad"] == null ? null : json["PaqueteContenidoTipoCantidad"],
        paqueteContenidoTipoValor: json["PaqueteContenidoTipoValor"] == null ? null : json["PaqueteContenidoTipoValor"],
        paqueteContenidoTipoTotal: json["PaqueteContenidoTipoTotal"] == null ? null : json["PaqueteContenidoTipoTotal"],
        paqueteContenidoManejo: json["PaqueteContenidoManejo"] == null ? null : json["PaqueteContenidoManejo"],
        paqueteContenidoPeso: json["PaqueteContenidoPeso"] == null ? null : json["PaqueteContenidoPeso"],
        paqueteContenidoVolumen: json["PaqueteContenidoVolumen"] == null ? null : json["PaqueteContenidoVolumen"],
        paqueteContenidoBalance: json["PaqueteContenidoBalance"] == null ? null : json["PaqueteContenidoBalance"],
        paqueteFacturaTotal: json["PaqueteFacturaTotal"] == null ? null : json["PaqueteFacturaTotal"],
        paqueteAsegurado: json["PaqueteAsegurado"] == null ? null : json["PaqueteAsegurado"],
        paqueteFacturaId: json["PaqueteFacturaID"] == null ? null : json["PaqueteFacturaID"],
        paqueteSenderId: json["PaqueteSenderID"] == null ? null : json["PaqueteSenderID"],
        paqueteSenderNombre: json["PaqueteSenderNombre"] == null ? null : json["PaqueteSenderNombre"],
        paqueteSenderDireccion: json["PaqueteSenderDireccion"] == null ? null : json["PaqueteSenderDireccion"],
        paqueteSenderTel1: json["PaqueteSenderTel1"] == null ? null : json["PaqueteSenderTel1"],
        paqueteSenderIdetificacionTipo: json["PaqueteSenderIdetificacionTipo"] == null ? null : json["PaqueteSenderIdetificacionTipo"],
        paqueteSenderIdetificacionId: json["PaqueteSenderIdetificacionID"] == null ? null : json["PaqueteSenderIdetificacionID"],
        paqueteRecieverId: json["PaqueteRecieverID"] == null ? null : json["PaqueteRecieverID"],
        paqueteRecieverNombre: json["PaqueteRecieverNombre"] == null ? null : json["PaqueteRecieverNombre"],
        paqueteRecieverDireccion: json["PaqueteRecieverDireccion"] == null ? null : json["PaqueteRecieverDireccion"],
        paqueteRecieverTel1: json["PaqueteRecieverTel1"] == null ? null : json["PaqueteRecieverTel1"],
        paquetePrioridadId: json["PaquetePrioridadID"] == null ? null : json["PaquetePrioridadID"],
        rowAct: json["RowAct"] == null ? null : json["RowAct"],
        rowUsr: json["RowUsr"] == null ? null : json["RowUsr"],
        rowCdt: json["RowCdt"] == null ? DateTime.now() : DateTime.parse(json["RowCdt"]),
        rowMdt: json["RowMdt"] == null ? DateTime.now() : DateTime.parse(json["RowMdt"]),
        rowIdx: json["RowIdx"] == null ? null : json["RowIdx"],
        paqueteTrackingEstatusId: json["PaqueteTrackingEstatusID"] == null ? null : json["PaqueteTrackingEstatusID"],
        paqueteCiudadId: json["PaqueteCiudadID"] == null ? null : json["PaqueteCiudadID"],
        paqueteCiudadTexto: json["PaqueteCiudadTexto"] == null ? null : json["PaqueteCiudadTexto"],
        paqueteSenderIdetificacionVence: json["PaqueteSenderIdetificacionVence"] == null ? null : json["PaqueteSenderIdetificacionVence"],
        paqueteEntregado: json["PaqueteEntregado"] == null ? null : json["PaqueteEntregado"],
        paqueteEntregadoFecha: json["PaqueteEntregadoFecha"] == null ? null : json["PaqueteEntregadoFecha"],
        paqueteEntregadoNombre: json["PaqueteEntregadoNombre"] == null ? null : json["PaqueteEntregadoNombre"],
        paqueteEntregadoUsuarioId: json["PaqueteEntregadoUsuarioID"] == null ? null : json["PaqueteEntregadoUsuarioID"],
        paqueteEntregadoUsuarioNombre: json["PaqueteEntregadoUsuarioNombre"] == null ? null : json["PaqueteEntregadoUsuarioNombre"],
        paqueteEntregadoFirma: json["PaqueteEntregadoFirma"] == null ? null : json["PaqueteEntregadoFirma"],
      );

  Map<String, dynamic> toJson() => {
        "InterID": interId == null ? null : interId,
        "PaqueteID": paqueteId == null ? null : paqueteId,
        "PaqueteNumero": paqueteNumero == null ? null : paqueteNumero,
        "PaqueteEnvioTipoID": paqueteEnvioTipoId == null ? null : paqueteEnvioTipoId,
        "PaqueteClienteID": paqueteClienteId == null ? null : paqueteClienteId,
        "PaqueteEstatusID": paqueteEstatusId == null ? null : paqueteEstatusId,
        "PaqueteTracking": paqueteTracking == null ? null : paqueteTracking,
        "PaqueteRetenido": paqueteRetenido == null ? null : paqueteRetenido,
        "PaqueteFechaEntrega": paqueteFechaEntrega == null ? null : paqueteFechaEntrega.toIso8601String(),
        "PaqueteDestinoID": paqueteDestinoId == null ? null : paqueteDestinoId,
        "PaqueteProveedor": paqueteProveedor == null ? null : paqueteProveedor,
        "PaqueteContenido": paqueteContenido == null ? null : paqueteContenido,
        "PaqueteContenidoPaquetes": paqueteContenidoPaquetes == null ? null : paqueteContenidoPaquetes,
        "PaqueteContenidoFecha1": paqueteContenidoFecha1 == null ? null : paqueteContenidoFecha1,
        "PaqueteContenidoFecha2": paqueteContenidoFecha2 == null ? null : paqueteContenidoFecha2,
        "PaqueteContenidoTipoID": paqueteContenidoTipoId == null ? null : paqueteContenidoTipoId,
        "PaqueteContenidoTipo": paqueteContenidoTipo == null ? null : paqueteContenidoTipo,
        "PaqueteContenidoL": paqueteContenidoL == null ? null : paqueteContenidoL,
        "PaqueteContenidoW": paqueteContenidoW == null ? null : paqueteContenidoW,
        "PaqueteContenidoH": paqueteContenidoH == null ? null : paqueteContenidoH,
        "PaqueteContenidoTipoCantidad": paqueteContenidoTipoCantidad == null ? null : paqueteContenidoTipoCantidad,
        "PaqueteContenidoTipoValor": paqueteContenidoTipoValor == null ? null : paqueteContenidoTipoValor,
        "PaqueteContenidoTipoTotal": paqueteContenidoTipoTotal == null ? null : paqueteContenidoTipoTotal,
        "PaqueteContenidoManejo": paqueteContenidoManejo == null ? null : paqueteContenidoManejo,
        "PaqueteContenidoPeso": paqueteContenidoPeso == null ? null : paqueteContenidoPeso,
        "PaqueteContenidoVolumen": paqueteContenidoVolumen == null ? null : paqueteContenidoVolumen,
        "PaqueteContenidoBalance": paqueteContenidoBalance == null ? null : paqueteContenidoBalance,
        "PaqueteFacturaTotal": paqueteFacturaTotal == null ? null : paqueteFacturaTotal,
        "PaqueteAsegurado": paqueteAsegurado == null ? null : paqueteAsegurado,
        "PaqueteFacturaID": paqueteFacturaId == null ? null : paqueteFacturaId,
        "PaqueteSenderID": paqueteSenderId == null ? null : paqueteSenderId,
        "PaqueteSenderNombre": paqueteSenderNombre == null ? null : paqueteSenderNombre,
        "PaqueteSenderDireccion": paqueteSenderDireccion == null ? null : paqueteSenderDireccion,
        "PaqueteSenderTel1": paqueteSenderTel1 == null ? null : paqueteSenderTel1,
        "PaqueteSenderIdetificacionTipo": paqueteSenderIdetificacionTipo == null ? null : paqueteSenderIdetificacionTipo,
        "PaqueteSenderIdetificacionID": paqueteSenderIdetificacionId == null ? null : paqueteSenderIdetificacionId,
        "PaqueteRecieverID": paqueteRecieverId == null ? null : paqueteRecieverId,
        "PaqueteRecieverNombre": paqueteRecieverNombre == null ? null : paqueteRecieverNombre,
        "PaqueteRecieverDireccion": paqueteRecieverDireccion == null ? null : paqueteRecieverDireccion,
        "PaqueteRecieverTel1": paqueteRecieverTel1 == null ? null : paqueteRecieverTel1,
        "PaquetePrioridadID": paquetePrioridadId == null ? null : paquetePrioridadId,
        "RowAct": rowAct == null ? null : rowAct,
        "RowUsr": rowUsr == null ? null : rowUsr,
        "RowCdt": rowCdt == null ? null : rowCdt.toIso8601String(),
        "RowMdt": rowMdt == null ? null : rowMdt.toIso8601String(),
        "RowIdx": rowIdx == null ? null : rowIdx,
        "PaqueteTrackingEstatusID": paqueteTrackingEstatusId == null ? null : paqueteTrackingEstatusId,
        "PaqueteCiudadID": paqueteCiudadId == null ? null : paqueteCiudadId,
        "PaqueteCiudadTexto": paqueteCiudadTexto == null ? null : paqueteCiudadTexto,
        "PaqueteSenderIdetificacionVence": paqueteSenderIdetificacionVence == null ? null : paqueteSenderIdetificacionVence,
        "PaqueteEntregado": paqueteEntregado == null ? null : paqueteEntregado,
        "PaqueteEntregadoFecha": paqueteEntregadoFecha == null ? null : paqueteEntregadoFecha,
        "PaqueteEntregadoNombre": paqueteEntregadoNombre == null ? null : paqueteEntregadoNombre,
        "PaqueteEntregadoUsuarioID": paqueteEntregadoUsuarioId == null ? null : paqueteEntregadoUsuarioId,
        "PaqueteEntregadoUsuarioNombre": paqueteEntregadoUsuarioNombre == null ? null : paqueteEntregadoUsuarioNombre,
        "PaqueteEntregadoFirma": paqueteEntregadoFirma == null ? null : paqueteEntregadoFirma,
      };
}
