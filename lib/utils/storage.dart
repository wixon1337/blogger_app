import 'dart:convert';

import 'package:blogger_app/models/blog.dart';
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

  static Future<List<Blog>> getBlogs() async {
    await Future.delayed(const Duration(seconds: 1));
    var prefs = await SharedPreferences.getInstance();
    var blogs = prefs.getStringList('blogs');
    return blogs?.map((e) => Blog.fromJson(jsonDecode(e))).toList() ?? [];
  }

  static Future<void> saveBlog(Blog blog) async {
    var prefs = await SharedPreferences.getInstance();
    var blogs = prefs.getStringList('blogs');
    blogs ??= [];
    var encodedBlog = jsonEncode(blog.toJson());
    blogs.add(encodedBlog);
    prefs.setStringList('blogs', blogs);
  }
}
