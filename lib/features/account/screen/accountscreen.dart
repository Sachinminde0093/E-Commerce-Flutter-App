import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/features/account/widgets/belowappbar.dart';
import 'package:e_commerce_app/features/account/widgets/orderlist.dart';
import 'package:e_commerce_app/features/account/widgets/topbuttons.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_button.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text("Ecommerce App"),
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                        ],
                      ))
                ]),
          ),
        ),
      ),
      body: Column(children: const [
        BelowAppBar(),
        TopButtons(),
        OrderList(),
      ]),
    );
  }
}
