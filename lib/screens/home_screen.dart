import 'package:evently/constants/font_constants.dart';
import 'package:evently/constants/route_constants.dart';
import 'package:evently/helper/gap.dart';
import 'package:evently/widgets/button_widget.dart';
import 'package:evently/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Evently", style: AppFonts.headingL),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              _buildButtonRow(),
              VerticalGap.exl,
              _buildDescriptionSection(),
              VerticalGap.xxl,
              _buildGridView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          customElevatedButton(
            onPressed: () {},
            child: Text(
              "My Events",
              style: AppFonts.buttonText.copyWith(color: Colors.black),
            ),
          ),
          HorizontalGap.xs,
          customElevatedButton(
            onPressed: () {},
            child: Text(
              "Find Events",
              style: AppFonts.buttonText.copyWith(color: Colors.black),
            ),
          ),
          HorizontalGap.xs,
          customElevatedButton(
            onPressed: () {
              context.push(AppRoutes.createEventPage);
            },
            child: Text(
              "Create Events",
              style: AppFonts.buttonText.copyWith(color: Colors.black),
            ),
          ),
          HorizontalGap.xs,
          customElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: 5,
            ),
            child: Text("Sign Out", style: AppFonts.buttonText),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Experience hassle-free Events", style: AppFonts.headingL),
        VerticalGap.xxl,
        Text(
          "Welcome to Evently, your all-in-one event management solution designed to simplify planning and execution. Whether it's a corporate event, wedding, or social gathering, our intuitive platform helps you manage schedules, send invitations, track RSVPs, and coordinate vendors effortlessly. With a user-friendly interface and smart tools, Evently ensures a seamless experience, allowing you to focus on creating unforgettable moments while we handle the details. Plan with confidence and bring your events to life with Evently!",
          style: AppFonts.bodyText,
          textAlign:
              TextAlign.center, 
        ),
      ],
    );
  }

  Widget _buildGridView() {
    final List<String> imagePaths = [
      "images/download.png",
      "images/profile.png",
      "images/headphone.png",
      "images/favoriteseller.png",
    ];

    final List<String> downloadCounts = [
        "2.5K",
        "1.5K",
        "82",
        "40",
    ];

  final List<String> downloadLabels = [
      "Downloads",
      "Users",
      "Files",
      "Places",
  ];


    return Expanded(
      child: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            width: 100,
            child: customCardWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imagePaths[index],color: Colors.red,),
                  Text(downloadCounts[index],style: AppFonts.headingL,),
                  Text(downloadLabels[index],style: AppFonts.subheading,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
