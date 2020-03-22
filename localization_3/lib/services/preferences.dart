import 'package:shared_preferences/shared_preferences.dart';

class PrefService {

  PrefService._();
  static final PrefService controller = PrefService._();

  SharedPreferences _preferences;

  initPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _preferences = sharedPreferences;
  }



  bool get visitingState => _preferences.getBool("visitingState") ?? false;

  set visitingState(bool value) => _preferences.setBool("visitingState", value);


  String get currentLang => _preferences.getString("currentLang") ?? "";

  set currentLang(String value) => _preferences.setString("currentLang", value);
}