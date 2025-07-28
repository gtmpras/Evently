
class CreateEventModel {
  final int? id;
  final String eventTitle;
  final String targetAudience;
  final String description;
  final String hostName;
  final String eventDate;
  final String eventTime;
  final String location;
  final String bannerImg;

  CreateEventModel({
    this.id,
    required this.targetAudience,
    required this.eventTitle,
    required this.description,
    required this.hostName,
    required this.eventDate,
    required this.eventTime,
    required this.location,
    required this.bannerImg
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'eventTitle': eventTitle,
      'targetAudience': targetAudience,
      'description': description,
      'hostName': hostName,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'location': location,
      'bannerImage':bannerImg
    };
  }

  factory CreateEventModel.fromMap(Map<String, dynamic> map){
    return CreateEventModel(
      id: map['id'],
      eventTitle: map['eventTile'],
      targetAudience: map['targetAudience'],
      description: map['description'], 
      hostName: map['hostName'], 
      eventDate: map['eventDate'], 
      eventTime: map['eventTime'], 
      location: map['location'], 
      bannerImg: map['bannerImg']);
  }
}