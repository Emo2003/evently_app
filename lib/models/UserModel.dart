import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;

  UserModel({
    this.name,
    this.id,
    this.email});

  UserModel.fromFirestore(Map<String, dynamic>? data){
    id = data?['id'];
    name = data?['name'];
    email = data?['email'];
  }
  Map<String, dynamic> toFirestore() {
    return{
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
