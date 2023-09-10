import 'package:blogger_app/models/role.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  User({
    required this.username,
    required this.password,
    this.role = Role.user,
  });

  String username;
  String password;
  Role role;

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'role': role == Role.admin ? 0 : 1,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] ?? '',
        password: json['password'] ?? '',
        role: (json['role'] ?? 1) == 0 ? Role.admin : Role.user,
      );
}
