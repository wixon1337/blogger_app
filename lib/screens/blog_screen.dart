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
  String _owner = '';
  List<String> usernames = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _init);
  }

  @override
  Widget build(BuildContext context) {
    var isEdit = widget.blog != null;
    var user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'blog_edit'.tr() : 'blog_create'.tr()),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      endDrawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'title'.tr(),
                    style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
                  )
                ],
              ),
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
            SizedBox(
              height: 300.0,
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
            if (user.hasAdminRight && isEdit && usernames.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only( right: 12.0),
                      child: Text(
                        '${'owner'.tr()}:',
                        style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
                      ),
                    ),
                    DropdownButton<String>(
                      value: _owner,
                      borderRadius: BorderRadius.circular(6.0),
                      underline: Container(),
                      focusColor: Colors.green.withOpacity(0.1),
                      onChanged: (String? value) {
                        setState(() {
                          _owner = value!;
                        });
                      },
                      selectedItemBuilder: (context) => usernames
                          .map((e) => Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(e),
                              )))
                          .toList(),
                      items: usernames.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _save, child: const Icon(Icons.save)),
    );
  }

  Future<void> _init() async {
    _titleInputController.text = widget.blog?.title ?? '';
    _contentInputController.text = widget.blog?.content.join('\n') ?? '';

    var user = Provider.of<User>(context, listen: false);
    if (user.hasAdminRight) {
      var users = await Storage.getUsers();
      setState(() {
        usernames = users.map((e) => e.username).toList();
        _owner = widget.blog?.owner ?? '';
      });
    }
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
          blog.owner = _owner;
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
