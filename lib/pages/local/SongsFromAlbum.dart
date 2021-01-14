import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afromuse/display/playerClass/playerToggle.dart';


final FlutterAudioQuery audioQuery = FlutterAudioQuery();


class SongsFromAlbum extends StatefulWidget {
  ValueNotifier<List<SongInfo>> newListOfSongs;
  SongsFromAlbum({this.newListOfSongs});
  @override
  _SongsFromAlbumState createState() => _SongsFromAlbumState();
}

class _SongsFromAlbumState extends State<SongsFromAlbum> {



  final String recentTable = "RECENT_PLAY";
  final String recent_favDB = "recent_fav.db";

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(
          bottom: 100,
        ),
        color: Colors.white,
        child: Scaffold(
          body: Container(
              height: height,
              margin: EdgeInsets.only(
                bottom: 150,
              ),
              child:ListView.builder(
                itemCount:currentPlayingList.value.length,
                itemBuilder: (context, index) {
                  final song = currentPlayingList.value[index];
                  if (currentPlayingList.value.isEmpty) {
                    return Container(child: Center(child: Text("No music founded"),),);
                  } else {
                    return InkWell(
                      onTap: ()async{
                        playerToggleNotifier.value = false;
                          bool toggle = await getToggle();
                        setState(() {
                          currentSongIndex.value = index;
                          isTapedToPlay.value = true;
                          isPlaying.value = true;
                        });
                        playerToggleNotifier.value = toggle;
                        var id = await Sqlite(dataBaseName: singleDatabase,
                            tableName: RECENT_PLAYED_TABLE)
                            .maxId();
                        final music = Music(
                          id: id!=null?(id + 1):0,
                          artistName: song.artist,
                          musicTitle: song.artist,
                          albumName: song.album,
                          liked: 0,
                          Ndownload: 0,
                          NListened: 0,
                          rate: 0,
                          genre: "unknown",
                          artwork: song.albumArtwork,
                          file: song.filePath,
                        );
                        List<Music> musicList = new List();
                        musicList.add(music);

                        await Sqlite(dataBaseName: singleDatabase, tableName: RECENT_PLAYED_TABLE)
                            .saveSqliteDB(musicList);
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width*(1/5),
                            child: Stack(children: [
                              Positioned(
                                  top: 3,
                                  left: 20,
                                  child: Container(
                                    height: 40,
                                    width: 250,
                                    child: Marques(currentPlayingList.value[index].artist +
                                        ' - '+ currentPlayingList.value[index].artist, Colors.black),)
                              ),
                              Positioned(
                                  right: 5,
                                  bottom: 5,
                                  child: Container(child: Text(currentPlayingList.value[index].duration),)
                              ),
                              Positioned(
                                  top: 30,
                                  left: 20,
                                  child: Container(child: Text(currentPlayingList.value[index].album),)
                              ),

                              Positioned(
                                  top: 3,
                                  right: 5,
                                  child: Container(child: IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: (){}),)
                              ),
                            ],)
                        ),
                      ),
                    );
                  }
                },
              )
          ),
        )
    );
  }
}

