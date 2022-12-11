import 'package:e_commerce_app/features/account/screen/accountscreen.dart';
import 'package:e_commerce_app/features/cart/screens/cart_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  static const routeName = "/bottombar";

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  int _currentIndex = 0;

  List<Widget> tabs = [
    const HomeScreen(),
    AccountScreen(),
    const CartScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: tabs[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
            () => {_currentIndex = index},
          )
        },
        currentIndex: _currentIndex,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_off_outlined), label: "Account"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Cart")
        ],
      ),
    );
  }
}
