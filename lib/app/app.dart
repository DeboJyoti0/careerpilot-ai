import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../features/auth/login_screen.dart';
import '../features/splash/splash_screen.dart';

class CareerPilotApp extends StatelessWidget {
  const CareerPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareerPilot AI',
      theme: appTheme,

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}