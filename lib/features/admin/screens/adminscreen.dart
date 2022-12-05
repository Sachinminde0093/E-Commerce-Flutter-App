import 'package:e_commerce_app/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _currntindex = 0;

  List<Widget> tabs = [
    Center(child: Text("S1")),
    Center(child: Text("S2")),
   const PostScreen()
    
  ];

  List<BottomNavigationBarItem> bottomBarItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.analytics_outlined), label: "Analitics"),
    BottomNavigationBarItem(icon: Icon(Icons.inbox_outlined), label: "Orders"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  child: TextField(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: tabs[_currntindex]),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomBarItem,
        currentIndex: _currntindex,
        onTap: (index) {
          _currntindex = index;
          setState(() {});
        },
      ),
    );
  }
}
