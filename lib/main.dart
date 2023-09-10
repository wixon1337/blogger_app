import 'package:blogger_app/models/blog.dart';
import 'package:blogger_app/models/role.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/screens/blog_screen.dart';
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
        BlogScreen.routeName: (context) => const BlogScreen(),
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
      Blog(
        title: 'Top 5 BEST VR Headsets Under Rs. 5000 in India for 2023',
        content: [
          'The world is happily evolving toward the metaverse, and virtual reality is becoming increasingly popular. VR headsets are the best way to enjoy virtual or augmented reality. Using a VR headset, you can play games, watch 3D movies, and interact with other people.\nA VR headset that provides an outstanding experience is pricey, however, there are a few VR headsets on the market that provide a very nice experience for as little as Rs. 5000.\nHere’s the list of the top 5 best VR headsets under Rs. 5000 that provides an amazing experience.'
        ],
        createdBy: 'tesztádám',
        owner: 'tesztádám',
      ),
      Blog(
        title: 'How to choose a gaming mouse: A complete buying guide for gaming mouse',
        content: [
          'A good gaming mouse is the key to how well you play games, especially action games, but choosing a good gaming mouse is not an easy task for most people. Most PC gamers buy a gaming mouse either because of its looks or because they trust a specific brand, but a better gaming mouse depends on a number of factors that if you ignore while purchasing a gaming mouse, you may end up disliking your gaming skills or regretting your purchase.'
        ],
        createdBy: 'tesztbálint',
        owner: 'tesztbálint',
      ),
      Blog(
        title: 'Why PUBG: New State failed. What went wrong with PUBG: New State',
        content: [
          'Following a lot of hype, On November 11th, 2021, PUBG: New State was released worldwide. After its initial release, PUBG: New State drew a lot of attention. The game was thought to be a replica of the PC version of PUBG.',
          'Poor optimization',
          'Since optimization is so important for any game on any device, game developers spend a lot of time and effort to improve optimization so that games are compatible with as many devices as possible.',
          'Developers in PUBG are professionals with best-in-class experience, and they put in a lot of effort to improve PUBG: New State\'s optimization. However, there have been numerous complaints that PUBG: New State is not well-optimized and has had multiple crashes and lags since its release. As a result of this, many games stopped attempting to play this game.',
        ],
        createdBy: 'tesztbálint',
        owner: 'tesztbálint',
      ),
    ]);
    for (var blog in blogs) {
      await Storage.saveBlog(blog);
    }
  }
}
