import 'package:evently/core/routing/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5, milliseconds: 500),
      () => context.go(AppRoutes.home),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
