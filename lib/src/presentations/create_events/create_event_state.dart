import 'dart:developer';

import 'package:evently/src/partners/databases/dbHelper.dart';
import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:flutter/material.dart';

class CreateEventState with ChangeNotifier {
  late Event event;
  bool _isLoading = false;
  late List<Event> events;
  bool get isLoading => _isLoading;


 //controllers for form fields
  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController targetAudienceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController hostNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController bannerImgController = TextEditingController();

  void initControllers(){
    eventTitleController.text = "";
    targetAudienceController.text = "";
    descriptionController.text = "";
    hostNameController.text = "";
    eventDateController.text = "";
    eventTimeController.text = "";
    locationController.text = "";
    bannerImgController.text = "";
  }

  void disposeControllers(){
    eventTitleController.dispose();
    targetAudienceController.dispose();
    descriptionController.dispose();
    hostNameController.dispose();
    eventDateController.dispose();
    eventTimeController.dispose();
    locationController.dispose();
    bannerImgController.dispose();
  }

  void clearControllers(){
    eventTitleController.clear();
    targetAudienceController.clear();
    descriptionController.clear();
    hostNameController.clear();
    eventDateController.clear();
    eventTimeController.clear();
    locationController.clear();
    bannerImgController.clear();
  }

  init()async{
    initControllers();
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }



  Future refreshEvent(int eventId) async {
    toggleLoading();
    event = (await EventDatabase.instance.readEvent(eventId))!;
    toggleLoading();
    notifyListeners();
  }

  Future deleteEvent(int eventId) async {
    event = (await EventDatabase.instance.readEvent(eventId))!;
    notifyListeners();
  }

  Future readAllEvents() async {
    toggleLoading();
    events = await EventDatabase.instance.readAllEvents();
    toggleLoading();
    notifyListeners();
  }

  Future addEvent(Event event) async {
    try {
      log(" ------------------------------------------------");
      event = await EventDatabase.instance.create(event);
      clearControllers();
      notifyListeners();
      return "Event Created successfully";
    } catch (e) {
      log("------------failed to create event: $e----");
      return "Failed to create event";
    }
  }
}
  // CreateEventState();

  // late BuildContext _context;
  // BuildContext get context => _context;

  // set getContext(BuildContext value){
  //   _context = value;
  //   init();
  // }

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  // set getLoading(bool value){
  //   _isLoading = value;
  //   notifyListeners();
  // }

  //