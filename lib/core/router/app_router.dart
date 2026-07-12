import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/resume_builder/resume_builder_screen.dart';
import '../../features/splash/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),

    GoRoute(
      path: '/resume',
      builder: (context, state) => const ResumeBuilderScreen(),
    ),
  ],
);