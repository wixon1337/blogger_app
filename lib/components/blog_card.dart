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
            children: [
              Text(
                blog.title,
                style:
                    TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Image(image: AssetImage('assets/images/speech-balloon-green.png'), height: 120.0),
            ],
          ),
        ),
      ),
    );
  }
}
