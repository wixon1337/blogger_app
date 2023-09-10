import 'dart:convert';

import 'package:blogger_app/models/blog.dart';
import 'package:blogger_app/models/user.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
    await prefs.setStringList('users', users);
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
    await prefs.setStringList('blogs', blogs);
  }

  static Future<void> updateBlog({required Blog oldBlog, required Blog newBlog}) async {
    var prefs = await SharedPreferences.getInstance();
    var blogs = await getBlogs();
    var foundBlog = blogs.firstWhereOrNull((e) => e.title == oldBlog.title && e.content.join() == oldBlog.content.join());
    if (foundBlog != null) {
      blogs.remove(foundBlog);
      blogs.add(newBlog);
      await prefs.setStringList('blogs', blogs.map((e) => jsonEncode(e.toJson())).toList());
    } else {
      debugPrint('Blog update failed. Blog not found');
    }
  }

  static Future<void> deleteBlog(Blog blog) async {
    var prefs = await SharedPreferences.getInstance();
    var blogs = await getBlogs();
    var foundBlog = blogs.firstWhereOrNull((e) => e.title == blog.title && e.content.join() == blog.content.join());
    if (foundBlog != null) {
      blogs.remove(foundBlog);
      await prefs.setStringList('blogs', blogs.map((e) => jsonEncode(e.toJson())).toList());
    } else {
      debugPrint('Blog delete failed. Blog not found');
    }
  }
}
