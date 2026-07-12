import 'package:flutter/material.dart';

import '../core/router/app_router.dart';
import '../core/theme/theme.dart';

class CareerPilotApp extends StatelessWidget {
  const CareerPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CareerPilot AI',
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}