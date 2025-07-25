import 'package:flutter/material.dart';
import 'package:evently/shared/widgets/decoration/text_field_decoration.dart';
import 'package:evently/shared/widgets/form_field_title.dart';

class CreateEventForm extends StatelessWidget {
  const CreateEventForm({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(width: 16),
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
          const SizedBox(height: 16),

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
          const SizedBox(height: 16),

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
              const SizedBox(width: 16),
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
          const SizedBox(height: 16),

          // Event Location
          TextFieldFormat(
            textFieldName: "Event Location",
            textFormField: TextFormField(
              decoration: TextFormDecoration(context).decoration(
                prefixIcon: Icons.location_pin,
                hintText: "Location",
                errorText: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
