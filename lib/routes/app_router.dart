import 'package:evently/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:evently/screens/home_page.dart';
import 'package:evently/screens/splash_screen.dart';
import 'package:evently/constants/route_constants.dart';

//AppRouter
class AppRouter {
  final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: [

      //Home Screen
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),

      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

       // Splash Screen
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

    ],
  );

  //Router Getter
  GoRouter get router => _router;
}
