import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/UserModel.dart';

class FirebaseStorageManager {
  static CollectionReference<UserModel> getUserCollection(){
  var collection =  FirebaseFirestore.instance.collection("User").withConverter(
        fromFirestore: (snapshot, options) {
          var data = snapshot.data();
          var user = UserModel.fromFirestore(data);
          return user;
        },
        toFirestore: (user, options) {
          return user.toFirestore();
        }
    );
    return collection;
  }
 static Future<void> AddUser(UserModel user)  {
   var collection =getUserCollection();
   var doc=collection.doc(user.id);
   return  doc.set(user);
  }
    static Future<UserModel?>GetUsers(String userId) async {
    var collection = getUserCollection();
    var doc =collection.doc(userId);
    var snapshot = await  doc.get();
    return snapshot.data();
  }
}


