import 'package:RaithaSethu/common/widgets/loader.dart';
import 'package:RaithaSethu/features/account/widgets/single_product.dart';
import 'package:RaithaSethu/features/admin/services/farmer_services.dart';
import 'package:RaithaSethu/features/order_details/screeens/order_detailsScreen.dart';
import 'package:RaithaSethu/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? ordersList;

  final FarmerServices farmerServices = FarmerServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    ordersList = await farmerServices.fetchOrdersByFarmer(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ordersList == null
        ? const Loader()
        : GridView.builder(
            itemCount: ordersList!.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = ordersList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailsscreen.routeName,
                      arguments: orderData);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderData.products[0].images[0]),
                ),
              );
            });
  }
}
