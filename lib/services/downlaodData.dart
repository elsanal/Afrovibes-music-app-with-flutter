import 'package:afromuse/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class getInternalData{
  FlutterAudioQuery _audioQuery = FlutterAudioQuery();
  Future<List<Music>> getAllInternalSongs()async{
    List<Music> Musics = [];
    List<SongInfo> allSongs = await _audioQuery.getSongs(sortType: SongSortType.DEFAULT);

    allSongs.forEach((song) {
      Music music = Music(
        artistName: song.artist,
        musicTitle: song.title,
        albumName: song.album,
        file: song.filePath,
        liked : 0,
        Ndownload : 0,
        NListened : 0,
        genre : "unknown",
        artwork: song.albumArtwork,
        rate: 0,
      );
      Musics.add(music);
    });
    return Musics;
  }

  getAllInternalAlbum()async{
    List<AlbumInfo> album = await _audioQuery.getAlbums();
    return album;
  }


}
