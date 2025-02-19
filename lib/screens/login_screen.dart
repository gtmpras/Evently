import 'package:evently/constants/font_constants.dart';
import 'package:evently/constants/route_constants.dart';
import 'package:evently/helper/gap.dart';
import 'package:evently/widgets/button_widget.dart';
import 'package:evently/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Evently",
                style: AppFonts.heading2xL.copyWith(color: Colors.white),
              ),
              VerticalGap.exl,

              Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: customCardWidget(
                  child: Column(
                    children: [
                      Text('Login Using', style: AppFonts.heading.copyWith(color: Colors.black)),
                      VerticalGap.xl,

                      // Google Login Button
                      customElevatedButton(
                        onPressed: () {
                          // Google Login logic
                          context.pushNamed(AppRoutes.home);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/google.png', height: 30),
                            HorizontalGap.xl,
                            Text("Google", style: AppFonts.subheading.copyWith(color: Colors.red)),
                          ],
                        ),
                      ),
                      VerticalGap.xl,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
