import 'dart:developer';
import 'dart:io';

import 'package:evently/src/partners/databases/dbHelper.dart';
import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

    _imgFile = null; 
    notifyListeners();
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

  // Inside CreateEventState class
Future<String> submitEvent() async {
  try {
    final parsedDate = DateFormat("yyyy-MM-dd").parse(eventDateController.text.trim());
    final parsedTime = DateFormat("HH:mm").parse(eventTimeController.text.trim());

    final event = Event(
      eventTitle: eventTitleController.text.trim(),
      targetAudience: targetAudienceController.text.trim(),
      description: descriptionController.text.trim(),
      hostName: hostNameController.text.trim(),
      eventDate: parsedDate,
      eventTime: parsedTime,
      location: locationController.text.trim(),
      bannerImg: bannerImgController.text.trim()
    );

    return await addEvent(event);
  } catch (e) {
    return "Invalid date/time or missing fields";
  }
}


  //For date picker
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

//for time picker
Future<void> pickEventTime(BuildContext context)async{
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.input
    );

if (pickedTime != null){
  final formattedTime = pickedTime.format(context);
  eventTimeController.text = formattedTime;
  notifyListeners();
}
}

//For image picker
File? _imgFile;
File? get imgFile => _imgFile;

void takeSnapshot() async{
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