import 'package:evently/core/constants/font_constants.dart';
import 'package:evently/core/helper/gap.dart';
import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:evently/src/presentations/create_events/create_event_state.dart';
import 'package:flutter/material.dart';
import 'package:evently/shared/widgets/decoration/text_field_decoration.dart';
import 'package:evently/shared/widgets/form_field_title.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class CreateEventForm extends StatelessWidget {
  const CreateEventForm({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Consumer<CreateEventState>(
      builder: (context, state, _) {
        return Form(
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
                        controller: state.eventTitleController,
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
                        controller: state.targetAudienceController,
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

              // Description
              TextFieldFormat(
                textFieldName: "Description",
                textFormField: TextFormField(
                  controller: state.descriptionController,
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

              // Host Name & Date
              Row(
                children: [
                  Expanded(
                    child: TextFieldFormat(
                      textFieldName: "Host Name",
                      textFormField: TextFormField(
                        controller: state.hostNameController,
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
                        controller: state.eventDateController,
                        decoration: TextFormDecoration(context).decoration(
                          prefixIcon: Icons.calendar_month,
                          hintText: "Event to go..",
                          errorText: null,
                        ),
                        onTap:()=> state.pickEventDate(context),
                      ),
                    ),
                  ),
                ],
              ),
              VerticalGap.xs,

              // Time & Location
              Row(
                children: [
                  Expanded(
                    child: TextFieldFormat(
                      textFieldName: "Event Time",
                      textFormField: TextFormField(
                        controller: state.eventTimeController,
                        decoration: TextFormDecoration(context).decoration(
                          prefixIcon: Icons.timelapse,
                          hintText: "Time",
                          errorText: null,
                        ),
                        onTap: ()=> state.pickEventTime(context),
                      ),
                    ),
                  ),
                  HorizontalGap.xl,
                  Expanded(
                    child: TextFieldFormat(
                      textFieldName: "Location",
                      textFormField: TextFormField(
                        controller: state.locationController,
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

              // Image Picker Placeholder (not wired yet)
              GestureDetector(
                onTap: () {
                  state.takeSnapshot();
                },
                child: Column(
                  children: [
                    Text("Pick Banner Image",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    VerticalGap.xs,
                    Container(
                      height: height * 0.2,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade300,
                      ),
                      child: state.imgFile != null? 
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10.0),
                          child: Image.file(
                            state.imgFile!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ):
                      
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                          VerticalGap.xs,
                          Text("Upload Image"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Confirm Button
              VerticalGap.s,
              InkWell(
                onTap: ()  {
                  final result =  state.submitEvent();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event Successfully added")));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.purpleAccent.shade100,
                  ),
                  child: Text("Confirm", style: AppFonts.buttonText),
                ),
              ),
              VerticalGap.xs,
            ],
          ),
        );
      },
    );
  }
}
