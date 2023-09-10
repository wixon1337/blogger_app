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
                        obscureText: true,
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
                          style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
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
    // TODO
  }
}
