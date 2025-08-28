import 'package:evently/shared/widgets/event_card_widget.dart';
import 'package:evently/src/presentations/my_events/my_event_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently/core/constants/font_constants.dart';

class MyEventScreen extends StatelessWidget {


  const MyEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyEventState(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            "My Events",
            style: AppFonts.headingL.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Consumer<MyEventState>(
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
                    onTap: () {
                      // Navigate to event details
                      // context.push('/event/${event.id}');
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
