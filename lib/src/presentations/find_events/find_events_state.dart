

import 'package:evently/src/partners/databases/dbHelper.dart';
import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FindEventState extends ChangeNotifier {
  List<Event> events = [];
  bool isLoading = true;

  FindEventState() {
    FirebaseAuth.instance.authStateChanges().listen((user){
    fetchOtherUsersEvents();
    });
    
  }
  Future<void> fetchOtherUsersEvents() async {
  isLoading = true;
  notifyListeners();

  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    final db = EventDatabase.instance;

    if (currentUser != null) {
      // fetch all events except those created by current user
      events = await db.readOtherUsersEvents(currentUser.uid);
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
