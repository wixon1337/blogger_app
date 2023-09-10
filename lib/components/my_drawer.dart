import 'package:blogger_app/models/user.dart';
import 'package:blogger_app/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 120.0,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                          child: Icon(
                            Icons.account_circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              Provider.of<User>(context, listen: false).username,
                              style: const TextStyle(
                                fontSize: 24.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    style: OutlinedButton.styleFrom(side: BorderSide.none, shape: const RoundedRectangleBorder()),
                    child: Text(
                      'logout'.tr(),
                      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
