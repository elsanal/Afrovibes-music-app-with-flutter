import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/display/playerClass/playerToggle.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ShowFavorite extends StatefulWidget {
  @override
  _ShowFavoriteState createState() => _ShowFavoriteState();
}


class _ShowFavoriteState extends State<ShowFavorite> {

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  @override
  void initState() {
    //print(recentPlayed);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(
          bottom: 100,
        ),
        color: Colors.transparent,
        child: FutureBuilder(
          future: Sqlite(dataBaseName: FAVORITE_DB,
              tableName: FAVORITE_TABLE).retrieveMusic(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container(child: Center(child: SpinKitFadingCircle(color: Colors.black87,),),);
            }else{
              List<MediaItem> mediaItems = snapshot.data;
              return Container(
                  height: height,
                  color: Colors.transparent,
                  child:ScrollablePositionedList.builder(
                    initialScrollIndex:0,
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      MediaItem music = mediaItems[index];
                      if (myFavorite.value.isEmpty) {
                        return Container(child: Center(child: Text("No music founded"),),);
                      } else {
                        print("Has data1111");
                        return InkWell(
                          onTap: ()async{
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
                                      top: 0,
                                      left: 90,
                                      child: Container(
                                        height: 40,
                                        width: 250,
                                        child: Marques(music.title, Colors.black),)),
                                  Positioned(
                                    top: 25,
                                    left: 120,
                                    child: Container(child: Text(music.genre)),),
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Container(child: Text(music.duration.toString()),)),
                                  // Positioned(
                                  //     bottom: 5,
                                  //     left: 100,
                                  //     child: Container(
                                  //       width: width-150,
                                  //       child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //         children: [
                                  //           Row(
                                  //             children: [
                                  //               Container(child: RatingBar.builder(
                                  //                   initialRating: music.rating ,
                                  //                   minRating: 1,
                                  //                   direction: Axis.horizontal,
                                  //                   allowHalfRating: true,
                                  //                   itemCount: 5,
                                  //                   itemSize: 13,
                                  //                   itemBuilder: (context,_)=>Icon(
                                  //                     Icons.star,
                                  //                     color: Colors.amber,
                                  //                     size: 10,
                                  //                   ),
                                  //                   onRatingUpdate: (rating){
                                  //                     print(rating);
                                  //                   })
                                  //                 ,),
                                  //               SizedBox(width: 2,),
                                  //               Container(child: Text(music.liked.toString()),)
                                  //             ],
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Container(child: Icon(
                                  //                 Icons.hearing_outlined,
                                  //                 color: Colors.amber,
                                  //               ),),
                                  //               SizedBox(width: 2,),
                                  //               Text(music.NListened.toString()),
                                  //             ],
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Container(child: Icon(
                                  //                 Icons.download_outlined,
                                  //                 color: Colors.red,
                                  //               ),),
                                  //               Text(music.Ndownload.toString()),
                                  //             ],
                                  //           ),
                                  //
                                  //         ],
                                  //       ),)),
                                  Positioned(
                                      top: 3,
                                      right: 5,
                                      child: Container(
                                        child: Icon(Icons.favorite_rounded,color: Colors.redAccent,),)),
                                  Positioned(
                                      child: Container(
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(music.artUri??'assets/ic_launcher.png'),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),)),
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