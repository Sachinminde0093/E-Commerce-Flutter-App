import 'package:e_commerce_app/constants/globalvariables.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../address/screens/address_screen.dart';
import '../../home/screens/searchscreen.dart';
import '../../home/widgets/addressbar.dart';
import '../widgets/cart_product.dart';
import '../widgets/cart_subtotal.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart_screen";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  int sum = 10;

  void navigateToAddress(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const AddressBar(),
          const CartSubtotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'Proceed to Buy ', //(${user.cart.length} items)',
              // ignore: unnecessary_null_comparison
              onTap: () => (user.cart.isEmpty) ? null : navigateToAddress(sum),
              //color: Colors.yellow[600],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5),
          // ignore: unnecessary_null_comparison
          (user.cart == null)
              ? const Text("Cart is empty")
              : Expanded(
                  child: ListView.builder(
                    itemCount: user.cart.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CartProduct(
                        index: index,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
