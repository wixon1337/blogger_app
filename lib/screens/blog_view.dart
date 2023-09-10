import 'package:blogger_app/components/my_drawer.dart';
import 'package:blogger_app/models/blog.dart';
import 'package:flutter/material.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key, required this.blog});

  static const String routeName = '/blog-view';
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      endDrawer: const MyDrawer(),
      body: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              blog.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Padding(  
              padding: const EdgeInsets.all(16.0),
              child: Text(blog.content.join('\n')),
            ),
          ],
        ),
      ),
    );
  }
}
