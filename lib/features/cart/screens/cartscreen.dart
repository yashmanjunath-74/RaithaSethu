import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/cart/widgets/cart_product.dart';
import 'package:RaithaSethu/features/cart/widgets/cart_subtotal.dart';
import 'package:RaithaSethu/features/home/widgets/address_box.dart';
import 'package:RaithaSethu/features/search/screens/search_screen.dart';
import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  void NavigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(GlobalVariables.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    onFieldSubmitted: NavigateToSearchScreen,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: GlobalVariables.textLight,
                        size: 22,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 11),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(GlobalVariables.radiusMd),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(GlobalVariables.radiusMd),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search RaithaSethu',
                      hintStyle: TextStyle(
                        color: GlobalVariables.textLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(GlobalVariables.radiusMd),
                ),
                child: const Icon(
                  Icons.mic_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const AddressBox(),
          const Subtotal(),
          const SizedBox(height: 8),
          if (user.cart.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: GlobalVariables.textLight,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: GlobalVariables.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Browse products to add items',
                      style: TextStyle(
                        fontSize: 13,
                        color: GlobalVariables.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index >= user.cart.length) {
                    print('Index out of range: $index');
                    return SizedBox.shrink();
                  }
                  return CartProduct(index: index);
                },
              ),
            ),
        ],
      ),
    );
  }
}
