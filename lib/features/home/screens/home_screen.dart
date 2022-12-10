import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:e_commerce_app/features/home/screens/searchscreen.dart';
import 'package:e_commerce_app/features/home/widgets/addressbar.dart';
import 'package:e_commerce_app/features/home/widgets/crouselimage.dart';
import 'package:e_commerce_app/features/home/widgets/dealoftheday.dart';
import 'package:e_commerce_app/features/home/widgets/topcategories.dart';
import 'package:e_commerce_app/provider/userprovider.dart';
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

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void showSearchProduct(String search) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: search);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {},
                      child: TextField(
                        onSubmitted: (value) {
                          showSearchProduct(value);
                        },
                        controller: _searchController,
                      )),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const AddressBar(),
            const TopCategories(),
            CarouselImage(),
            DealOfDay(),
          ]),
        ));
  }
}
