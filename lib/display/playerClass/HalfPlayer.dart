import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/display/playerClass/PlayerControlButton.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:rxdart/rxdart.dart';


Widget HalfPlayer(MediaItem mediaItem, PlaybackState playbackState,
    List<MediaItem> queue,BuildContext context) {
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top,]);
  final width = MediaQuery
      .of(context)
      .size
      .width;
  final height = MediaQuery
      .of(context)
      .size
      .height;
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top,]);
  return Container(
    //height: 90,
    width: width,
    margin: EdgeInsets.only(
        top: height * (13.50 / 16),
        left: 1,
        right: 1
    ),

    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
              width: 0.1, color: Colors.grey[600], style: BorderStyle.solid),
        )
    ),
    child: Stack(
      children: [
        Positioned(
          left: 5,
          //top: 10,
          right: 100,
          bottom: 10,
          child: Center(
            child: Container(
              // color: Colors.black,
                width: width,
                height: 100,
                child: Marques(mediaItem.artist +
                    ' - ' + mediaItem.title, Colors.black)
            ),
          ),
        ),
        Positioned(
          //top: 0.0,
          right: 0,
          bottom: 70,
          child: Center(
            child: Container(
              width: width * (1.6 / 6),
              // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (playbackState.playing) {
                        await AudioService.pause();
                      } else {
                        await AudioService.play();
                      }
                    },
                    child: bottomItems(playbackState.playing == true ? Icons
                        .pause_circle_filled_rounded :
                    Icons.play_circle_fill_rounded, 50, Colors.grey[500]),
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (mediaItem == queue.last) {
                          return;
                        }
                        await AudioService.skipToNext();
                      },
                      child: bottomItems(
                          Icons.skip_next_rounded, 50, Colors.grey[500])),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
