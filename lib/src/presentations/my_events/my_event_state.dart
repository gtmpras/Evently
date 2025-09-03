import 'package:evently/src/partners/databases/dbHelper.dart';
import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyEventState extends ChangeNotifier {
  List<Event> events = [];
  bool isLoading = true;

  MyEventState() {
    FirebaseAuth.instance.authStateChanges().listen((user){
    fetchEvents();
    });
    
  }

  Future<void> fetchEvents() async {
    isLoading = true;
    notifyListeners();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final db = EventDatabase.instance;
        final allEvents = await db.readUserEvents(user.uid);
        events = allEvents;
      } else {
        events = [];
      }
    } catch (e) {
      events = [];
      debugPrint("Error fetching events: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
