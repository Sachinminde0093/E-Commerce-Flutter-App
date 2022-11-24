import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          children: [
            Text(user.toJson()),
            ElevatedButton(
                onPressed: () {
                  authService.getUser(context);
                },
                child: Text("but"))
          ],
        ),
      )),
    );
  }
}
