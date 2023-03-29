import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/app/routes/app.routes.dart';
import 'package:the_social/meta/constants/styles.dart';

import '../../../core/notifier/authentication.notifier.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Login",
          style: textStyleTitle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Email",
                    style: textStyle1,
                  ),
                ),
                sBox10,
                TextField(
                  controller: emailController,
                  decoration: textFieldStyle1(hintText: "Enter email"),
                ),
                sBox10,
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Password",
                    style: textStyle1,
                  ),
                ),
                sBox10,
                TextField(
                  controller: passwordController,
                  decoration: textFieldStyle1(hintText: "Enter password"),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 44.0,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.pinkAccent.shade100],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  authenticationNotifier.login(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                child: Text(
                  'LogIn',
                  style: textStyle1.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(SignUpRoute);
              },
              child: const Text("Create an account? Sign-up"),
            )
          ],
        ),
      ),
    );
  }
}
