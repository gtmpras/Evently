import 'package:evently/core/constants/font_constants.dart';
import 'package:evently/core/helper/gap.dart';
import 'package:evently/core/routing/route_constants.dart';
import 'package:evently/shared/widgets/bottom_navigation_bar.dart';
import 'package:evently/src/partners/services/auth_services.dart';
import 'package:evently/src/presentations/widgets/create_event_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Evently",
          style: AppFonts.headingL.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
          child: Column(
            children: [
              _buildWelcomeBanner(),
              VerticalGap.m,
              _buildDescriptionSection(),
              VerticalGap.xxs,
              Text("Platform Stats", style: AppFonts.heading),
              VerticalGap.xxs,
              _buildGridView(),
            ],
          ),
        ),
      ),

      // 👇 bottom navigation bar instead of button row
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);

          switch (index) {
            case 0:
              context.push('/myEvent');
              break;
            case 1:
              context.push('/findEvent');
              break;
            case 2:
              _buildCreateEvents();
              break;
            case 3:
              _handleSignOut(context);
              break;
          }
        },
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to Evently 👋",
            style: AppFonts.heading.copyWith(color: Colors.white),
          ),
          VerticalGap.xl,
          Text(
            "Plan, manage, and create events effortlessly.",
            style: AppFonts.subheading.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  _buildCreateEvents() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (_) => Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const SingleChildScrollView(child: CreateEventForm()),
          ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text("Experience hassle-free Events", style: AppFonts.heading),
          VerticalGap.xs,
          Text(
            "Welcome to Evently, your all-in-one event management solution designed to simplify planning and execution...",
            style: AppFonts.bodyText,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    final List<String> imagePaths = [
      "images/download.png",
      "images/profile.png",
      "images/headphone.png",
      "images/favoriteseller.png",
    ];
    final List<String> downloadCounts = ["2.5K", "1.5K", "82", "40"];
    final List<String> downloadLabels = [
      "Downloads",
      "Users",
      "Files",
      "Places",
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePaths[index],
                height: 35,
                color: Colors.deepPurple,
              ),
              VerticalGap.xs,
              Text(downloadCounts[index], style: AppFonts.heading),
              Text(downloadLabels[index], style: AppFonts.subheading),
            ],
          ),
        );
      },
    );
  }
}

_handleSignOut(dynamic context) async {
  try {
    await AuthService().signOut(context);
    print("Signed out successfully");
    context.go(AppRoutes.login);
  } catch (e) {
    print("Error while sign-out $e");
  }
}
