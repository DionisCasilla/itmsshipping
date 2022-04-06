import 'package:flutter/cupertino.dart';

class StepperModel {
  StepperModel({required this.titulo, this.subtitulo = "", this.iconData, required this.contenido});

  String titulo;
  String? subtitulo;
  IconData? iconData;
  Widget contenido;
}
