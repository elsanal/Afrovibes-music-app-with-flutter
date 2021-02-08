import 'package:afromuse/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<AppUSer> getUserInfo(User user)async{

  return null;
}


 getFirebaseMusic()async{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot documents = await  firestore.collection('MusicCollection').get();
  return documents;
}


 getAlbum()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('AlbumCollection').get();
  return documents;
}

 getArtist()async{
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   final documents = await  firestore.collection('ArtistCollection').get();
   return documents;
}


getNearBy()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('music').get();
  return documents;
}

getSuggested()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('music').get();
  return documents;
}


getPlaylist()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('PlaylistCollection').get();
  return documents;
}

getCategory()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('CategoryCollection').get();
  return documents;
}

