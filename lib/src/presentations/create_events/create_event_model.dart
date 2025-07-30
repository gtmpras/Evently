// final String tableEvents = 'events';

// class EventFields{
//   static final List<String> values = [
//     id, eventTitle, targetAudience, description, hostName, eventDate, eventTime, location, bannerImg
//   ];

//   static final String id = '_id';
//   static final String eventTitle = 'eventtitle';
//   static final String targetAudience = 'targetAudience';
//   static final String description = 'description';
//   static final String hostName = 'hostName';
//   static final String eventDate = 'eventDate';
//   static final String eventTime = 'eventTime';
//   static final String location = 'location';
//   static final String bannerImg = 'bannerImg';
// }

// class Event {
//   final int? id;
//   final String eventTitle;
//   final String targetAudience;
//   final String description;
//   final String hostName;
//   final DateTime eventDate;
//   final DateTime eventTime;
//   final String location;
//   final String bannerImg;

//   const Event({
//     this.id,
//     required this.eventTitle,
//     required this.targetAudience,
//     required this.description,
//     required this.hostName,
//     required this.eventDate,
//     required this.eventTime,
//     required this.location,
//     required this.bannerImg
//   });

//   Event copy({
//     int? id,
//     String? eventTitle,
//     String? targetAudience,
//     String? description,
//     String? hostName,
//     DateTime? eventDate,
//     DateTime? eventTime,
//     String? location,
//     String? bannerImg
//   })=> 
//   Event(
//     id: id?? this.id,
//     eventTitle: eventTitle ?? this.eventTitle,
//     targetAudience: targetAudience ?? this.targetAudience, 
//     description: description?? this.description, 
//     hostName: hostName?? this.hostName, 
//     eventDate: eventDate?? this.eventDate, 
//     eventTime: eventTime?? this.eventTime, 
//     location: location?? this.location, 
//     bannerImg: bannerImg?? this.bannerImg);

//   static Event fromJson(Map<String, Object?> json) => Event(
//     id: json[EventFields.id] as int?,
//     eventTitle: json[EventFields.eventTitle] as String,
//     targetAudience: json[EventFields.targetAudience] as String,
//     description: json[EventFields.description] as String,
//     hostName: json[EventFields.hostName] as String,
//     eventDate: json[EventFields.eventDate] as DateTime,
//     eventTime: json[EventFields.eventTime] as DateTime,
//     location: json[EventFields.location] as String,
//     bannerImg: json[EventFields.bannerImg] as String
//   );

//   Map<String, Object?> toJson()=> {
//     EventFields.id: id,
//     EventFields.eventTitle: eventTitle,
//     EventFields.targetAudience: targetAudience,
//     EventFields.description: description,
//     EventFields.hostName: hostName,
//     EventFields.eventDate: eventDate,
//     EventFields.eventTime: eventTime,
//     EventFields.location:location,
//     EventFields.bannerImg: bannerImg
//   };
// }

final String tableEvents = 'events';

class EventFields {
  static final List<String> values = [
    id,
    eventTitle,
    targetAudience,
    description,
    hostName,
    eventDate,
    eventTime,
    location,
  ];

  static final String id = '_id';
  static final String eventTitle = 'eventtitle';
  static final String targetAudience = 'targetAudience';
  static final String description = 'description';
  static final String hostName = 'hostName';
  static final String eventDate = 'eventDate';
  static final String eventTime = 'eventTime';
  static final String location = 'location';
}

class Event {
  final int? id;
  final String eventTitle;
  final String targetAudience;
  final String description;
  final String hostName;
  final DateTime eventDate;
  final DateTime eventTime;
  final String location;

  const Event({
    this.id,
    required this.eventTitle,
    required this.targetAudience,
    required this.description,
    required this.hostName,
    required this.eventDate,
    required this.eventTime,
    required this.location,
  });

  Event copy({
    int? id,
    String? eventTitle,
    String? targetAudience,
    String? description,
    String? hostName,
    DateTime? eventDate,
    DateTime? eventTime,
    String? location,
  }) =>
      Event(
        id: id ?? this.id,
        eventTitle: eventTitle ?? this.eventTitle,
        targetAudience: targetAudience ?? this.targetAudience,
        description: description ?? this.description,
        hostName: hostName ?? this.hostName,
        eventDate: eventDate ?? this.eventDate,
        eventTime: eventTime ?? this.eventTime,
        location: location ?? this.location,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[EventFields.id] as int?,
        eventTitle: json[EventFields.eventTitle] as String,
        targetAudience: json[EventFields.targetAudience] as String,
        description: json[EventFields.description] as String,
        hostName: json[EventFields.hostName] as String,
        eventDate: DateTime.parse(json[EventFields.eventDate] as String),
        eventTime: DateTime.parse(json[EventFields.eventTime] as String),
        location: json[EventFields.location] as String,
      );

  Map<String, Object?> toJson() => {
        EventFields.id: id,
        EventFields.eventTitle: eventTitle,
        EventFields.targetAudience: targetAudience,
        EventFields.description: description,
        EventFields.hostName: hostName,
        EventFields.eventDate: eventDate.toIso8601String(),
        EventFields.eventTime: eventTime.toIso8601String(),
        EventFields.location: location,
      };
}
