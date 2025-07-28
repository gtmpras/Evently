
import 'package:flutter/material.dart';

class CreateEventState with ChangeNotifier{
  CreateEventState();

  late BuildContext _context;
  BuildContext get context => _context;

  set getContext(BuildContext value){
    _context = value;
    init();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set getLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

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
    getLoading = true;
    notifyListeners();
  }
}