import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:RaithaSethu/first_screen.dart';
import 'package:RaithaSethu/features/auth/services/auth_service.dart';
import 'package:RaithaSethu/providers/farmer_provider.dart';
import 'package:RaithaSethu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:RaithaSethu/router.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => FarmerProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // authService.getUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RaithaSethu',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: ColorScheme.light(
          primary: GlobalVariables.primaryColor,
          secondary: GlobalVariables.accentColor,
          surface: GlobalVariables.surfaceColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
            borderSide: BorderSide(color: GlobalVariables.dividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
            borderSide: BorderSide(color: GlobalVariables.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
            borderSide: const BorderSide(
                color: GlobalVariables.primaryColor, width: 1.5),
          ),
          hintStyle: TextStyle(
            color: GlobalVariables.textLight,
            fontSize: 14,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
          ),
          color: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        splashFactory: InkSparkle.splashFactory,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const FirstScreen(),
    );
  }
}
