import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/features/account/widgets/single_product.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/features/order/order_details_screen.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/order-screen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  bool flag = true;
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null && flag
        ? const Loader()
        : (orders!.isEmpty)
            ? const Center(
                child: Text("No Orders Available"),
              )
            : GridView.builder(
                itemCount: orders!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final orderData = orders![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        OrderDetailScreen.routeName,
                        arguments: orderData,
                      );
                    },
                    child: SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: orderData.products[0].images[0],
                      ),
                    ),
                  );
                },
              );
  }
}
