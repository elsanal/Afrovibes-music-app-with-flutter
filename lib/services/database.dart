import 'package:cloud_firestore/cloud_firestore.dart';


class Database{
  String userUid;

  Database({this.userUid});

  final CollectionReference Content = Firestore.instance.collection("Content");
  Future Post(String title, String description, String mediaUrl,
      String album, String type, String date, String time, String order)async{
    return await Content.add(
      {
        "author" : userUid,
        "title" : title,
        "description" : description,
        "type" : type,
        "Album" : album,
        "contentUrl" : mediaUrl,
        "date" : date,
        "time" : time,
        "order": order,
      }
    );
  }

  Future video(String title, String description, String mediaUrl,
      String album, String type, String date, String time,
      String order, double height, double width)async{
    return await Content.add(
        {
          "author" : userUid,
          "title" : title,
          "description" : description,
          "type" : type,
          "Album" : album,
          "contentUrl" : mediaUrl,
          "date" : date,
          "time" : time,
          "order": order,
          "height":height,
          "width":width,
        }
    );
  }


  final CollectionReference updateUserInfo = Firestore.instance.collection("UserInfo");
  Future updateUserInformation(String username, String email, String age,
      String profile, String tel, String country, )async{
      return await updateUserInfo.document(userUid).updateData({
        'username' : username,
        'email' : email,
        'age' : age,
        'tel' : tel,
        'country' : country,
        'profile' : profile
      });
  }

}