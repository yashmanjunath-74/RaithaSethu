import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(GlobalVariables.radiusLg),
                  boxShadow: GlobalVariables.softShadow,
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(GlobalVariables.radiusLg),
                  child: CarouselSlider(
                    items: GlobalVariables.carouselImages.map((i) {
                      return Builder(
                        builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 180,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 600),
                      autoPlayCurve: Curves.easeInOutCubic,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: GlobalVariables.carouselImages
                    .asMap()
                    .entries
                    .map((entry) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentIndex == entry.key ? 24.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariables.radiusFull),
                      color: currentIndex == entry.key
                          ? GlobalVariables.primaryColor
                          : GlobalVariables.primaryColor.withOpacity(0.2),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
