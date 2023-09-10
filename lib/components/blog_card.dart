import 'package:blogger_app/models/blog.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/screens/blog_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
    required this.delete,
    required this.edit,
  });

  final Blog blog;
  final void Function() delete;
  final void Function() edit;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogView(blog: blog),
          ),
        ),
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                blog.title,
                style:
                    TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      blog.content.join('\n'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (user.hasAdminRight || blog.owner == user.username)
                    IconButton(
                      onPressed: edit,
                      icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                    ),
                  if (user.hasAdminRight)
                    IconButton(
                      onPressed: delete,
                      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.primary),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
