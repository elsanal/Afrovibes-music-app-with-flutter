import 'dart:io';

import 'package:afromuse/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';


  uploadFile(String title, String description, File mediaFile, String album, String type, String extension)async{
  final StorageReference imageRef = FirebaseStorage.instance.ref().child('contentRef');
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  var databaseTimeKey = new DateTime.now();
  final StorageUploadTask uploadTask = imageRef.child(title.toLowerCase()+ databaseTimeKey.toString() + extension).putFile(mediaFile);
  var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  var mediaUrl = imageUrl.toString();
  var userUid = user.uid.toString();
  print(userUid);
  saveToDataBase(title, description, mediaUrl, userUid, album,type);
}

void saveToDataBase(String title, String description, String mediaUrl, String userUid, String album, String type)async{
  var databaseTimeKey = new DateTime.now();
  var formaTime = new DateFormat("EEEE, hh:mm aaa");
  var formaDate = new DateFormat("MMM d, yyyy");
  String date = formaDate.format(databaseTimeKey);
  String time = formaTime.format(databaseTimeKey);
  await Database(userUid: userUid).Post(title, description, mediaUrl, album, type, date, time);
}