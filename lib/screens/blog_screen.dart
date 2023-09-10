import 'package:blogger_app/components/dialogs.dart';
import 'package:blogger_app/components/my_drawer.dart';
import 'package:blogger_app/models/blog.dart';
import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/utils/storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key, this.blog});

  static const String routeName = '/blog';
  final Blog? blog;

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final TextEditingController _titleInputController = TextEditingController();
  final TextEditingController _contentInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleInputController.text = widget.blog?.title ?? '';
    _contentInputController.text = widget.blog?.content.join('\n') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var isEdit = widget.blog != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'blog_edit'.tr() : 'blog_create'.tr()),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
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
    var isEdit = widget.blog != null;

    if (_titleInputController.text.isEmpty || _contentInputController.text.isEmpty) {
      Dialogs.openAlertDialog(context: context, message: 'title_and_content_are_required'.tr());
    } else {
      var title = _titleInputController.text;
      var content = _contentInputController.text.split('\n');
      if (isEdit) {
        if (widget.blog != null) {
          var blog = Blog(
            content: widget.blog!.content,
            createdBy: widget.blog!.createdBy,
            owner: widget.blog!.owner,
            title: widget.blog!.title,
          );
          blog.title = title;
          blog.content = content;
          // TODO
          await Storage.updateBlog(newBlog: blog, oldBlog: widget.blog!);
        }
      } else {
        var newBlog = Blog(title: title, content: content, createdBy: user.username, owner: user.username);
        await Storage.saveBlog(newBlog);
      }
      if (mounted) Navigator.pop(context, true);
    }
  }
}
