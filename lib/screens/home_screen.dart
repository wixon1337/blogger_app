import 'package:blogger_app/components/blog_card.dart';
import 'package:blogger_app/components/dialogs.dart';
import 'package:blogger_app/components/my_drawer.dart';
import 'package:blogger_app/models/blog.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/screens/blog_screen.dart';
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
                  child: BlogCard(
                    blog: blogs[index],
                    delete: () => _deleteBlog(blogs[index]),
                    edit: () => _editBlog(blogs[index]),
                  ),
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
                  builder: (context, child) => const BlogScreen(),
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

  Future<void> _deleteBlog(Blog blog) async {
    var result = await Dialogs.openAlertDialog(
      context: context,
      title: 'warning'.tr(),
      message: 'delete_desc'.tr(),
      actions: [
        Container(
          width: 100.0,
          height: 70.0,
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
          child: ElevatedButton(
            child: Text(
              'no'.tr(),
            ),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        Container(
          width: 100.0,
          height: 70.0,
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
          child: ElevatedButton(
            child: Text(
              'yes'.tr(),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
      ],
    );
    if (result) {
      await Storage.deleteBlog(blog);
      setState(() {});
    }
  }

  Future<void> _editBlog(Blog blog) async {}
}
