// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

SaveFormModel userListModelFromJson(String str) => SaveFormModel.fromJson(json.decode(str));

String userListModelToJson(SaveFormModel data) => json.encode(data.toJson());

class SaveFormModel {
  SaveFormModel({
    this.empresa,
    this.ordenInfo,
  });

  Empresa? empresa;
  OrdenInfo? ordenInfo;

  factory SaveFormModel.fromJson(Map<String, dynamic> json) => SaveFormModel(
        empresa: json["empresa"] == null ? null : Empresa.fromJson(json["empresa"]),
        ordenInfo: json["ordenInfo"] == null ? null : OrdenInfo.fromJson(json["ordenInfo"]),
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

class OrdenInfo {
  OrdenInfo(
      {this.interId,
      this.trackId,
      this.trackPaqueteId,
      this.trackEstadoId,
      this.trackEstadoTexto,
      this.trackEstadoBloquea,
      this.trackTexto,
      this.rowAct,
      this.rowUsr,
      this.rowCdt,
      this.rowMdt,
      this.rowIdx,
      this.paqueteId,
      this.paqueteNumero,
      this.paqueteEnvioTipoId,
      this.paqueteClienteId,
      this.paqueteEstatusId,
      this.paqueteTracking,
      this.paqueteRetenido,
      this.paqueteFechaEntrega,
      this.paqueteDestinoId,
      this.paqueteProveedor,
      this.paqueteContenido,
      this.paqueteContenidoPaquetes,
      this.paqueteContenidoFecha1,
      this.paqueteContenidoFecha2,
      this.paqueteContenidoTipoId,
      this.paqueteContenidoTipo,
      this.paqueteContenidoL,
      this.paqueteContenidoW,
      this.paqueteContenidoH,
      this.paqueteContenidoTipoCantidad,
      this.paqueteContenidoTipoValor,
      this.paqueteContenidoTipoTotal,
      this.paqueteContenidoManejo,
      this.paqueteContenidoPeso,
      this.paqueteContenidoVolumen,
      this.paqueteContenidoBalance,
      this.paqueteFacturaTotal,
      this.paqueteAsegurado,
      this.paqueteFacturaId,
      this.paqueteSenderId,
      this.paqueteSenderNombre,
      this.paqueteSenderDireccion,
      this.paqueteSenderTel1,
      this.paqueteSenderIdetificacionTipo,
      this.paqueteSenderIdetificacionId,
      this.paqueteRecieverId,
      this.paqueteRecieverNombre,
      this.paqueteRecieverDireccion,
      this.paqueteRecieverTel1,
      this.paquetePrioridadId,
      this.paqueteTrackingEstatusId,
      this.paqueteCiudadId,
      this.paqueteCiudadTexto,
      this.paqueteSenderIdetificacionVence,
      this.paqueteEntregado,
      this.paqueteEntregadoFecha,
      this.paqueteEntregadoNombre,
      this.paqueteEntregadoUsuarioId,
      this.paqueteEntregadoUsuarioNombre,
      this.paqueteEntregadoFirma,
      this.currencyId,
      this.paqueteIdTemporal});

  List<String>? interId;
  String? trackId;
  String? trackPaqueteId;
  String? trackEstadoId;
  String? trackEstadoTexto;
  int? trackEstadoBloquea;
  String? trackTexto;
  List<int>? rowAct;
  List<String>? rowUsr;
  List<DateTime>? rowCdt;
  List<DateTime>? rowMdt;
  List<int>? rowIdx;
  String? paqueteId;
  String? paqueteNumero;
  int? paqueteEnvioTipoId;
  String? paqueteClienteId;
  String? paqueteEstatusId;
  String? paqueteTracking;
  int? paqueteRetenido;
  DateTime? paqueteFechaEntrega;
  String? paqueteDestinoId;
  String? paqueteProveedor;
  String? paqueteContenido;
  String? paqueteContenidoPaquetes;
  String? paqueteContenidoFecha1;
  String? paqueteContenidoFecha2;
  String? paqueteContenidoTipoId;
  String? paqueteContenidoTipo;
  int? paqueteContenidoL;
  int? paqueteContenidoW;
  int? paqueteContenidoH;
  int? paqueteContenidoTipoCantidad;
  int? paqueteContenidoTipoValor;
  int? paqueteContenidoTipoTotal;
  String? paqueteContenidoManejo;
  int? paqueteContenidoPeso;
  int? paqueteContenidoVolumen;
  int? paqueteContenidoBalance;
  int? paqueteFacturaTotal;
  int? paqueteAsegurado;
  String? paqueteFacturaId;
  String? paqueteSenderId;
  String? paqueteSenderNombre;
  String? paqueteSenderDireccion;
  String? paqueteSenderTel1;
  int? paqueteSenderIdetificacionTipo;
  String? paqueteSenderIdetificacionId;
  String? paqueteRecieverId;
  String? paqueteRecieverNombre;
  String? paqueteRecieverDireccion;
  String? paqueteRecieverTel1;
  int? paquetePrioridadId;
  int? paqueteTrackingEstatusId;
  String? paqueteCiudadId;
  String? paqueteCiudadTexto;
  String? paqueteSenderIdetificacionVence;
  int? paqueteEntregado;
  String? paqueteEntregadoFecha;
  String? paqueteEntregadoNombre;
  String? paqueteEntregadoUsuarioId;
  String? paqueteEntregadoUsuarioNombre;
  String? paqueteEntregadoFirma;
  String? currencyId;
  String? paqueteIdTemporal;

  factory OrdenInfo.fromJson(Map<String, dynamic> json) => OrdenInfo(
        interId: json["InterID"] == null ? null : List<String>.from(json["InterID"].map((x) => x)),
        trackId: json["TrackID"],
        trackPaqueteId: json["TrackPaqueteID"],
        trackEstadoId: json["TrackEstadoID"],
        trackEstadoTexto: json["TrackEstadoTexto"],
        trackEstadoBloquea: json["TrackEstadoBloquea"],
        trackTexto: json["TrackTexto"],
        rowAct: json["RowAct"] == null ? null : List<int>.from(json["RowAct"].map((x) => x)),
        rowUsr: json["RowUsr"] == null ? null : List<String>.from(json["RowUsr"].map((x) => x)),
        rowCdt: json["RowCdt"] == null ? null : List<DateTime>.from(json["RowCdt"].map((x) => DateTime.parse(x))),
        rowMdt: json["RowMdt"] == null ? null : List<DateTime>.from(json["RowMdt"].map((x) => DateTime.parse(x))),
        rowIdx: json["RowIdx"] == null ? null : List<int>.from(json["RowIdx"].map((x) => x)),
        paqueteId: json["PaqueteID"],
        paqueteNumero: json["PaqueteNumero"],
        paqueteEnvioTipoId: json["PaqueteEnvioTipoID"],
        paqueteClienteId: json["PaqueteClienteID"],
        paqueteEstatusId: json["PaqueteEstatusID"],
        paqueteTracking: json["PaqueteTracking"],
        paqueteRetenido: json["PaqueteRetenido"],
        paqueteFechaEntrega: json["PaqueteFechaEntrega"] == null ? null : DateTime.parse(json["PaqueteFechaEntrega"]),
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
        currencyId: json["CurrencyID"],
        paqueteIdTemporal: json["PaqueteIdTemporal"],
      );

  Map<String, dynamic> toJson() => {
        "InterID": interId == null ? null : List<dynamic>.from(interId!.map((x) => x)),
        "TrackID": trackId ?? null,
        "TrackPaqueteID": trackPaqueteId ?? null,
        "TrackEstadoID": trackEstadoId ?? null,
        "TrackEstadoTexto": trackEstadoTexto ?? null,
        "TrackEstadoBloquea": trackEstadoBloquea ?? null,
        "TrackTexto": trackTexto ?? null,
        "RowAct": rowAct == null ? null : List<dynamic>.from(rowAct!.map((x) => x)),
        "RowUsr": rowUsr == null ? null : List<dynamic>.from(rowUsr!.map((x) => x)),
        "RowCdt": rowCdt == null ? null : List<dynamic>.from(rowCdt!.map((x) => x.toIso8601String())),
        "RowMdt": rowMdt == null ? null : List<dynamic>.from(rowMdt!.map((x) => x.toIso8601String())),
        "RowIdx": rowIdx == null ? null : List<dynamic>.from(rowIdx!.map((x) => x)),
        "PaqueteID": paqueteId ?? null,
        "PaqueteNumero": paqueteNumero ?? null,
        "PaqueteEnvioTipoID": paqueteEnvioTipoId ?? null,
        "PaqueteClienteID": paqueteClienteId ?? null,
        "PaqueteEstatusID": paqueteEstatusId ?? null,
        "PaqueteTracking": paqueteTracking ?? null,
        "PaqueteRetenido": paqueteRetenido ?? null,
        "PaqueteFechaEntrega": paqueteFechaEntrega == null ? null : paqueteFechaEntrega!.toIso8601String(),
        "PaqueteDestinoID": paqueteDestinoId ?? null,
        "PaqueteProveedor": paqueteProveedor ?? null,
        "PaqueteContenido": paqueteContenido ?? null,
        "PaqueteContenidoPaquetes": paqueteContenidoPaquetes ?? null,
        "PaqueteContenidoFecha1": paqueteContenidoFecha1 ?? null,
        "PaqueteContenidoFecha2": paqueteContenidoFecha2 ?? null,
        "PaqueteContenidoTipoID": paqueteContenidoTipoId ?? null,
        "PaqueteContenidoTipo": paqueteContenidoTipo ?? null,
        "PaqueteContenidoL": paqueteContenidoL ?? null,
        "PaqueteContenidoW": paqueteContenidoW ?? null,
        "PaqueteContenidoH": paqueteContenidoH ?? null,
        "PaqueteContenidoTipoCantidad": paqueteContenidoTipoCantidad ?? null,
        "PaqueteContenidoTipoValor": paqueteContenidoTipoValor ?? null,
        "PaqueteContenidoTipoTotal": paqueteContenidoTipoTotal ?? null,
        "PaqueteContenidoManejo": paqueteContenidoManejo ?? null,
        "PaqueteContenidoPeso": paqueteContenidoPeso ?? null,
        "PaqueteContenidoVolumen": paqueteContenidoVolumen ?? null,
        "PaqueteContenidoBalance": paqueteContenidoBalance ?? null,
        "PaqueteFacturaTotal": paqueteFacturaTotal ?? null,
        "PaqueteAsegurado": paqueteAsegurado ?? null,
        "PaqueteFacturaID": paqueteFacturaId ?? null,
        "PaqueteSenderID": paqueteSenderId ?? null,
        "PaqueteSenderNombre": paqueteSenderNombre ?? null,
        "PaqueteSenderDireccion": paqueteSenderDireccion ?? null,
        "PaqueteSenderTel1": paqueteSenderTel1 ?? null,
        "PaqueteSenderIdetificacionTipo": paqueteSenderIdetificacionTipo ?? null,
        "PaqueteSenderIdetificacionID": paqueteSenderIdetificacionId ?? null,
        "PaqueteRecieverID": paqueteRecieverId ?? null,
        "PaqueteRecieverNombre": paqueteRecieverNombre ?? null,
        "PaqueteRecieverDireccion": paqueteRecieverDireccion ?? null,
        "PaqueteRecieverTel1": paqueteRecieverTel1 ?? null,
        "PaquetePrioridadID": paquetePrioridadId ?? null,
        "PaqueteTrackingEstatusID": paqueteTrackingEstatusId ?? null,
        "PaqueteCiudadID": paqueteCiudadId ?? null,
        "PaqueteCiudadTexto": paqueteCiudadTexto ?? null,
        "PaqueteSenderIdetificacionVence": paqueteSenderIdetificacionVence ?? null,
        "PaqueteEntregado": paqueteEntregado ?? null,
        "PaqueteEntregadoFecha": paqueteEntregadoFecha ?? null,
        "PaqueteEntregadoNombre": paqueteEntregadoNombre ?? null,
        "PaqueteEntregadoUsuarioID": paqueteEntregadoUsuarioId ?? null,
        "PaqueteEntregadoUsuarioNombre": paqueteEntregadoUsuarioNombre ?? null,
        "PaqueteEntregadoFirma": paqueteEntregadoFirma ?? null,
        "CurrencyID": currencyId ?? null,
        "PaqueteIdTemporal": paqueteIdTemporal ?? null,
      };
}
