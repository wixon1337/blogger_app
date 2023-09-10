import 'package:blogger_app/models/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        onTap: () => debugPrint('onTap'), // TODO
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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                  ),
                  IconButton(
                    onPressed: () {},
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
