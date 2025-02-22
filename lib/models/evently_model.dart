class EventModel {
  List<ActiveEvent> activeEvents;
  List<Registration> registration;

  EventModel({
    required this.activeEvents,
    required this.registration,
  });
}

class ActiveEvent {
  String docId;
  String eventName;
  String eventDesc;
  String location;
  String bannerPhoto;
  String hostName;
  DateTime eventDate;

  ActiveEvent({
    required this.docId,
    required this.eventName,
    required this.eventDesc,
    required this.location,
    required this.bannerPhoto,
    required this.hostName,
    required this.eventDate,
  });
}

class Registration {
  String eventDocId;
  String userName;
  String email;

  Registration({
    required this.eventDocId,
    required this.userName,
    required this.email,
  });
}
