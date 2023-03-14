import 'package:e_commerce_app/features/admin/screens/admin_screen.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:e_commerce_app/common/widgets/botom_bar.dart';
import 'package:e_commerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/globalvariables.dart';
import 'provider/user_provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => UserProvider()))
  ], child: const EcommerceApp()));
}

class EcommerceApp extends StatefulWidget {
  const EcommerceApp({super.key});

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == "user"
              ? BottomBar(
                  cartlength:
                      Provider.of<UserProvider>(context).user.cart.length,
                )
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
