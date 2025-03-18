import 'dart:io';
import 'package:evently/core/constants/font_constants.dart';
import 'package:evently/core/helper/gap.dart';
import 'package:evently/src/partners/models/evently_model.dart';
import 'package:evently/src/partners/services/auth_services.dart';
import 'package:evently/core/widgets/button_widget.dart';
import 'package:evently/core/widgets/card_widget.dart';
import 'package:evently/core/widgets/textformfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController targetAudienceController =TextEditingController();
  final TextEditingController numberOfAudienceController =TextEditingController();
  final TextEditingController hostNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();

  @override
  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    targetAudienceController.dispose();
    numberOfAudienceController.dispose();
    hostNameController.dispose();
    eventDateController.dispose();
    eventLocationController.dispose();
    super.dispose();
  }

  File? bannerPhoto;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        bannerPhoto = File(pickedImage.path);
      } else {
        print("No image is picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String userUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Event",
          style: AppFonts.heading1xL.copyWith(color: Colors.red),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Event Name"),
              customTextFormField(eventNameController, TextInputType.text),

              _buildSectionTitle("Description"),
              customTextFormField(descriptionController, TextInputType.text),
              Text(
                "Write a few sentences about your event",
                style: AppFonts.subheading,
              ),

              _buildSectionTitle("Banner Photo"),
              SizedBox(
                width: double.infinity,
                child: customCardWidget(
                  child:
                      bannerPhoto == null
                          ? Column(
                            children: [
                              Image.asset(
                                "images/image.png",
                                height: 50,
                                color: Colors.grey,
                              ),
                              VerticalGap.s,
                              Text(
                                "Banner of Event:",
                                style: AppFonts.bodyheading,
                              ),
                              VerticalGap.s,
                              customElevatedButton(
                                onPressed: () {
                                  getImage();
                                  // Pick file from gallery
                                },
                                child: Text(
                                  "Choose File",
                                  style: AppFonts.buttonText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )
                          : Image.file(bannerPhoto!, fit: BoxFit.fill),
                ),
              ),

              Divider(height: 50),
              _buildSectionTitle("Event Information"),
              Text(
                "Give some specific information about your upcoming event",
                style: AppFonts.subheading,
              ),

              _buildSectionTitle("Target Audience"),
              customTextFormField(targetAudienceController, TextInputType.text),

              _buildSectionTitle("Expected Number of Audience"),
              customTextFormField(
                numberOfAudienceController,
                TextInputType.number,
              ),

              Divider(height: 50),
              _buildSectionTitle("Event Contact"),
              Text(
                "Give some information about event host",
                style: AppFonts.subheading,
              ),

              _buildSectionTitle("Host Name"),
              customTextFormField(hostNameController, TextInputType.text),

              _buildSectionTitle("Event Date"),
              customDatePicker(eventDateController, context),

              _buildSectionTitle("Event Location"),
              customTextFormField(eventLocationController, TextInputType.text),

              Divider(),
              Center(
                child: customElevatedButton(
                  onPressed: () async {
                    DateTime eventDate = DateTime.parse(
                      eventDateController.text,
                    );
                    ActiveEvents event = ActiveEvents(
                      docId: userUid,
                      eventName: eventNameController.text,
                      eventDesc: descriptionController.text,
                      location: eventLocationController.text,
                      bannerPhoto:
                          "bannerPhoto", // You will replace this with actual image upload later
                      hostName: hostNameController.text,
                      eventDate: eventDate,
                    );

                    // Save event to Firestore
                    try {
                      await AuthService().addActiveEvent(event);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Event Created Successfully")),
                      );
                    } catch (e) {
                      // Handle any errors that occur when adding event
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error creating event")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 5,
                  ),
                  child: Text("Save", style: AppFonts.buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title, style: AppFonts.bodyheading), VerticalGap.m],
    );
  }
}
