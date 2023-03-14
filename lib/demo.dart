import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  authService.getUser(context);
                },
                child: const Text("chid 1")),
            ElevatedButton(
                onPressed: () {
                  authService.signInUser(
                      context: context,
                      email: "email@gmail.com",
                      password: "Password@123");
                },
                child: const Text("chid 2")),
            ElevatedButton(
                onPressed: () {
                  authService.signUpUser(
                      context: context,
                      email: "email",
                      password: "password",
                      name: "name");
                },
                child: const Text("chid 3")),
            ElevatedButton(
                onPressed: () {
                  authService.get();
                },
                child: const Text("chid 4")),
            ElevatedButton(onPressed: () {}, child: const Text("chid 5")),
            ElevatedButton(onPressed: () {}, child: const Text("chid 6")),
            ElevatedButton(onPressed: () {}, child: const Text("chid 7")),
            ElevatedButton(onPressed: () {}, child: const Text("chid 8")),
            ElevatedButton(onPressed: () {}, child: const Text("chid 9")),
            ElevatedButton(onPressed: () {}, child: const Text("chid 10")),
            ElevatedButton(onPressed: () {}, child: const Text("chid 11")),
          ],
        ),
      ),
    );
  }
}
