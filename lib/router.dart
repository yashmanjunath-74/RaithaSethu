import 'package:RaithaSethu/common/widgets/bottom_bar.dart';
import 'package:RaithaSethu/features/address/screens/address_screen.dart';
import 'package:RaithaSethu/features/admin/screen/add_product_screen.dart';
import 'package:RaithaSethu/features/admin/screen/admin_screen.dart';
import 'package:RaithaSethu/features/auth/screens/farmer_auth.dart';
import 'package:RaithaSethu/features/auth/screens/user_auth.dart';
import 'package:RaithaSethu/features/home/screen/category_deals.dart.dart';
import 'package:RaithaSethu/features/home/screen/home_screen.dart';
import 'package:RaithaSethu/features/order_details/screeens/order_detailsScreen.dart';
import 'package:RaithaSethu/features/product_deatails/screen/product_deatails_screen.dart';
import 'package:RaithaSethu/features/search/screens/search_screen.dart';
import 'package:RaithaSethu/models/order.dart';
import 'package:RaithaSethu/models/product_model.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AdminScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());

    case FarmerAuth.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const FarmerAuth());

    case CategoryDeals.routeName:
      var categary = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDeals(categary: categary));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuery: searchQuery));

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());

    case ProductDeatailsScreen.routeName:
      var product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDeatailsScreen(product: product));

    case OrderDetailsscreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsscreen(order: order));

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
                totalamount: totalAmount,
              ));

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Page not found'),
                ),
              ));
  }
}
