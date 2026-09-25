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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: _page == 0,
                  onTap: () => updatepage(0),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: 'Account',
                  isSelected: _page == 1,
                  onTap: () => updatepage(1),
                ),
                _NavItem(
                  icon: Icons.shopping_cart_rounded,
                  label: 'Cart',
                  isSelected: _page == 2,
                  onTap: () => updatepage(2),
                  badgeCount: userCartLen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int badgeCount;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(
      icon,
      size: 24,
      color: isSelected
          ? GlobalVariables.primaryColor
          : GlobalVariables.unselectedNavBarColor,
    );

    if (badgeCount > 0) {
      iconWidget = badges.Badge(
        badgeContent: Text(
          badgeCount.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        badgeStyle: const badges.BadgeStyle(
          badgeColor: GlobalVariables.primaryColor,
          padding: EdgeInsets.all(5),
        ),
        child: iconWidget,
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? GlobalVariables.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(GlobalVariables.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: GlobalVariables.primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
