import 'package:evently/core/constants/font_constants.dart';
import 'package:evently/core/helper/gap.dart';
import 'package:flutter/material.dart';
import 'package:evently/shared/widgets/decoration/text_field_decoration.dart';
import 'package:evently/shared/widgets/form_field_title.dart';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({super.key});

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Form(
      onChanged: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with Event Title & Target Audience
          Row(
            children: [
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Event Title",
                  textFormField: TextFormField(
                    decoration: TextFormDecoration(context).decoration(
                      prefixIcon: Icons.home,
                      hintText: "Enter Event Name",
                      errorText: null,
                    ),
                  ),
                ),
              ),
              HorizontalGap.xl,
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Target Audience",
                  textFormField: TextFormField(
                    decoration: TextFormDecoration(context).decoration(
                      prefixIcon: Icons.people,
                      hintText: "Whom would you target..",
                      errorText: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalGap.xs,

          // Description field
          TextFieldFormat(
            textFieldName: "Description",
            textFormField: TextFormField(
              maxLines: 3,
              decoration: TextFormDecoration(context).decoration(
                prefixIcon: Icons.edit,
                hintText: "Describe your event...",
                errorText: null,
              ),
            ),
          ),
          VerticalGap.xs,

          Divider(),

          // Host Name & Event Date
          Row(
            children: [
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Host Name",
                  textFormField: TextFormField(
                    decoration: TextFormDecoration(context).decoration(
                      prefixIcon: Icons.mic_external_on_rounded,
                      hintText: "Enter Host Name",
                      errorText: null,
                    ),
                  ),
                ),
              ),
              HorizontalGap.xl,
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Event Date",
                  textFormField: TextFormField(
                    decoration: TextFormDecoration(context).decoration(
                      prefixIcon: Icons.calendar_month,
                      hintText: "Event to go..",
                      errorText: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalGap.xs,

          //Time and Location
          Row(
            children: [
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Event Time",
                  textFormField: TextFormField(
                    decoration: TextFormDecoration(context).decoration(
                      prefixIcon: Icons.timelapse,
                      hintText: "Time",
                      errorText: null,
                    ),
                  ),
                ),
              ),
              HorizontalGap.xl,
              Expanded(
                child: TextFieldFormat(
                  textFieldName: "Location",
                  textFormField: TextFormField(
                    decoration: TextFormDecoration(context).decoration(
                      prefixIcon: Icons.location_pin,
                      hintText: "Location",
                      errorText: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalGap.s,
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Text(
                  "Pick Banner Image",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                VerticalGap.xs,
                Container(
                  height: height * 0.2,
                  width: double.infinity,
                  // alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.shade300,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                      VerticalGap.xs,
                      Text("Upload Image"),
                    ],
                  ),
                ),
                VerticalGap.xs,
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.purpleAccent.shade100,
            ),
            child: Text("Confirm", style: AppFonts.buttonText),
          ),
          VerticalGap.xs,
        ],
      ),
    );
  }
}
