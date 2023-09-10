import 'package:blogger_app/components/blog_card.dart';
import 'package:blogger_app/components/my_drawer.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/utils/storage.dart';
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
        appBar: AppBar(title: Text('Blogs'), backgroundColor: Theme.of(context).colorScheme.primary),
        endDrawer: const MyDrawer(),
        body: FutureBuilder(
          future: Storage.getBlogs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var blogs = snapshot.data!;
              return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) => BlogCard(blog: blogs[index]),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.create)),
      ),
    );
  }
}
