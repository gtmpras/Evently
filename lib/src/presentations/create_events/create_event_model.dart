final String tableEvents = 'events';

class EventFields {
  static final List<String> values = [
    id,
    uid,
    eventTitle,
    targetAudience,
    description,
    hostName,
    eventDate,
    eventTime,
    location,
    bannerImg
  ];

  static const String id = '_id';
  static const String uid = 'uid'; // Firebase UID
  static const String eventTitle = 'eventTitle';
  static const String targetAudience = 'targetAudience';
  static const String description = 'description';
  static const String hostName = 'hostName';
  static const String eventDate = 'eventDate';
  static const String eventTime = 'eventTime';
  static const String location = 'location';
  static const String bannerImg = 'bannerImg';
}

class Event {
  final int? id;
  final String uid; 
  final String eventTitle;
  final String targetAudience;
  final String description;
  final String hostName;
  final DateTime eventDate;
  final DateTime eventTime;
  final String location;
  final String bannerImg;

  const Event({
    this.id,
    required this.uid, 
    required this.eventTitle,
    required this.targetAudience,
    required this.description,
    required this.hostName,
    required this.eventDate,
    required this.eventTime,
    required this.location,
    required this.bannerImg,
  });

  Event copy({
    int? id,
    String? uid,
    String? eventTitle,
    String? targetAudience,
    String? description,
    String? hostName,
    DateTime? eventDate,
    DateTime? eventTime,
    String? location,
    String? bannerImg,
  }) =>
      Event(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        eventTitle: eventTitle ?? this.eventTitle,
        targetAudience: targetAudience ?? this.targetAudience,
        description: description ?? this.description,
        hostName: hostName ?? this.hostName,
        eventDate: eventDate ?? this.eventDate,
        eventTime: eventTime ?? this.eventTime,
        location: location ?? this.location,
        bannerImg: bannerImg ?? this.bannerImg,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[EventFields.id] as int?,
        uid: json[EventFields.uid] as String,
        eventTitle: json[EventFields.eventTitle] as String,
        targetAudience: json[EventFields.targetAudience] as String,
        description: json[EventFields.description] as String,
        hostName: json[EventFields.hostName] as String,
        eventDate: DateTime.parse(json[EventFields.eventDate] as String),
        eventTime: DateTime.parse(json[EventFields.eventTime] as String),
        location: json[EventFields.location] as String,
        bannerImg: json[EventFields.bannerImg] as String,
      );

  Map<String, Object?> toJson() => {
        EventFields.id: id,
        EventFields.uid: uid, // store Firebase UID
        EventFields.eventTitle: eventTitle,
        EventFields.targetAudience: targetAudience,
        EventFields.description: description,
        EventFields.hostName: hostName,
        EventFields.eventDate: eventDate.toIso8601String(),
        EventFields.eventTime: eventTime.toIso8601String(),
        EventFields.location: location,
        EventFields.bannerImg: bannerImg,
      };
}
