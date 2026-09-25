import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/home/widgets/address_box.dart';
import 'package:RaithaSethu/features/home/widgets/carousel_image.dart';
import 'package:RaithaSethu/features/home/widgets/deal_of_the_day.dart';
import 'package:RaithaSethu/features/home/widgets/top_categories.dart';
import 'package:RaithaSethu/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void NavigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(height: 12),
            TopCategories(),
            SizedBox(height: 8),
            CarouselImage(),
            SizedBox(height: 8),
            DealOfTheDay(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
