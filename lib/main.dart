import 'package:blogger_app/models/blog.dart';
import 'package:blogger_app/models/role.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/screens/blog_create_screen.dart';
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
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
        BlogCreateScreen.routeName:(context) => const BlogCreateScreen(),
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

  var blogs = await Storage.getBlogs();
  if (blogs.isEmpty) {
    blogs.addAll([
      Blog(
        title: 'GPU Prices Are Dropping: GPUs Are Now Affordable In 2023',
        content: [
          'Finally, the good news is on the way this year for gamers looking to upgrade their GPU. After a few years of crazy graphics card prices, GPU pricing has finally dropped this year and is expected to sell at the market\'s normal retail price. If you want to upgrade your PC or buy a good GPU for your new PC, this year may be the best time to do so. However, there are several important concerns that you must be aware of in order to purchase a GPU at the right time for the best buy.',
          'So, what are the reasons behind the decline in GPU pricing, and what is the current state of the graphics card market? Here\'s all you need to know about GPU pricing dropping in 2023:',
        ],
        createdBy: 'tesztferenc',
        owner: 'tesztferenc',
      ),
    ]);
    for (var blog in blogs) {
      await Storage.saveBlog(blog);
    }
  }
}
