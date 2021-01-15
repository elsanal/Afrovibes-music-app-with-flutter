import 'dart:typed_data';

import 'package:afromuse/pages/local/playlist.dart';

/////// Music model

class Music{
  int id;
  int duration;
  String artistName;
  String musicTitle;
  String file,artwork;
  String albumName;
  int liked,Ndownload,NListened;
  String genre;
  int rate;

  Music({this.id, this.file, this.albumName, this.artistName,
         this.artwork, this.genre, this.liked, this.musicTitle,
        this.Ndownload, this.NListened, this.rate, this.duration});

  factory  Music.fromJson(Map<String, dynamic> map)=> new Music(
    id : map['id'],
    artistName : map['artistName'],
    musicTitle : map['musicTitle'],
    file : map['file'],
    duration : map['duration'],
    artwork : map['artwork'],
    albumName : map['albumName'],
    liked : map['liked'],
    Ndownload : map['Ndownload'],
    NListened : map['NListened'],
    genre : map['genre'],
    rate : map['rate'],
  );

  Map<String, dynamic>toMap()=>{
    'id' : id,
    "artistName" : artistName,
    "musicTitle" : musicTitle,
    "file" : file,
    'duration' : duration,
    "artwork" : artwork,
    "albumName" : albumName,
    "liked" : liked,
    "Ndownload" : Ndownload,
    "NListened" : NListened,
    "genre" : genre,
    "rate" : rate,
  };



}




