import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/display/playerClass/PlayerControlButton.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:rxdart/rxdart.dart';


Widget halfPlayer(BuildContext context,Stream mediaStream){
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top,]);
  return Container(
    //height: 90,
    width: width,
    margin: EdgeInsets.only(
        top: height*(13.40/16),
        left: 1,
        right: 1
    ),

    decoration: BoxDecoration(
      color: Colors.black,
    ),
    child: StreamBuilder(
      stream: mediaStream,
      builder: (context, snapshot){
        final  audioState = snapshot.data;
        var queue = audioState?.queue;
        final mediaItem = audioState?.mediaItem;
        final playbackState = audioState?.playbackState;
        if(!snapshot.hasData){
          return Container();
        }else{
          return Stack(
            children:[
              Positioned(
                left: 5,
                top: 10,
                right: 20,
                child: Center(
                  child: Container(
                      width: width,
                      height: 100,
                      child: Marques(mediaItem.artist +
                          ' - ' + mediaItem.title, Colors.white)
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0,
                child: Center(
                  child: Container(
                    width: width*(1.6/6),
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: ()async{
                            if(playbackState.playing){
                              await AudioService.pause();
                            }else{
                              await AudioService.play();
                            }
                          },
                          child: bottomItems( playbackState.playing == true?Icons.pause_circle_filled_rounded:
                          Icons.play_circle_fill_rounded ,50,Colors.white),
                        ),
                        GestureDetector(
                            onTap: ()async{
                              if(mediaItem == queue.last){
                                return;
                              }
                              await AudioService.skipToNext();
                            },
                            child: bottomItems(Icons.skip_next_rounded,50,Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    ),
  );
}

