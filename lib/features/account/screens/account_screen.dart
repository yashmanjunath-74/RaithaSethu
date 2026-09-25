import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/account/widgets/below_app_bar.dart';
import 'package:RaithaSethu/features/account/widgets/orders.dart';
import 'package:RaithaSethu/features/account/widgets/top_botton.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                      'assets/images/amazon_in.png',
                      width: 80,
                      height: 30,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _AppBarIcon(
                    icon: Icons.notifications_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _AppBarIcon(
                    icon: Icons.search_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            BelowAppBar(),
            SizedBox(height: 16),
            TopBotton(),
            SizedBox(height: 20),
            Orders(),
          ],
        ),
      ),
    );
  }
}

class _AppBarIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _AppBarIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(GlobalVariables.radiusSm),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
