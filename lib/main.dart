import 'package:blogger_app/models/role.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/screens/home_screen.dart';
import 'package:blogger_app/screens/login_screen.dart';
import 'package:blogger_app/utils/storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await _initData();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('hu')],
      path: 'assets/translations',
      fallbackLocale: const Locale('hu'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogger app',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(95, 252, 150, 1.0),
          brightness: Brightness.light,
        ).copyWith(primary: const Color.fromARGB(255, 16, 151, 23)),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(color: Color.fromARGB(255, 16, 151, 23), width: 1.5, style: BorderStyle.solid),
          ),
          constraints: const BoxConstraints(maxWidth: 300.0, maxHeight: 50.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 5.0,
          ),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}

Future<void> _initData() async {
  var users = await Storage.getUsers();
  if (users.isEmpty) {
    users.addAll([
      User(username: 'admin', password: 'admin1234', role: Role.admin),
      User(username: 'tesztferenc', password: 'user1234'),
      User(username: 'tesztádám', password: 'user1234'),
      User(username: 'tesztbálint', password: 'user1234'),
    ]);
    for (var user in users) {
      await Storage.saveUser(user);
    }
  }
}