class EventModel {
  String? docId;
  String? eventName;
  String? eventDesc;
  String? location;
  String? bannerPhoto;
  String? hostName;
  String? eventDate;
  List<ActiveEvents>? activeEvents;
  List<Registration>? registration;

  EventModel({
    this.docId,
    this.eventName,
    this.eventDesc,
    this.location,
    this.bannerPhoto,
    this.hostName,
    this.eventDate,
    this.activeEvents,
    this.registration,
  });

  // From JSON (not used for database operations but useful for API data)
  EventModel.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    eventName = json['eventName'];
    eventDesc = json['eventDesc'];
    location = json['location'];
    bannerPhoto = json['bannerPhoto'];
    hostName = json['hostName'];
    eventDate = json['eventDate'];
    if (json['activeEvents'] != null) {
      activeEvents = <ActiveEvents>[];
      json['activeEvents'].forEach((v) {
        activeEvents!.add(ActiveEvents.fromJson(v));
      });
    }
    if (json['registration'] != null) {
      registration = <Registration>[];
      json['registration'].forEach((v) {
        registration!.add(Registration.fromJson(v));
      });
    }
  }

  // From Map - for database insertions
  EventModel.fromMap(Map<String, dynamic> map) {
    docId = map['docId'];
    eventName = map['eventName'];
    eventDesc = map['eventDesc'];
    location = map['location'];
    bannerPhoto = map['bannerPhoto'];
    hostName = map['hostName'];
    eventDate = map['eventDate'];
    if (map['activeEvents'] != null) {
      activeEvents = <ActiveEvents>[];
      map['activeEvents'].forEach((v) {
        activeEvents!.add(ActiveEvents.fromMap(v));
      });
    }
    if (map['registration'] != null) {
      registration = <Registration>[];
      map['registration'].forEach((v) {
        registration!.add(Registration.fromMap(v));
      });
    }
  }

  // Convert to Map for database insertion
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docId'] = this.docId;
    data['eventName'] = this.eventName;
    data['eventDesc'] = this.eventDesc;
    data['location'] = this.location;
    data['bannerPhoto'] = this.bannerPhoto;
    data['hostName'] = this.hostName;
    data['eventDate'] = this.eventDate;

    if (this.activeEvents != null) {
      data['activeEvents'] =
          this.activeEvents!.map((v) => v.toMap()).toList();
    }

    if (this.registration != null) {
      data['registration'] =
          this.registration!.map((v) => v.toMap()).toList();
    }

    return data;
  }
}

class ActiveEvents {
  String? docId;
  String? eventName;
  String? eventDesc;
  String? location;
  String? bannerPhoto;
  String? hostName;
  String? eventDate;

  ActiveEvents({
    this.docId,
    this.eventName,
    this.eventDesc,
    this.location,
    this.bannerPhoto,
    this.hostName,
    this.eventDate,
  });

  ActiveEvents.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    eventName = json['eventName'];
    eventDesc = json['eventDesc'];
    location = json['location'];
    bannerPhoto = json['bannerPhoto'];
    hostName = json['hostName'];
    eventDate = json['eventDate'];
  }

  ActiveEvents.fromMap(Map<String, dynamic> map) {
    docId = map['docId'];
    eventName = map['eventName'];
    eventDesc = map['eventDesc'];
    location = map['location'];
    bannerPhoto = map['bannerPhoto'];
    hostName = map['hostName'];
    eventDate = map['eventDate'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docId'] = this.docId;
    data['eventName'] = this.eventName;
    data['eventDesc'] = this.eventDesc;
    data['location'] = this.location;
    data['bannerPhoto'] = this.bannerPhoto;
    data['hostName'] = this.hostName;
    data['eventDate'] = this.eventDate;
    return data;
  }
}

class Registration {
  String? eventDocId;
  String? userName;
  String? email;

  Registration({this.eventDocId, this.userName, this.email});

  Registration.fromJson(Map<String, dynamic> json) {
    eventDocId = json['eventDocId'];
    userName = json['userName'];
    email = json['email'];
  }

  Registration.fromMap(Map<String, dynamic> map) {
    eventDocId = map['eventDocId'];
    userName = map['userName'];
    email = map['email'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventDocId'] = this.eventDocId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    return data;
  }
}
