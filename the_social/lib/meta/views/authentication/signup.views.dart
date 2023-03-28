import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/core/notifier/authentication.notifier.dart';
import 'package:the_social/core/notifier/utility.notifier.dart';

import '../../../app/routes/app.routes.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    var authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    var utilityNotifier = Provider.of<UtilityNotifier>(context, listen: false);
    var _userimage =
        Provider.of<UtilityNotifier>(context, listen: true).userimage;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("SignUp View"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Enter email'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Enter password'),
              ),
              const SizedBox(
                height: 40,
              ),
              MaterialButton(
                onPressed: () {
                  utilityNotifier.uploadUserImage(context: context);
                },
                color: Colors.red,
                child: Text(utilityNotifier.userimage!.isEmpty
                    ? "Upload image"
                    : "Reselect"),
              ),
              _userimage!.isNotEmpty
                  ? Container(
                      width: 100,
                      height: 100,
                      child: Image.network(utilityNotifier.userimage!),
                    )
                  : Container(
                      height: 0,
                    ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  authenticationNotifier.signup(
                      context: context,
                      username: nameController.text,
                      useremail: emailController.text,
                      userpassword: passwordController.text,
                      userimage: utilityNotifier.userimage!);
                },
                color: Colors.red,
                child: const Text("signup"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(LoginRoute);
                },
                child: const Text("Have account? login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
