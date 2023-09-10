import 'package:blogger_app/components/blog_card.dart';
import 'package:blogger_app/components/my_drawer.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/screens/blog_create_screen.dart';
import 'package:blogger_app/utils/storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as User;

    return ChangeNotifierProvider<User>.value(
      value: user,
      builder: (context, child) => Scaffold(
        appBar: AppBar(title: Text('blog_list'.tr()), backgroundColor: Theme.of(context).colorScheme.primary),
        endDrawer: const MyDrawer(),
        body: FutureBuilder(
          future: Storage.getBlogs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var blogs = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80.0),
                itemCount: blogs.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: BlogCard(blog: blogs[index]),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<User>.value(
                  value: user,
                  builder: (context, child) => const BlogCreateScreen(),
                ),
              ),
            );
            if (result) {
              setState(() {});
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
