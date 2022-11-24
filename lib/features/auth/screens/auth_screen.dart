import 'dart:convert';

import 'package:e_commerce_app/common/widgets/custom_button.dart';
import 'package:e_commerce_app/common/widgets/custome_TextField.dart';
import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(10.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(children: [
                    CustomeTextField(controller: _nameController, hint: 'Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: _emailController, hint: 'Email'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: _passwordController, hint: 'Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: 'Sign in',
                        onTap: () {
                          signUpUser();
                        })
                  ]),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Sign-In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(10.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(children: [
                    CustomeTextField(
                        controller: _emailController, hint: 'Email'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                        controller: _passwordController, hint: 'Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: 'Sign In',
                        onTap: () {
                          print("object");
                          signInUser();
                        })
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
