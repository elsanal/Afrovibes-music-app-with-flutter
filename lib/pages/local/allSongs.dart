import 'dart:async';
import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/display/playerClass/playerToggle.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/getLocalSongs.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class LocalSongs extends StatefulWidget {
  int position;
  LocalSongs({this.position});
  @override
  _LocalSongsState createState() => _LocalSongsState();
}
class _LocalSongsState extends State<LocalSongs> {

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  int position;
  int _totalHour;
  int _totalMinute;
  int _totalSecond;
  Duration _duration = Duration.zero;

   @override
  void initState(){
     setState(() {
       position = widget.position;
     });

    // TODO: implement initState
    super.initState();
  }

    @override
  void dispose() {
      int position = _itemPositionsListener
          .itemPositions.value.first.index;
      Preferences().saveScrollPosition('allSongPos', position);
      print(position);
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
      padding: EdgeInsets.only(
        bottom: 0,
      ),
        color: Colors.white,
        child: FutureBuilder(
          future: GetInternalData().getAllInternalSongs(null),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container();
            }else{

              return Container(
                  height: height,
                  child:ScrollablePositionedList.builder(
                    initialScrollIndex:widget.position!=null?widget.position:0,
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      MediaItem music = snapshot.data[index];
                      if (music == null) {
                        return Container(child: Center(child: Text("No music founded"),),);
                      } else {
                        if (music != null) {
                          _duration = music.duration;
                          if (_duration != null) {
                            _totalHour = (_duration.inHours).toInt();
                            _totalMinute = (_duration.inMinutes % 60).toInt();
                            _totalSecond = (_duration.inSeconds % 60).toInt();
                          }
                        }
                        return InkWell(
                          onTap: ()async{
                            List<MediaItem> mediaItems = snapshot.data;
                            bool toggle = false;
                            if(!AudioService.running){
                              print("AudioService is not running");
                             await _startAudioPlayer(mediaItems, index-1);
                              toggle = await getToggle();
                              if(toggle){
                                setState((){
                                  isTapedToPlay.value = true;
                                });
                              }
                            }else {
                             await AudioService.skipToQueueItem(music.id);
                            }

                            bool isMatched = false;
                            int _count = 0;
                            if(myRecentPlayed.value.isEmpty){
                              myRecentPlayed.value.add(mediaItems[index]);
                            }else{
                              for(int i = 0;i<myRecentPlayed.value.length; i++){
                                print(music.title.toString());
                                _count++;
                                if(music.title == myRecentPlayed.value[i].title){
                                  setState(() {
                                    isMatched = true;
                                  });
                                }
                              }
                            }
                            if((isMatched == false)&(_count == myRecentPlayed.value.length)){
                              myRecentPlayed.value.add(mediaItems[index]);
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
                                        child: _totalMinute != null ? new Text(
                                          ((_totalHour <= 0 ? "" : ((_totalHour >
                                              0) & (_totalHour < 10))
                                              ? "0$_totalHour : "
                                              : "$_totalHour : ") +
                                              (_totalMinute < 10
                                                  ? "0$_totalMinute"
                                                  : "$_totalMinute") +
                                              ' : ' + (_totalSecond < 10
                                              ? "0$_totalSecond"
                                              : "$_totalSecond")
                                          ),
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontSize: 13
                                              )
                                          ),) : Text("-- : --"),
                                      )
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      left: 35,
                                      child: Container(child: Text(music.album),)
                                  ),

                                  Positioned(
                                      top: 0,
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
              );
            }
          },
        )
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


