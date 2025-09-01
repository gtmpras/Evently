import 'dart:developer';
import 'dart:io';

import 'package:evently/src/partners/databases/dbHelper.dart';
import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateEventState with ChangeNotifier {
  late Event event;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Initialize events list
  List<Event> events = [];

  // Controllers for form fields
  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController targetAudienceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController hostNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController bannerImgController = TextEditingController();

  File? _imgFile;
  File? get imgFile => _imgFile;

  // Initialize controllers
  void initControllers() {
    eventTitleController.text = "";
    targetAudienceController.text = "";
    descriptionController.text = "";
    hostNameController.text = "";
    eventDateController.text = "";
    eventTimeController.text = "";
    locationController.text = "";
    bannerImgController.text = "";
  }

  // Dispose controllers
  void disposeControllers() {
    eventTitleController.dispose();
    targetAudienceController.dispose();
    descriptionController.dispose();
    hostNameController.dispose();
    eventDateController.dispose();
    eventTimeController.dispose();
    locationController.dispose();
    bannerImgController.dispose();
  }

  // Clear controllers and image
  void clearControllers() {
    eventTitleController.clear();
    targetAudienceController.clear();
    descriptionController.clear();
    hostNameController.clear();
    eventDateController.clear();
    eventTimeController.clear();
    locationController.clear();
    bannerImgController.clear();

    _imgFile = null;
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // Read all events of current user
  Future readAllEvents() async {
    toggleLoading();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      events = await EventDatabase.instance.readUserEvents(currentUser.uid);
    } else {
      events = [];
    }
    toggleLoading();
    notifyListeners();
  }

  // Add event to DB and list
  Future<String> addEvent(Event event) async {
    try {
      event = await EventDatabase.instance.create(event);
      events.add(event);
      clearControllers();
      notifyListeners();
      return "Event Created successfully";
    } catch (e) {
      log("Failed to create event: $e");
      return "Failed to create event";
    }
  }

  // Submit event with proper date/time parsing
  Future<bool> submitEvent(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return false;

    DateTime parsedDate;
    DateTime parsedTime;

    try {
      parsedDate = DateFormat("yyyy-MM-dd").parse(eventDateController.text.trim());
      parsedTime = DateFormat("HH:mm").parse(eventTimeController.text.trim());
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid date or time format")),
      );
      return false;
    }

    final event = Event(
      uid: currentUser.uid,
      eventTitle: eventTitleController.text.trim(),
      targetAudience: targetAudienceController.text.trim(),
      description: descriptionController.text.trim(),
      hostName: hostNameController.text.trim(),
      eventDate: parsedDate,
      eventTime: parsedTime,
      location: locationController.text.trim(),
      bannerImg: bannerImgController.text.trim(),
    );

    final message = await addEvent(event);
    return message == "Event Created successfully";
  }

  // Date picker
  Future<void> pickEventDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate =
          '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      eventDateController.text = formattedDate;
      notifyListeners();
    }
  }

  // Time picker (24-hour format)
  Future<void> pickEventTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      final formattedTime =
          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      eventTimeController.text = formattedTime;
      notifyListeners();
    }
  }

  // Pick image
  void takeSnapshot() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
    );
    if (img == null) return;

    _imgFile = File(img.path);
    bannerImgController.text = img.path;
    notifyListeners();
  }
}
