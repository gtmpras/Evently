import 'package:evently/pages/create_events_page.dart';
import 'package:evently/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:evently/screens/home_screen.dart';
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
