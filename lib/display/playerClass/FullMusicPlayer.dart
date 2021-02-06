import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/display/playerClass/CurrentPlayingQueue.dart';
import 'package:afromuse/display/playerClass/MusicPlayer.dart';
import 'package:afromuse/display/playerClass/PlayerControlButton.dart';
import 'package:afromuse/display/playerClass/PlayerSwiper.dart';
import 'package:afromuse/display/playerClass/PlayerserviceButton.dart';
import 'package:afromuse/pages/Homebody/ShowAlbum.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rxdart/rxdart.dart';


Widget FullMusicPlayer(PlaybackState playbackState, MediaItem mediaItem,
    List<MediaItem> queue, BuildContext context, Duration position) {
  _func() {};

  int _currentHour;
  int _currentMinute;
  int _currentSecond;
  int _totalHour;
  int _totalMinute;
  int _totalSecond;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  _position = position??Duration.zero;
  _duration = mediaItem?.duration??Duration.zero;

  if (_position != null) {
  _currentHour = (_position.inHours).toInt();
  if (_position.inSeconds.toInt() % 60 == 0) {
  _currentSecond = _position.inSeconds.toInt() -
  ((_position.inSeconds.toInt() ~/ 60).toInt() * 60);
  }
  else {
  _currentSecond = _position.inSeconds.toInt() -
  ((_position.inSeconds.toInt() ~/ 60).toInt() * 60);
  }
  if (_position.inMinutes.toInt() % 60 == 0) {
  _currentMinute = _position.inMinutes.toInt() -
  ((_position.inMinutes.toInt() ~/ 60).toInt() * 60);
  }
  else {
  _currentMinute = _position.inMinutes.toInt() -
  ((_position.inMinutes.toInt() ~/ 60).toInt() * 60);
  }
  }
  if (mediaItem != null) {
  _duration = mediaItem.duration;
  if (_duration != null) {
  _totalHour = (_duration.inHours).toInt();
  _totalMinute = (_duration.inMinutes % 60).toInt();
  _totalSecond = (_duration.inSeconds % 60).toInt();
  }
  }

  final width = MediaQuery
      .of(context)
      .size
      .width;
  final heigth = MediaQuery
      .of(context)
      .size
      .height;

  return Container(
    //color: Colors.wh,
    color: Colors.transparent,
    child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.white.withOpacity(0),
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark
            ),
            child: Container(
                height: heigth,
                width: width,
                color: Colors.transparent,
                child: Container(
                  child: Stack(children: [
                    Positioned(
                        left: 5,
                        top: 0,
                        child: IconButton(
                          icon: Icon(Icons.expand_more, color: Colors
                              .white,
                          ),
                          onPressed: () {
                            isFull.value = !isFull.value;
                          },
                        )
                    ),
                    Positioned(
                        right: 8,
                        top: 0,
                        child: IconButton(
                            icon: Icon(Icons.queue_music_sharp, color: Colors
                                .white,),
                            onPressed: () {
                              Alert(
                                  context: context,
                                  title: "Current list",
                                  closeIcon: Icon(Icons.close, color: Colors.black,),
                                  buttons: [
                                    DialogButton(
                                        child:Center(
                                          child: Text("Done", style: TextStyle(
                                            color: Colors.white
                                          ),),
                                        ),
                                        onPressed:(){
                                          Navigator.of(context).pop(true);
                                        },
                                      color: Colors.black,
                                    ),
                                  ],
                                  content: Container(
                                      height: heigth * (1 / 2),
                                      width: width,
                                      child: CurrentPlayingQueue(
                                        currentQueue: queue,))
                              )
                                ..show();
                            }
                        )),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 300,
                        child: PlayerSwip(queue: queue, mediaItem: mediaItem,)),
                    Positioned(
                        top: 0,
                        left: 45,
                        right: 45,
                        child: Center(
                          child: Container(
                              width: width * (1),
                              height: 30,
                              child: Center(
                                child: ValueListenableBuilder(
                                  valueListenable: currentSongIndex,
                                  builder: (context, value, _widget) {
                                    return Marques(
                                        mediaItem.title, Colors.white);
                                  },
                                ),
                              )
                          ),
                        )),
                    Positioned(
                        top: 30,
                        left: 20,
                        right: 20,
                        child: Center(
                          child: new Container(
                              child: ValueListenableBuilder(
                                valueListenable: currentSongIndex,
                                builder: (context, value, widget) {
                                  return Text(
                                    mediaItem.artist,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              )
                          ),
                        )
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 170,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PlayerService(Icons.playlist_add_rounded, _func(),
                              30),
                          PlayerService(Icons.share_rounded, _func(), 30),
                          PlayerService(Icons.download_rounded, _func(), 30),
                          PlayerService(Icons.insert_comment_rounded, _func(),
                              30),
                        ],),
                    ),
                    Positioned(
                        bottom: 100,
                        child: Container(
                          width: width,
                          child: SeekBar(
                            duration: mediaItem?.duration ?? Duration.zero,
                            position: _position ?? Duration.zero,
                            onChangeEnd: (newPosition) {
                              AudioService.seekTo(newPosition);
                            },
                          ),
                        )),
                    Positioned(
                      left: 30,
                      right: 30,
                      bottom: 90,
                      child: Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _currentMinute != null ? new Text(
                              ((_totalHour <= 0 ? "" : _currentHour < 10
                                  ? "0$_currentHour : "
                                  : "$_currentHour : ") +
                                  (_currentMinute < 10
                                      ? "0$_currentMinute"
                                      : "$_currentMinute") +
                                  ' : ' + (_currentSecond < 10
                                  ? "0$_currentSecond"
                                  : "$_currentSecond")
                              ),

                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 18
                                  )
                              ),) : Container(),
                            _totalMinute != null ? new Text(
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
                                      color: Colors.white,
                                      fontSize: 18
                                  )
                              ),) : Text("-- : --"),
                          ],),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                if((playbackState.shuffleMode != AudioServiceShuffleMode.all)){
                                  switch (playbackState.repeatMode) {
                                    case AudioServiceRepeatMode.one:
                                      await AudioService.setRepeatMode(
                                          AudioServiceRepeatMode.all);
                                      await AudioService.setShuffleMode(
                                          AudioServiceShuffleMode.none);
                                      break;
                                    case AudioServiceRepeatMode.group:
                                      await AudioService.setRepeatMode(
                                          AudioServiceRepeatMode.all);
                                      await AudioService.setShuffleMode(
                                          AudioServiceShuffleMode.none);
                                      break;
                                    case AudioServiceRepeatMode.none:
                                      await AudioService.setRepeatMode(
                                          AudioServiceRepeatMode.all);
                                      await AudioService.setShuffleMode(
                                          AudioServiceShuffleMode.none);
                                      break;
                                    case AudioServiceRepeatMode.all:
                                      await AudioService.setShuffleMode(
                                          AudioServiceShuffleMode.all);
                                      break;
                                    default:
                                      await AudioService.setRepeatMode(
                                          AudioServiceRepeatMode.all);
                                  }
                                }else{
                                  await AudioService.setShuffleMode(
                                      AudioServiceShuffleMode.none);
                                  await AudioService.setRepeatMode(
                                      AudioServiceRepeatMode.one);
                                }

                              },
                              child: bottomItems(
                                  playbackState.repeatMode ==
                                      AudioServiceRepeatMode.one ?
                                  Icons.repeat_one : playbackState.repeatMode ==
                                      AudioServiceRepeatMode.all ?
                                  Icons.repeat:playbackState.shuffleMode ==
                                      AudioServiceShuffleMode.all ?
                                  Icons.shuffle:Icons.face_unlock_sharp,
                                  35, Colors.white)),
                          GestureDetector(
                              onTap: () async {
                                if (mediaItem == queue.first) {
                                  await AudioServiceBackground.setMediaItem(
                                      queue.last);
                                }
                                await AudioService.skipToPrevious();
                              },
                              child: bottomItems(
                                  Icons.skip_previous_rounded, 50,
                                  Colors.white)),
                          GestureDetector(
                            onTap: () async {
                              if (playbackState.playing) {
                                await AudioService.pause();
                              } else {
                                await AudioService.play();
                              }
                            },
                            child: bottomItems(
                                playbackState.playing == true ? Icons
                                    .pause_circle_filled_rounded :
                                Icons.play_circle_fill_rounded, 60,
                                Colors.white),
                          ),
                          GestureDetector(
                              onTap: () async {
                                if (mediaItem == queue.last) {
                                  await AudioServiceBackground.setMediaItem(
                                      queue.first);
                                }
                                await AudioService.skipToNext();
                              },
                              child: bottomItems(
                                  Icons.skip_next_rounded, 50, Colors.white)),
                          GestureDetector(
                            onTap: (){
                            },
                            child: bottomItems(Icons.favorite_border_rounded, 35,
                                Colors.white),
                          ),
                        ],),
                    ),
                  ],),
                )
            )
        ),
      ),
    ),
  );
}



