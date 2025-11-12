import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? userId;
  String? title;
  String? description;
  double? latitude;
  double? longitude;
  String? type;
  Timestamp? dateTime;
  String? city;
  String? country;

  Event({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.latitude,
    this.longitude,
    this.type,
    this.dateTime,
    this.city,
    this.country,
  });

  Event.fromFireStore(Map<String, dynamic>? data) {
    id = data!['id'];
    userId = data['userId'];
    title = data['title'];
    description = data['description'];
    latitude = data['latitude'];
    longitude = data['longitude'];
    type = data['type'];
    dateTime = data['dateTime'];
    city = data['city']?? "unKnown";
    country = data['country'] ?? "unKnown";
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'dateTime': dateTime,
      'city': city,
      'country': country,
    };
  }


}
