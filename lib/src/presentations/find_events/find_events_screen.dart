import 'package:evently/core/constants/font_constants.dart';
import 'package:evently/shared/widgets/event_card_widget.dart';
import 'package:evently/src/presentations/find_events/find_events_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindEventScreen extends StatefulWidget {
  const FindEventScreen({super.key});

  @override
  State<FindEventScreen> createState() => _FindEventScreenState();
}

class _FindEventScreenState extends State<FindEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "My Events",
          style: AppFonts.headingL.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<FindEventState>(
        builder: (context, state, _) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.events.isEmpty) {
            return const Center(child: Text("No events found"));
          } else {
            return ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return EventCard(
                  event: event,
                );
              },
            );
          }
        },
      ),
    );
  }
}
