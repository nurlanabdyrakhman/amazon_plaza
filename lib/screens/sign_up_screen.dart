import 'dart:developer';

import 'package:amazon_plaza/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/resources/authentication_methots.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethots authenticationMethots = AuthenticationMethots();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
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
                    height: 500,
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
                          'Sign-Up',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        TextFieldWidget(
                          title: 'Name',
                          hintText: 'Enter your name',
                          controller: nameController,
                          obscureText: false,
                        ),
                        TextFieldWidget(
                          title: 'Address',
                          hintText: 'Enter your address',
                          controller: addressController,
                          obscureText: false,
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
                              'Sign-Up',
                              style: TextStyle(
                                  letterSpacing: 0.6, color: Colors.black),
                            ),
                            color: Colors.orange,
                            isLoading: isLoading,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              String output =
                                  await authenticationMethots.signUpUser(
                                      name: nameController.text,
                                      address: addressController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                              setState(() {
                                isLoading = false;
                              });
                              if (output == 'success') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignInScreen(),
                                  ),
                                );
                              } else {
                                // error
                                Utils().showSnackBar(
                                  context: context,
                                  content: output,
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 1,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomMainButton(
                    child: Text(
                      'Back',
                      style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                    ),
                    color: Colors.purple[600]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const SignInScreen()),
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
