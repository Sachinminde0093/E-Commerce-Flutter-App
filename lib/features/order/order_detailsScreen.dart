import 'package:flutter/material.dart';

import '../../models/order.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = "/order-screen";
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
