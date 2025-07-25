import 'package:evently/core/constants/font_constants.dart';
import 'package:evently/core/helper/gap.dart';
import 'package:evently/core/routing/route_constants.dart';
import 'package:evently/shared/widgets/decoration/text_field_decoration.dart';
import 'package:evently/shared/widgets/form_field_title.dart';
import 'package:evently/src/partners/services/auth_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeBanner(),
                VerticalGap.l,
                _buildButtonRow(),
                VerticalGap.xs,
                _buildDescriptionSection(),
                VerticalGap.xs,
                Text("Platform Stats", style: AppFonts.heading),
                VerticalGap.xxs,
                _buildGridView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
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

  Widget _buildButtonRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStyledButton("My Events", onPressed: () {}),
          _buildStyledButton("Find Events", onPressed: () {}),
          _buildStyledButton(
            "Create Events",
            onPressed: () => _buildCreateEvents(),
            // () {
            //   context.push(AppRoutes.createEventPage);
            // },
          ),
          _buildStyledButton(
            "Sign Out",
            onPressed: () => _handleSignOut(context),
            isDanger: true,
          ),
        ],
      ),
    );
  }

  _buildCreateEvents() {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => Container(
            padding: EdgeInsets.all(16),
            child: Form(
              onChanged: () {},
              child: Column(
                children: [
                  Expanded(
                    child: TextFieldFormat(
                      textFieldName: "Event Name",
                      textFormField: TextFormField(
                        // controller: eventNameController
                        style: Theme.of(context).textTheme.displaySmall,
                        decoration: TextFormDecoration(context).decoration(
                          hintText: "Enter Event Name",
                          errorText: null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildStyledButton(
    String text, {
    required VoidCallback onPressed,
    bool isDanger = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDanger ? Colors.red : Colors.blue,
          foregroundColor: isDanger ? Colors.blue : Colors.black,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Text(text, style: AppFonts.buttonText),
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
            "Welcome to Evently, your all-in-one event management solution designed to simplify planning and execution. Whether it's a corporate event, wedding, or social gathering, our intuitive platform helps you manage schedules, send invitations, track RSVPs, and coordinate vendors effortlessly.",
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
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                offset: Offset(2, 4),
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
