import 'dart:io';

import 'package:evently/constants/font_constants.dart';
import 'package:evently/helper/gap.dart';
import 'package:evently/widgets/button_widget.dart';
import 'package:evently/widgets/card_widget.dart';
import 'package:evently/widgets/textformfield_widget.dart';
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
  final TextEditingController targetAudienceController = TextEditingController();
  final TextEditingController numberOfAudienceController = TextEditingController();
  final TextEditingController hostNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();


  File? _image;
  final picker = ImagePicker();
  
  Future getImage()async{
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery);

      setState(() {
        if(pickedImage != null){
          _image = File(pickedImage.path);
        }else{
          print("No image is picked");
        }
      });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: _image == null ? Column(
                    children: [
                      Image.asset(
                        "images/image.png",
                        height: 50,
                        color: Colors.grey,
                      ),
                      VerticalGap.s,
                      Text("Banner of Event:", style: AppFonts.bodyheading),
                      VerticalGap.s,
                      customElevatedButton(
                        onPressed: () {
                          getImage();
                          // Pick file from gallery
                        },
                        child: Text(
                          "Choose File",
                          style: AppFonts.buttonText.copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ):Image.file(_image!,fit: BoxFit.fill,),
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
              customTextFormField(numberOfAudienceController, TextInputType.number),

              Divider(height: 50),
              _buildSectionTitle("Event Contact"),
              Text(
                "Give some information about event host",
                style: AppFonts.subheading,
              ),

              _buildSectionTitle("Host Name"),
              customTextFormField(hostNameController, TextInputType.text),

              _buildSectionTitle("Event Date"),
              customTextFormField(eventDateController, TextInputType.datetime),

              _buildSectionTitle("Event Location"),
              customTextFormField(eventLocationController, TextInputType.text),

              Divider(),
              Center(
                child: customElevatedButton(
                  onPressed: () {
                    // Save event logic here
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
      children: [
        Text(title, style: AppFonts.bodyheading),
        VerticalGap.m,
      ],
    );
  }
}
