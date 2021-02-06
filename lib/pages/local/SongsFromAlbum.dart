import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afromuse/display/playerClass/playerToggle.dart';



class SongsFromAlbum extends StatefulWidget {
  List<MediaItem> newListOfSongs;
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
    List<MediaItem> musics = currentAlbum.value;
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
                    itemCount:currentAlbum.value.length,
                    itemBuilder: (context, index) {
                      MediaItem music = currentAlbum.value[index];
                      if (currentAlbum.value.isEmpty) {
                        return Container(child: Center(child: Text("No music founded"),),);
                      } else {
                        return InkWell(
                          onTap: ()async{
                            if(!AudioService.running){
                              await _startAudioPlayer(musics, index-1);
                              playerToggleNotifier.value = false;
                              bool toggle = await getToggle();
                              if(toggle){
                                setState(() {
                                  isTapedToPlay.value = true;
                                  playerToggleNotifier.value = toggle;
                                });
                              }
                            }else {
                              await AudioService.updateQueue(musics);
                              await AudioService.skipToQueueItem(music.id);
                            }
                            bool isMatched = false;
                            int _count = 0;
                            if(myRecentPlayed.value.isEmpty){
                              myRecentPlayed.value.add(currentAlbum.value[index]);
                              print(myRecentPlayed.value[index].title);
                            }else{
                              for(int i = 0;i<myRecentPlayed.value.length; i++){
                                _count++;
                                if(music.title == myRecentPlayed.value[i].title){
                                  setState(() {
                                    isMatched = true;
                                  });
                                }
                              }
                            }
                            if((isMatched == false)&(_count == myRecentPlayed.value.length)){
                              myRecentPlayed.value.add(currentAlbum.value[index]);
                            }else{
                              print("Exist already in the list");
                            }
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
                                        child: Marques(music.title, Colors.black),)
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
                                      bottom: 5,
                                      left: 35,
                                      child: Container(child: Text(music.album.toString()),)
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
  _startAudioPlayer(List<MediaItem> queue, int queueIndex) async{
    List<dynamic> list = List();
    for (int i = 0; i < queue.length; i++) {
      var m = queue[i].toJson();
      list.add(m);
    }
    var params = {"data": list, "queueIndex": queueIndex};
    await AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntryPoint,
      androidNotificationChannelName: 'Audio Player',
      androidNotificationColor: 0xFFFF004,
      androidNotificationIcon: 'mipmap/ic_launcher',
      params: params,
    );
  }
}


void _audioPlayerTaskEntryPoint() async {
  await  AudioServiceBackground.run(() => AudioPlayerTask());
}

