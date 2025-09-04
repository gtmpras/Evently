import 'package:evently/core/constants/font_constants.dart';
import 'package:evently/core/helper/gap.dart';
import 'package:evently/core/routing/route_constants.dart';
import 'package:evently/shared/widgets/bottom_navigation_bar.dart';
import 'package:evently/shared/widgets/stat_card_widget.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeBanner(),
              VerticalGap.m,
              _buildDescriptionSection(),
              VerticalGap.xxs,
              Text("Platform Stats", style: AppFonts.heading),
              VerticalGap.xxs,
              Expanded(child: SingleChildScrollView(child: _buildGridView()))
            ],
          ),
        ),
      ),

      // bottom navigation bar
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/event_room.PNG'),fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(8),
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
            "Plan, manage, and create \n events effortlessly.",
            style: AppFonts.subheading.copyWith(color: Colors.white),
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
  final List<Color> cardColors = [
    Colors.deepPurple.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.green.shade100,
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: imagePaths.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
    ),
    itemBuilder: (context, index) {

      return StatCard(
        imagePath: imagePaths[index],
        count: downloadCounts[index],
        label: downloadLabels[index],
        color: cardColors[index],
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
