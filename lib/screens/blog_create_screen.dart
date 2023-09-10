import 'package:blogger_app/components/dialogs.dart';
import 'package:blogger_app/components/my_drawer.dart';
import 'package:blogger_app/models/blog.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/utils/storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogCreateScreen extends StatefulWidget {
  const BlogCreateScreen({super.key});

  static const String routeName = '/blog-create';

  @override
  State<BlogCreateScreen> createState() => _BlogCreateScreenState();
}

class _BlogCreateScreenState extends State<BlogCreateScreen> {
  final TextEditingController _titleInputController = TextEditingController();
  final TextEditingController _contentInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('blog_create'.tr()), backgroundColor: Theme.of(context).colorScheme.primary),
      endDrawer: const MyDrawer(),
      body: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child:
                  Text('title'.tr(), style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize)),
            ),
            TextField(
              controller: _titleInputController,
              decoration: InputDecoration(
                hintText: 'title_hint_text'.tr(),
                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child:
                  Text('content'.tr(), style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize)),
            ),
            Expanded(
              child: TextField(
                controller: _contentInputController,
                maxLines: 12,
                decoration: InputDecoration(
                  hintText: 'content_hint_text'.tr(),
                  hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _save, child: const Icon(Icons.save)),
    );
  }

  Future<void> _save() async {
    var user = Provider.of<User>(context, listen: false);

    if (_titleInputController.text.isEmpty || _contentInputController.text.isEmpty) {
      Dialogs.openAlertDialog(context: context, message: 'title_and_content_are_required'.tr());
    } else {
      var title = _titleInputController.text;
      var content = _contentInputController.text.split('\n');
      var newBlog = Blog(title: title, content: content, createdBy: user.username, owner: user.username);
      await Storage.saveBlog(newBlog);
      if (mounted) Navigator.pop(context, true);
    }
  }
}
