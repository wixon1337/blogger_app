import 'dart:convert';

import 'package:blogger_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static Future<List<User>> getUsers() async {
    var prefs = await SharedPreferences.getInstance();
    var users = prefs.getStringList('users');
    return users?.map((e) => User.fromJson(jsonDecode(e))).toList() ?? [];
  }

  static Future<void> saveUser(User user) async {
    var prefs = await SharedPreferences.getInstance();
    var users = prefs.getStringList('users');
    users ??= [];
    var encodedUser = jsonEncode(user.toJson());
    users.add(encodedUser);
    prefs.setStringList('users', users);
  }
}
