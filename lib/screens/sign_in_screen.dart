import 'package:amazon_plaza/screens/sign_up_screen.dart';
import 'package:amazon_plaza/utils/constants.dart';
import 'package:amazon_plaza/utils/utils.dart';
import 'package:amazon_plaza/widgets/custom_main_button.dart';
import 'package:amazon_plaza/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/resources/authentication_methots.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethots authenticationMethots = AuthenticationMethots();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.10,
                  ),
                  Container(
                    height: screenSize.height * 0.8,
                    width: screenSize.width * 0.9,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan,
                        width: 4,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign-In',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        TextFieldWidget(
                          title: 'Email',
                          hintText: 'Enter your email',
                          controller: emailController,
                          obscureText: false,
                        ),
                        TextFieldWidget(
                          title: 'Password',
                          hintText: 'Enter your password',
                          controller: passwordController,
                          obscureText: true,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomMainButton(
                            child: Text(
                              'Sign-In',
                              style: TextStyle(
                                  letterSpacing: 0.6, color: Colors.black),
                            ),
                            color: Colors.orange,
                            isLoading: isLoading,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                             // Future.delayed(Duration(seconds: 1));
                              String output =
                                  await authenticationMethots.signInUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                              setState(() {
                                isLoading = false;
                              });
                              if (output == 'success') {
                                //funtions
                              } else {
                                Utils().showSnackBar(
                                    context: context, content: output);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          'New to Amazon?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomMainButton(
                    child: Text(
                      'Create an Amazon Account',
                      style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                    ),
                    color: Colors.purple[600]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => SignUpScreen()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
