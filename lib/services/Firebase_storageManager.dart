import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/UserModel.dart';

import '../models/EventModel.dart';

class FirebaseStorageManager {
  static CollectionReference<UserModel> getUserCollection() {
    var collection = FirebaseFirestore.instance
        .collection("User")
        .withConverter(
          fromFirestore: (snapshot, options) {
            var data = snapshot.data();
            var user = UserModel.fromFirestore(data);
            return user;
          },
          toFirestore: (user, options) {
            return user.toFirestore();
          },
        );
    return collection;
  }


  static CollectionReference<Event> getEventCollection() {
    var collection = FirebaseFirestore.instance
        .collection("Event")
        .withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        var event = Event.fromFireStore(data);
        return event;
      },
      toFirestore: (event, options) {
        return event.toFireStore();
      },
    );
    return collection;
  }

  static Future<void> AddUser(UserModel user) {
    var collection = getUserCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }
  static Future<void> updateEvent(Event event) async {
    var collection = getEventCollection();
    var doc = collection.doc(event.id);
    await doc.update(event.toFireStore());

  }
  static Future<void> deleteEvent(String eventId) async {
    var collection = getEventCollection();
    var doc = collection.doc(eventId);
    await doc.delete();
  }

  static Future<UserModel?> GetUsers(String userId) async {
    var collection = getUserCollection();
    var doc = collection.doc(userId);
    var snapshot = await doc.get();
    return snapshot.data();
  }
  static Future<void> addEvent(Event event) {
    var collection=getEventCollection();
    var doc=collection.doc();
    event.id=doc.id;
    return doc.set(event);
  }
  static Future <List<Event>> getAllEvent( ) async {
    var collection=getEventCollection();
    var querySnapshot= await collection.get();
    var docList= querySnapshot.docs;
    var eventList = docList.map((document)=>document.data()).toList();
  return eventList ;
  }
  static Future <List<Event>> getTypeEvent(String type) async {
    var collection=getEventCollection().where("type",isEqualTo: type).orderBy("dateTime");
    var querySnapshot= await collection.get();
    var docList= querySnapshot.docs;
    var eventList = docList.map((document)=>document.data()).toList();
    return eventList ;
  }



}
