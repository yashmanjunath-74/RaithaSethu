import 'package:RaithaSethu/common/widgets/bottom_bar.dart';
import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/common/widgets/custom_buttton.dart';
import 'package:RaithaSethu/features/admin/screen/admin_screen.dart';
import 'package:RaithaSethu/features/auth/screens/farmer_auth.dart';
import 'package:RaithaSethu/features/auth/screens/user_auth.dart';
import 'package:RaithaSethu/providers/farmer_provider.dart';
import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F7F5), Color(0xFFE8F5E9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    children: [
                      /// Header Row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  GlobalVariables.radiusMd),
                              boxShadow: GlobalVariables.softShadow,
                            ),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: screenHeight * 0.05,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: GlobalVariables.primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariables.radiusFull),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified,
                                    size: 14,
                                    color: GlobalVariables.primaryColor),
                                const SizedBox(width: 4),
                                Text(
                                  "Made by YASH",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: GlobalVariables.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      /// Hero Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: GlobalVariables.heroGradient,
                          borderRadius:
                              BorderRadius.circular(GlobalVariables.radiusXl),
                          boxShadow: [
                            BoxShadow(
                              color: GlobalVariables.primaryColor
                                  .withOpacity(0.3),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "🌾",
                              style: TextStyle(fontSize: 36),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Remove the Middle Man\nGet Better Price from Farmer",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.3,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Direct farm-to-table marketplace",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      /// Main Image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(GlobalVariables.radiusXl),
                          boxShadow: GlobalVariables.cardShadow,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(GlobalVariables.radiusXl),
                          child: Image.asset(
                            'assets/images/RaithaSethu.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      /// Role Selection Cards
                      Row(
                        children: [
                          Expanded(
                            child: _RoleCard(
                              icon: Icons.agriculture_rounded,
                              title: "Farmer",
                              subtitle: "Sell your produce",
                              color: GlobalVariables.primaryColor,
                              onTap: () {
                                final token = Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).user.token;

                                Navigator.pushNamed(
                                  context,
                                  token.isNotEmpty
                                      ? AdminScreen.routeName
                                      : FarmerAuth.routeName,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _RoleCard(
                              icon: Icons.shopping_bag_rounded,
                              title: "Customer",
                              subtitle: "Buy fresh produce",
                              color: GlobalVariables.accentGold,
                              onTap: () {
                                final token = Provider.of<FarmerProvider>(
                                  context,
                                  listen: false,
                                ).farmer.token;

                                Navigator.pushNamed(
                                  context,
                                  token.isNotEmpty
                                      ? BottomBar.routeName
                                      : AuthScreen.routeName,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(GlobalVariables.radiusLg),
          boxShadow: GlobalVariables.softShadow,
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: GlobalVariables.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: GlobalVariables.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius:
                    BorderRadius.circular(GlobalVariables.radiusFull),
              ),
              child: Text(
                "Get Started →",
                style: TextStyle(
                  color: color == GlobalVariables.accentGold
                      ? GlobalVariables.textPrimary
                      : Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
