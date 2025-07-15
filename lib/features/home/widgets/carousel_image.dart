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
        return Column(
          children: [
            CarouselSlider(
              items: GlobalVariables.carouselImages.map((i) {
                return Builder(
                  builder: (BuildContext context) => ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      i,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  GlobalVariables.carouselImages.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == entry.key
                        ? Colors.green
                        : Colors.green.withOpacity(0.3),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
