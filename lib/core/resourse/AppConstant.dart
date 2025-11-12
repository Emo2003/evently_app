import 'package:evently_app/core/resourse/AssetsManager.dart';

enum FieldType { name, email, password, rePassword,title,description,search }
List<String> types=["BookClub", "Sports", "BirthDay",];
Map<String,String>typeImage={
  "BookClub":AssetsManager.book_club,
  "Sports":AssetsManager.sport,
  "BirthDay":AssetsManager.birthday,
};