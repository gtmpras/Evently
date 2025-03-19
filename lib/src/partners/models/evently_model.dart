class EventModel {
  List<ActiveEvents>? activeEvents;
  List<Registration>? registration;

  EventModel({this.activeEvents, this.registration});

  EventModel.fromJson(Map<String, dynamic> json) {
    if (json['activeEvents'] != null) {
      activeEvents = <ActiveEvents>[];
      json['activeEvents'].forEach((v) {
        activeEvents!.add(new ActiveEvents.fromJson(v));
      });
    }
    if (json['registration'] != null) {
      registration = <Registration>[];
      json['registration'].forEach((v) {
        registration!.add(new Registration.fromJson(v));
      });
    }
  }

  //from Map
  EventModel.fromMap(Map<String, dynamic>map){
    if (map['activeEvents']!= null){
      activeEvents = <ActiveEvents>[];
      map['activeEvents'].forEach((v){
        activeEvents!.add(ActiveEvents.fromJson(v));
      });
    }

    if(map['registration']!= null){
      registration = <Registration>[];
      map['registration'].forEach((v){
        registration!.add(Registration.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activeEvents != null) {
      data['activeEvents'] = this.activeEvents!.map((v) => v.toJson()).toList();
    }
    if (this.registration != null) {
      data['registration'] = this.registration!.map((v) => v.toJson()).toList();
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

  ActiveEvents(
      {this.docId,
      this.eventName,
      this.eventDesc,
      this.location,
      this.bannerPhoto,
      this.hostName,
      this.eventDate});

  ActiveEvents.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    eventName = json['eventName'];
    eventDesc = json['eventDesc'];
    location = json['location'];
    bannerPhoto = json['bannerPhoto'];
    hostName = json['hostName'];
    eventDate = json['eventDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventDocId'] = this.eventDocId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    return data;
  }
}
