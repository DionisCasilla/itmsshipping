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
    required this.paqueteFirmado,
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
  String paqueteFirmado;

  factory FormSavingModel.fromJson(Map<String, dynamic> json) => FormSavingModel(
        interId: json["InterID"],
        paqueteId: json["PaqueteID"],
        paqueteNumero: json["PaqueteNumero"],
        paqueteEnvioTipoId: json["PaqueteEnvioTipoID"],
        paqueteClienteId: json["PaqueteClienteID"],
        paqueteEstatusId: json["PaqueteEstatusID"],
        paqueteTracking: json["PaqueteTracking"],
        paqueteRetenido: json["PaqueteRetenido"],
        paqueteFechaEntrega: json["PaqueteFechaEntrega"] == null ? DateTime.now() : DateTime.parse(json["PaqueteFechaEntrega"]),
        paqueteDestinoId: json["PaqueteDestinoID"],
        paqueteProveedor: json["PaqueteProveedor"],
        paqueteContenido: json["PaqueteContenido"],
        paqueteContenidoPaquetes: json["PaqueteContenidoPaquetes"],
        paqueteContenidoFecha1: json["PaqueteContenidoFecha1"],
        paqueteContenidoFecha2: json["PaqueteContenidoFecha2"],
        paqueteContenidoTipoId: json["PaqueteContenidoTipoID"],
        paqueteContenidoTipo: json["PaqueteContenidoTipo"],
        paqueteContenidoL: json["PaqueteContenidoL"],
        paqueteContenidoW: json["PaqueteContenidoW"],
        paqueteContenidoH: json["PaqueteContenidoH"],
        paqueteContenidoTipoCantidad: json["PaqueteContenidoTipoCantidad"],
        paqueteContenidoTipoValor: json["PaqueteContenidoTipoValor"],
        paqueteContenidoTipoTotal: json["PaqueteContenidoTipoTotal"],
        paqueteContenidoManejo: json["PaqueteContenidoManejo"],
        paqueteContenidoPeso: json["PaqueteContenidoPeso"],
        paqueteContenidoVolumen: json["PaqueteContenidoVolumen"],
        paqueteContenidoBalance: json["PaqueteContenidoBalance"],
        paqueteFacturaTotal: json["PaqueteFacturaTotal"],
        paqueteAsegurado: json["PaqueteAsegurado"],
        paqueteFacturaId: json["PaqueteFacturaID"],
        paqueteSenderId: json["PaqueteSenderID"],
        paqueteSenderNombre: json["PaqueteSenderNombre"],
        paqueteSenderDireccion: json["PaqueteSenderDireccion"],
        paqueteSenderTel1: json["PaqueteSenderTel1"],
        paqueteSenderIdetificacionTipo: json["PaqueteSenderIdetificacionTipo"],
        paqueteSenderIdetificacionId: json["PaqueteSenderIdetificacionID"],
        paqueteRecieverId: json["PaqueteRecieverID"],
        paqueteRecieverNombre: json["PaqueteRecieverNombre"],
        paqueteRecieverDireccion: json["PaqueteRecieverDireccion"],
        paqueteRecieverTel1: json["PaqueteRecieverTel1"],
        paquetePrioridadId: json["PaquetePrioridadID"],
        rowAct: json["RowAct"],
        rowUsr: json["RowUsr"],
        rowCdt: json["RowCdt"] == null ? DateTime.now() : DateTime.parse(json["RowCdt"]),
        rowMdt: json["RowMdt"] == null ? DateTime.now() : DateTime.parse(json["RowMdt"]),
        rowIdx: json["RowIdx"],
        paqueteTrackingEstatusId: json["PaqueteTrackingEstatusID"],
        paqueteCiudadId: json["PaqueteCiudadID"],
        paqueteCiudadTexto: json["PaqueteCiudadTexto"],
        paqueteSenderIdetificacionVence: json["PaqueteSenderIdetificacionVence"],
        paqueteEntregado: json["PaqueteEntregado"],
        paqueteEntregadoFecha: json["PaqueteEntregadoFecha"],
        paqueteEntregadoNombre: json["PaqueteEntregadoNombre"],
        paqueteEntregadoUsuarioId: json["PaqueteEntregadoUsuarioID"],
        paqueteEntregadoUsuarioNombre: json["PaqueteEntregadoUsuarioNombre"],
        paqueteEntregadoFirma: json["PaqueteEntregadoFirma"],
        paqueteFirmado: json["PaqueteFirmado"],
      );

  Map<String, dynamic> toJson() => {
        "InterID": interId,
        "PaqueteID": paqueteId,
        "PaqueteNumero": paqueteNumero,
        "PaqueteEnvioTipoID": paqueteEnvioTipoId,
        "PaqueteClienteID": paqueteClienteId,
        "PaqueteEstatusID": paqueteEstatusId,
        "PaqueteTracking": paqueteTracking,
        "PaqueteRetenido": paqueteRetenido,
        "PaqueteFechaEntrega": paqueteFechaEntrega == null ? null : paqueteFechaEntrega.toIso8601String(),
        "PaqueteDestinoID": paqueteDestinoId,
        "PaqueteProveedor": paqueteProveedor,
        "PaqueteContenido": paqueteContenido,
        "PaqueteContenidoPaquetes": paqueteContenidoPaquetes,
        "PaqueteContenidoFecha1": paqueteContenidoFecha1,
        "PaqueteContenidoFecha2": paqueteContenidoFecha2,
        "PaqueteContenidoTipoID": paqueteContenidoTipoId,
        "PaqueteContenidoTipo": paqueteContenidoTipo,
        "PaqueteContenidoL": paqueteContenidoL,
        "PaqueteContenidoW": paqueteContenidoW,
        "PaqueteContenidoH": paqueteContenidoH,
        "PaqueteContenidoTipoCantidad": paqueteContenidoTipoCantidad,
        "PaqueteContenidoTipoValor": paqueteContenidoTipoValor,
        "PaqueteContenidoTipoTotal": paqueteContenidoTipoTotal,
        "PaqueteContenidoManejo": paqueteContenidoManejo,
        "PaqueteContenidoPeso": paqueteContenidoPeso,
        "PaqueteContenidoVolumen": paqueteContenidoVolumen,
        "PaqueteContenidoBalance": paqueteContenidoBalance,
        "PaqueteFacturaTotal": paqueteFacturaTotal,
        "PaqueteAsegurado": paqueteAsegurado,
        "PaqueteFacturaID": paqueteFacturaId,
        "PaqueteSenderID": paqueteSenderId,
        "PaqueteSenderNombre": paqueteSenderNombre,
        "PaqueteSenderDireccion": paqueteSenderDireccion,
        "PaqueteSenderTel1": paqueteSenderTel1,
        "PaqueteSenderIdetificacionTipo": paqueteSenderIdetificacionTipo,
        "PaqueteSenderIdetificacionID": paqueteSenderIdetificacionId,
        "PaqueteRecieverID": paqueteRecieverId,
        "PaqueteRecieverNombre": paqueteRecieverNombre,
        "PaqueteRecieverDireccion": paqueteRecieverDireccion,
        "PaqueteRecieverTel1": paqueteRecieverTel1,
        "PaquetePrioridadID": paquetePrioridadId,
        "RowAct": rowAct,
        "RowUsr": rowUsr,
        "RowCdt": rowCdt == null ? null : rowCdt.toIso8601String(),
        "RowMdt": rowMdt == null ? null : rowMdt.toIso8601String(),
        "RowIdx": rowIdx,
        "PaqueteTrackingEstatusID": paqueteTrackingEstatusId,
        "PaqueteCiudadID": paqueteCiudadId,
        "PaqueteCiudadTexto": paqueteCiudadTexto,
        "PaqueteSenderIdetificacionVence": paqueteSenderIdetificacionVence,
        "PaqueteEntregado": paqueteEntregado,
        "PaqueteEntregadoFecha": paqueteEntregadoFecha,
        "PaqueteEntregadoNombre": paqueteEntregadoNombre,
        "PaqueteEntregadoUsuarioID": paqueteEntregadoUsuarioId,
        "PaqueteEntregadoUsuarioNombre": paqueteEntregadoUsuarioNombre,
        "PaqueteEntregadoFirma": paqueteEntregadoFirma,
      };
}
