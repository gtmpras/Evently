import 'package:evently/src/pages/create_events_page.dart';
import 'package:evently/src/partners/services/auth_check.dart';
import 'package:evently/src/presentations/home_screen.dart';
import 'package:evently/src/presentations/login_screen.dart';
import 'package:evently/src/presentations/my_events/my_event_screen.dart';
import 'package:evently/src/presentations/splash_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:evently/core/routing/route_constants.dart';

//AppRouter
class AppRouter {
  final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.authCheck,
    routes: [
      // AuthCheckScreen
      GoRoute(
        path: AppRoutes.authCheck,
        name: AppRoutes.authCheck,
        builder: (context, state) => const AuthCheck(),
      ),

      //Home Screen
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Login Screen
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // MyEvent Screen
      GoRoute(
        path: AppRoutes.myEvent,
        name: AppRoutes.myEvent,
        builder: (context, state) => const MyEventScreen(),
      ),

      //CreateEvent Page
      GoRoute(
        path: AppRoutes.createEventPage,
        name: AppRoutes.createEventPage,
        builder: (context, state) => const CreateEventPage(),
      ),
    ],
  );

  //Router Getter
  GoRouter get router => _router;
}
