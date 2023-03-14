import 'package:e_commerce_app/common/widgets/loader.dart';
import 'package:e_commerce_app/features/admin/models/sales.dart';
import 'package:e_commerce_app/features/admin/widgets/category_products_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../services/admin_services.dart';

class AnalyticsScreen extends StatefulWidget {
  static const String routeName = './analytic-screen';

  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  bool flag = true;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (earnings == null || totalSales == null) && flag
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              children: [
                Text(
                  '\$$totalSales',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: CategoryProductsChart(seriesList: [
                    charts.Series(
                      id: 'Sales',
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning,
                    ),
                  ]),
                )
              ],
            ),
          );
  }
}
