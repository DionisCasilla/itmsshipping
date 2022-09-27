import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  delPrefs() async {
    this.setUserId = "";
    this.setlistaEnviosPendiente = [];
  }

  get userId {
    return _prefs.getString('userId');
  }

  set setUserId(String userId) {
    _prefs.setString("userId", userId);
  }

  get listaEnviosPendiente {
    return _prefs.getStringList("listaEnviosPendiente") ?? [];
  }

  set setlistaEnviosPendiente(List<String> value) {
    _prefs.setStringList("listaEnviosPendiente", value);
  }
}
