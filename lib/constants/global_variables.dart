import 'package:flutter/material.dart';

String uri =
    'http://172.23.231.121:3001'; // Updated for new IPv4 address k  phone IP Adress
// String uri = 'http://10.0.2.2:3001'; // Previous address for Android emulator
// String uri = 'http://192.168.1.100:3001'; // Previous IP address

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 15, 182, 85),
      Color.fromARGB(255, 102, 226, 108),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color(0xFF3CB371);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://i.pinimg.com/1200x/8e/2c/f0/8e2cf0721c14133ba1f2d05e09a2f18b.jpg',
    'https://i.pinimg.com/736x/e0/cf/6d/e0cf6d66613c1c4273f5f21b8a22ef13.jpg',
    'https://i.pinimg.com/1200x/55/5c/14/555c149aa04f97edf8b581289f37fb9a.jpg',
    'https://i.pinimg.com/1200x/be/8b/c0/be8bc09f9574e0d4d0efab166abfd657.jpg',
    'https://i.pinimg.com/1200x/77/da/fe/77dafe5d351c60591efa90038913d8ca.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Food',
      'image': 'assets/images/Food.jpg',
    },
    {
      'title': 'Feed',
      'image': 'assets/images/Feed.jpg',
    },
    {
      'title': 'Fiber Crops',
      'image': 'assets/images/Fiber.jpg',
    },
    {
      'title': 'Oil Seeds',
      'image': 'assets/images/OilSeeds.jpg',
    },
    {
      'title': 'Industrial',
      'image': 'assets/images/Industrial.jpg',
    },
  ];
}
