import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/account/screens/account_screen.dart';
import 'package:RaithaSethu/features/auth/services/auth_service.dart';
import 'package:RaithaSethu/features/cart/screens/cartscreen.dart';
import 'package:RaithaSethu/features/home/screen/home_screen.dart';
import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final AuthService authService = AuthService();
  int _page = 0;
  double bottomBarwidth = 48;
  double bottomBarBorderWidth = 5;

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> ListPages = [
    HomeScreen(),
    AccountScreen(),
    Cartscreen(),
  ];

  @override
  void initState() {
    super.initState();
    authService.getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: ListPages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatepage,
        items: [
          // Home
          BottomNavigationBarItem(
              label: '',
              icon: Container(
                width: bottomBarwidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              )
              // Account
              ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarwidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth))),
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          // Cart
          BottomNavigationBarItem(
              label: '',
              icon: badges.Badge(
                badgeContent: Text(
                  userCartLen.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                badgeStyle: badges.BadgeStyle(
                    badgeColor: GlobalVariables.secondaryColor),
                child: Container(
                  width: bottomBarwidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 2
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: bottomBarBorderWidth))),
                  child: const Icon(Icons.shopping_cart_checkout_outlined),
                ),
              ))
        ],
      ),
    );
  }
}
