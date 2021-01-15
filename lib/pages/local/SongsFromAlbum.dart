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



class SongsFromAlbum extends StatefulWidget {
  ValueNotifier<List<SongInfo>> newListOfSongs;
  SongsFromAlbum({this.newListOfSongs});
  @override
  _SongsFromAlbumState createState() => _SongsFromAlbumState();
}

class _SongsFromAlbumState extends State<SongsFromAlbum> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

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
      width: width,
      height: height,
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(60),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned(
                bottom:libraryCurrentPage.value==3?
                ScreenUtil().setHeight(300)
                    :ScreenUtil().setHeight(270),
                top: ScreenUtil().setHeight(5),
                child: Container(
                  width: width,
                  height: height,
                  child: ListView.builder(
                    itemCount:currentPlayingList.value.length,
                    itemBuilder: (context, index) {
                      Music music = currentPlayingList.value[index];
                      var len = currentPlayingList.value.length;
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
                              playerToggleNotifier.value = toggle;
                            });

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
                                        child: Marques(music.musicTitle, Colors.black),)
                                  ),
                                  Positioned(
                                      right: 15,
                                      bottom: 5,
                                      child: Container(
                                        child: Text(
                                            music.duration!=null?music.duration.toString():"-- : --"),
                                      )
                                  ),
                                  Positioned(
                                      top: 30,
                                      left: 20,
                                      child: Container(child: Text('$index'),)
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
                  ),
                ),
              ),
            ],

          ),
        )
      ),
    );
  }
}

