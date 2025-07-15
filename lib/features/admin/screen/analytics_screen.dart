import 'package:RaithaSethu/common/widgets/loader.dart';
import 'package:RaithaSethu/features/admin/models/sales.dart';
import 'package:RaithaSethu/features/admin/services/farmer_services.dart';
import 'package:RaithaSethu/features/admin/widgets/category_products_charts.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final FarmerServices farmerServices = FarmerServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getearnings();
  }

  getearnings() async {
    var earningsData = await farmerServices.getEarnings(context);
    totalSales = earningsData['totalEarnings'];
    earnings = earningsData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null || earnings == null
        ? Loader()
        : Column(
            // Wrap Expanded inside Column
            children: [
              Text(
                "Total Sales: $totalSales",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                // Moved Expanded inside Column
                child: CategoryProductsChart(
                  salesData: earnings ?? [],
                ),
              ),
            ],
          );
  }
}
