import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/account/services/account_services.dart';
import 'package:RaithaSethu/features/admin/screen/analytics_screen.dart';
import 'package:RaithaSethu/features/admin/screen/orders_screen.dart';
import 'package:RaithaSethu/features/admin/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:RaithaSethu/providers/farmer_provider.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;

  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> ListPages = [
    const ProductScreen(),
    const AnalyticsScreen(),
    OrdersScreen(),
  ];

  void initState() {
    super.initState();
    final farmerProvider = Provider.of<FarmerProvider>(context, listen: false);
    print('Farmer ID: ${farmerProvider.farmer.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(GlobalVariables.radiusSm),
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 36,
                      height: 36,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Farmer Dashboard',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Manage your produce',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => AccountServices().logOut(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius:
                        BorderRadius.circular(GlobalVariables.radiusSm),
                  ),
                  child: const Icon(Icons.logout_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
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
                _AdminNavItem(
                  icon: Icons.inventory_2_rounded,
                  label: 'Products',
                  isSelected: _page == 0,
                  onTap: () => updatepage(0),
                ),
                _AdminNavItem(
                  icon: Icons.analytics_rounded,
                  label: 'Analytics',
                  isSelected: _page == 1,
                  onTap: () => updatepage(1),
                ),
                _AdminNavItem(
                  icon: Icons.receipt_long_rounded,
                  label: 'Orders',
                  isSelected: _page == 2,
                  onTap: () => updatepage(2),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListPages[_page],
    );
  }
}

class _AdminNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AdminNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? GlobalVariables.primaryColor
                  : GlobalVariables.unselectedNavBarColor,
            ),
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
