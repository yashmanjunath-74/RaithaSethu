import 'package:flutter/material.dart';

// Current Wi-Fi IPv4 address for physical phone on same network:
String uri = '';

// Alternative: If connected via USB with "adb reverse tcp:3001 tcp:3001"
// String uri = 'http://127.0.0.1:3001';

// For Android emulator:
// String uri = 'http://10.0.2.2:3001';

class GlobalVariables {
  // ── Premium Color Palette ──
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFF66BB6A);
  static const Color accentGold = Color(0xFFFFB300);
  static const Color surfaceColor = Color(0xFFF5F7F5);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);

  // ── Gradients ──
  static const appBarGradient = LinearGradient(
    colors: [
      Color(0xFF1B5E20),
      Color(0xFF2E7D32),
      Color(0xFF388E3C),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const heroGradient = LinearGradient(
    colors: [
      Color(0xFF1B5E20),
      Color(0xFF2E7D32),
      Color(0xFF43A047),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const cardGradient = LinearGradient(
    colors: [
      Color(0xFFE8F5E9),
      Color(0xFFC8E6C9),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const addressBarGradient = LinearGradient(
    colors: [
      Color(0xFF2E7D32),
      Color(0xFF43A047),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ── Legacy aliases (keep backward compat) ──
  static const secondaryColor = Color(0xFF2E7D32);
  static const backgroundColor = Color(0xFFF5F7F5);
  static const Color greyBackgroundCOlor = Color(0xFFF3F4F6);
  static var selectedNavBarColor = const Color(0xFF1B5E20);
  static const unselectedNavBarColor = Color(0xFF9CA3AF);

  // ── Shadows ──
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ];

  // ── Border Radius ──
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 100.0;

  // ── Spacing ──
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;

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
