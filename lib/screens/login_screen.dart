import 'package:blogger_app/components/dialogs.dart';
import 'package:blogger_app/screens/home_screen.dart';
import 'package:blogger_app/utils/storage.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameInputController = TextEditingController();
  final TextEditingController _passwordInputController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 150.0,
                width: 200.0,
                child: Image(image: AssetImage('assets/images/speech-balloon-green.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 30.0),
                child: Text(
                  'login'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('username'.tr()),
                    ),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(6.0),
                      child: TextFormField(
                        controller: _usernameInputController,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('password'.tr()),
                    ),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(6.0),
                      child: TextFormField(
                        controller: _passwordInputController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            size: 20.0,
                            color: Colors.black38,
                          ),
                          highlightColor: Theme.of(context).highlightColor,
                        )),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: _login,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: Text(
                          'enter'.tr(),
                          style: TextStyle(fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    var navigatorState = Navigator.of(context);
    var users = await Storage.getUsers();
    var foundUser = users.firstWhereOrNull((element) => element.username == _usernameInputController.text);
    if (foundUser != null && foundUser.password == _passwordInputController.text) {
      navigatorState.pushReplacementNamed(HomeScreen.routeName, arguments: foundUser);
    } else {
      if (mounted) {
        Dialogs.openAlertDialog(
          context: context,
          message: 'wrong_credentials'.tr(),
          title: '${'error'.tr()}!',
        );
      }
    }
  }
}
