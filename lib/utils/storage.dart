import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> saveUser() async {
    var prefs = await SharedPreferences.getInstance();
  }
}