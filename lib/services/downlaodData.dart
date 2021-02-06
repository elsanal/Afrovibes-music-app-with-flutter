import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class GetInternalData{
  FlutterAudioQuery _audioQuery = FlutterAudioQuery();

  Future<List<MediaItem>> getAllInternalSongs(List<SongInfo> songs)async{
    List<MediaItem> musics = [];
    if(songs == null){
      List<SongInfo> allSongs = await _audioQuery.getSongs(sortType: SongSortType.DEFAULT);
      allSongs.forEach((song) {
        MediaItem music = MediaItem(
          artist: song.artist,
          title: song.title,
          album: song.album,
          id: song.filePath,
          duration: Duration(milliseconds: int.parse(song.duration)),
          artUri: song.albumArtwork,
        );
        musics.add(music);
      });

    }else{
      songs.forEach((song) {
        MediaItem music = MediaItem(
          artist: song.artist,
          title: song.title,
          album: song.album,
          id: song.filePath,
          duration: Duration(milliseconds: int.parse(song.duration)),
          artUri: song.albumArtwork,
        );
        musics.add(music);
      });
    }
    return musics;
  }

  getAllInternalAlbum()async{
    List<AlbumInfo> album = await _audioQuery.getAlbums();
    return album;
  }

}
