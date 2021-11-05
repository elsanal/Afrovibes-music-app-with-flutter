import 'package:afromuse/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// User info
 getUserInfo(User user)async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot documents = await  firestore.collection('UserCollection').get();
  return documents;
}

/// All the albums in the database
 getAlbum()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('AlbumCollection').doc("AlbumName")
                            .collection("MusicCollection").doc("MusicTitle").get();
  return documents;
}

/// All the Singles in the database
getSingle()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('SingleCollection').doc("SingleTitle").get();
  return documents;
}

/// All the artists in the database
 getArtist()async{
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   final documents = await  firestore.collection('ArtistCollection').get();
   return documents;
}


/// users playlists
getPlaylist()async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('PlaylistCollection').get();
  return documents;
}


/// query according to key word
musicQuery(String keyword)async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('MusicCollection').where('title', isEqualTo: keyword).get();
  return documents;
}

/// query according to key word
artistQuery(String keyword)async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('ArtistCollection').where('name', isEqualTo: keyword).get();
  return documents;
}

/// query according to key word
albumQuery(String keyword)async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final documents = await  firestore.collection('AlbumCollection').where('title', isEqualTo: keyword).get();
  return documents;
}
