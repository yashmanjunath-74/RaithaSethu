import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/features/home/screen/category_deals.dart.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void NavigatetoCategaryScreen(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDeals.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: GlobalVariables.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: GlobalVariables.categoryImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => NavigatetoCategaryScreen(
                      context,
                      GlobalVariables.categoryImages[index]['title']!),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                GlobalVariables.radiusMd),
                            border: Border.all(
                              color: GlobalVariables.primaryColor
                                  .withOpacity(0.15),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                GlobalVariables.radiusMd - 1),
                            child: Image.asset(
                              GlobalVariables.categoryImages[index]['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          GlobalVariables.categoryImages[index]['title']!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: GlobalVariables.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
