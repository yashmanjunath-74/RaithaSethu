import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/common/widgets/custom_buttton.dart';
import 'package:amazon_clone/features/admin/screen/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/farmer_auth.dart';
import 'package:amazon_clone/features/auth/screens/user_auth.dart';
import 'package:amazon_clone/providers/farmer_provider.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              // ✅ This is the missing piece
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    /// Header Row
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: screenHeight * 0.06,
                          fit: BoxFit.cover,
                        ),
                        const Spacer(),
                        Text(
                          "Made by YASH",
                          style: TextStyle(
                            fontSize: 18,
                            color: GlobalVariables.secondaryColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Title
                    const Text(
                      "Remove the Middle Man Get Bettr Price from farmer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Image.asset(
                      'assets/images/RaithaSethu.png',
                      fit: BoxFit.fill,
                    ),

                    const SizedBox(height: 30),

                    /// farmer Button
                    CustomButtton(
                      text: "farmer",
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

                    const SizedBox(height: 20),

                    /// Customer Button
                    CustomButtton(
                      text: "Customer",
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

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
