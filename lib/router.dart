import 'package:e_commerce_app/common/widgets/botom_bar.dart';
import 'package:e_commerce_app/features/address/screens/address_screen.dart';
import 'package:e_commerce_app/features/admin/screens/add_product_screen.dart';
import 'package:e_commerce_app/features/admin/screens/adminscreen.dart';
import 'package:e_commerce_app/features/admin/screens/posts_screen.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/features/cart/screens/cart_screen.dart';
import 'package:e_commerce_app/features/home/screens/category_deals_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:e_commerce_app/features/order/order_details_screen.dart';
import 'package:e_commerce_app/features/product_details/screens/productdetailscreen.dart';
import 'package:e_commerce_app/features/home/screens/searchscreen.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';

import 'models/order.dart';

Route<dynamic>? generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case BottomBar.routeName:
      int length = routeSettings.arguments as int;

      return MaterialPageRoute(
          builder: (_) => BottomBar(
                cartlength: length,
              ));

    case PostScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const PostScreen(), settings: routeSettings);

    case AddProduct.routeName:
      return MaterialPageRoute(
          builder: (_) => AddProduct(), settings: routeSettings);

    case AdminScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AdminScreen(), settings: routeSettings);

    case CategoryDealsScreen.routeName:
      String category = routeSettings.arguments as String;

      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(
                category: category,
              ),
          settings: routeSettings);

    case SearchScreen.routeName:
      String searchKey = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(searchKey: searchKey),
        settings: routeSettings,
      );

    case ProductDetailsScreen.routeName:
      Product product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          builder: ((context) {
            return ProductDetailsScreen(
              product: product,
            );
          }),
          settings: routeSettings);

    case AddressScreen.routeName:
      String sum = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return AddressScreen(
            totalAmount: sum,
          );
        },
      );
    case OrderDetailScreen.routeName:
      Order order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          builder: ((context) {
            return OrderDetailScreen(order: order);
          }),
          settings: routeSettings);
    case CartScreen.routeName:
      return MaterialPageRoute(
          builder: (context) {
            return const CartScreen();
          },
          settings: routeSettings);

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Page dose not exist!"),
                ),
              ));
  }
}
