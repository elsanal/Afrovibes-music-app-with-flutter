import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class getData{
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  dataFromDB(){
    Stream<QuerySnapshot> snapshot =  Firestore.instance.collection('Content').orderBy('title').snapshots();
    return snapshot;
  }

  getAllInternalSongs()async{
    List<SongInfo> allSongs = await audioQuery.getSongs(sortType: SongSortType.DEFAULT);
    if(allSongs.isEmpty){
      print("Empty");
      print(allSongs.length);
    }
    return allSongs;
  }

  getAllInternalAlbum()async{
    List<AlbumInfo> album = await audioQuery.getAlbums();
    return album;
  }


}
