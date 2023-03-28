import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/app/routes/app.routes.dart';

import '../../../core/notifier/authentication.notifier.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    var authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login View"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                authenticationNotifier.login(
                    context: context,
                    email: emailController.text,
                    password: passwordController.text);
              },
              color: Colors.red,
              child: const Text("Login"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(SignUpRoute);
              },
              child: const Text("No account? signup"),
            )
          ],
        ),
      ),
    );
  }
}
