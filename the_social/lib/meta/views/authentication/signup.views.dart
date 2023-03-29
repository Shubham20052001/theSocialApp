import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/core/notifier/authentication.notifier.dart';
import 'package:the_social/core/notifier/utility.notifier.dart';
import 'package:the_social/meta/constants/styles.dart';

import '../../../app/routes/app.routes.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    var utilityNotifier = Provider.of<UtilityNotifier>(context, listen: false);
    var _userimage =
        Provider.of<UtilityNotifier>(context, listen: true).userimage;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Sign Up",
          style: textStyleTitle,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Name",
                      style: textStyle1,
                    ),
                  ),
                  sBox10,
                  TextField(
                    controller: nameController,
                    decoration: textFieldStyle1(hintText: "Enter name"),
                  ),
                  sBox10,
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
                    obscureText: true,
                    decoration: textFieldStyle1(hintText: "Enter password"),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _userimage!.isNotEmpty
                      ? CircleAvatar(
                          radius: 25,
                          child: Image.network(utilityNotifier.userimage!),
                        )
                      : const CircleAvatar(
                          radius: 0,
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 44.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade800,
                          Colors.pinkAccent.shade100
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        utilityNotifier.uploadUserImage(context: context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, elevation: 0),
                      child: Text(
                        'Upload Image',
                        style:
                            textStyle1.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
                    authenticationNotifier.signup(
                      context: context,
                      username: nameController.text,
                      useremail: emailController.text,
                      userpassword: passwordController.text,
                      userimage: utilityNotifier.userimage!,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, elevation: 0),
                  child: Text(
                    'Sign-up',
                    style: textStyle1.copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              sBox10,
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(LoginRoute);
                },
                child: const Text("Already have an account? Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
