import 'package:evently_app/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../services/Firebase_storageManager.dart';
class UserProvider extends ChangeNotifier {
 UserModel? user;
 GetUser()async{
    user = await FirebaseStorageManager.GetUsers(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
 }
}