import 'package:afromuse/display/playerClass/AudioPlayer.dart';
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
import 'package:rxdart/rxdart.dart';


Widget FullMusicPlayer(BuildContext context, Stream<AudioState> audioStream) {
  int _currentHour;
  int _currentMinute;
  int _currentSecond;
  int _totalHour;
  int _totalMinute;
  int _totalSecond;
  Duration _duration  = new Duration();
  Duration _position = new Duration();
  _func(){}
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
              color : Colors.transparent,
              child: StreamBuilder<AudioState>(
                  stream: audioStream,
                  builder: (context, AsyncSnapshot<AudioState> snapshot){
                    final audioState = snapshot.data;
                    var queue = audioState?.queue;
                    var mediaItem = audioState?.mediaItem;
                    var playbackState = audioState?.playbackState;
                    if(playbackState.processingState !=null){
                      _position = playbackState.currentPosition;
                    }
                    //_position = playbackState.currentPosition;
                    _duration = mediaItem.duration;
                    if(_position.inSeconds.toInt() % 60 == 0){
                      _currentSecond = _position.inSeconds.toInt() - ((_position.inSeconds.toInt()~/60).toInt() * 60);
                    }
                    else{
                      _currentSecond =_position.inSeconds.toInt() - ((_position.inSeconds.toInt()~/60).toInt() * 60);
                    }
                    if(_position.inMinutes.toInt() % 60 == 0){
                      _currentMinute = _position.inMinutes.toInt() - ((_position.inMinutes.toInt()~/60).toInt() * 60);
                    }
                    else{
                      _currentMinute = _position.inMinutes.toInt() - ((_position.inMinutes.toInt()~/60).toInt() * 60);
                    }
                    _totalHour = (_duration.inHours).toInt();
                    _totalMinute = (_duration.inMinutes%60).toInt();
                    _totalSecond = (_duration.inSeconds%60).toInt();
                    if(!snapshot.hasData){
                      return Container();
                    }else{
                      return Container(
                        child: Stack(children: [
                          Positioned(
                              left: 8,
                              top: 0,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                                onPressed: (){
                                  isFull.value = !isFull.value;
                                },
                              )
                          ),
                          Positioned(
                              right: 8,
                              top: 10,
                              child: Icon(Icons.queue_music_sharp,color: Colors.white,)),
                          Positioned(
                              left: 0,
                              right: 0,
                              top: 150,
                              child: PlayerSwip()),
                          Positioned(
                              top: 0,
                              left: 40,
                              right: 40,
                              child: Center(
                                child: Container(
                                    width: width*(1),
                                    height: 30,
                                    child: Center(
                                      child: ValueListenableBuilder(
                                        valueListenable: currentSongIndex,
                                        builder: (context,value,_widget){
                                          return Marques(mediaItem.title, Colors.white);
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
                                      builder: (context, value, widget){
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
                            left: 0,
                            right: 0,
                            bottom: 180,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PlayerService(Icons.playlist_add_rounded,_func(),30),
                                PlayerService(Icons.share_rounded,_func(),30),
                                PlayerService(Icons.download_rounded,_func(),30),
                                PlayerService(Icons.insert_comment_rounded,_func(),30),
                                PlayerService(Icons.favorite_border_rounded,_func(),30),
                              ],),
                          ),
                          Positioned(
                            left: 5,
                            right: 5,
                            bottom: 90,
                            child: Container(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _currentMinute!=null?new Text(
                                    ( (_totalHour<=0?"":(_currentHour<10)?"0$_currentHour : ":"$_currentHour : ")  +
                                        (_currentMinute<10?"0$_currentMinute":"$_currentMinute" ) +
                                        ' : ' + (_currentSecond<10?"0$_currentSecond":"$_currentSecond")
                                    ) ,

                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            fontSize: 18
                                        )
                                    ),):Container(),
                                  Expanded(

                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Colors.redAccent,
                                        inactiveTrackColor: Colors.grey[400],
                                        trackShape: RectangularSliderTrackShape(),
                                        trackHeight: 2.0,
                                        thumbColor: Colors.red[700],
                                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
                                        overlayColor: Colors.red.withAlpha(32),
                                        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                                      ),
                                      child: Slider(
                                        max: _duration.inMicroseconds.toDouble(),
                                        min: 0.0,
                                        value: _position.inMicroseconds.toDouble(),
                                        divisions: _duration.inMicroseconds.toInt()==0?1:_duration.inMicroseconds.toInt(),
                                        onChanged: (value){
                                          AudioService.seekTo(Duration(milliseconds: value.toInt()));
                                        },
                                      ),
                                    ),
                                  ),
                                  _totalMinute!=null?new Text(
                                    ((_totalHour<=0?"":((_totalHour>0)&(_totalHour<10))?"0$_totalHour : ":"$_totalHour : ")  +
                                        (_totalMinute<10?"0$_totalMinute":"$_totalMinute" ) +
                                        ' : ' + (_totalSecond<10?"0$_totalSecond":"$_totalSecond")
                                    ) ,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            fontSize: 18
                                        )
                                    ),):Container(),
                                ],),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 25,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: ()async{
                                      switch(playbackState.repeatMode){
                                        case AudioServiceRepeatMode.one:
                                          await AudioService.setRepeatMode(AudioServiceRepeatMode.all);
                                          await AudioService.setShuffleMode(AudioServiceShuffleMode.none);
                                          break;
                                        case AudioServiceRepeatMode.all:
                                          await AudioService.setRepeatMode(AudioServiceRepeatMode.none);
                                          await AudioService.setShuffleMode(AudioServiceShuffleMode.all);
                                          break;
                                        case AudioServiceRepeatMode.none:
                                          await AudioService.setRepeatMode(AudioServiceRepeatMode.one);
                                          await AudioService.setShuffleMode(AudioServiceShuffleMode.none);
                                          break;
                                        default:
                                          await AudioService.setRepeatMode(AudioServiceRepeatMode.all);
                                          await AudioService.setShuffleMode(AudioServiceShuffleMode.none);
                                      }

                                    },
                                    child: bottomItems(
                                      playbackState.repeatMode == AudioServiceRepeatMode.one?
                                      Icons.repeat_one:playbackState.repeatMode == AudioServiceRepeatMode.all?
                                      Icons.repeat:Icons.shuffle,
                                      35,Colors.white)),
                                GestureDetector(
                                    onTap: ()async{
                                      if(mediaItem == queue.first){
                                        return;
                                      }
                                      await AudioService.skipToPrevious();
                                    },
                                    child: bottomItems(Icons.skip_previous_rounded,50,Colors.white)),
                                GestureDetector(
                                  onTap: ()async{
                                    if(playbackState.playing){
                                      await AudioService.pause();
                                    }else{
                                      await AudioService.play();
                                    }
                                  },
                                  child: bottomItems( playbackState.playing == true?Icons.pause_circle_filled_rounded:
                                  Icons.play_circle_fill_rounded ,60,Colors.white),
                                ),
                                GestureDetector(
                                    onTap: ()async{
                                      if(mediaItem == queue.last){
                                        return;
                                      }
                                      await AudioService.skipToNext();
                                    },
                                    child: bottomItems(Icons.skip_next_rounded,50,Colors.white)),
                                bottomItems(Icons.favorite_border_rounded,35,Colors.white),
                              ],),
                          ),
                        ],),
                      );
                    }
                  }
              ),
            )
        ),
      ),
    ),
  );
}

// Stream<AudioState> get _audioStateStream {
//   return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
//       AudioState>(
//     AudioService.queueStream,
//     AudioService.currentMediaItemStream,
//     AudioService.playbackStateStream,
//         (queue, mediaItem, playbackState) => AudioState(
//       queue,
//       mediaItem,
//       playbackState,
//     ),
//   );
// }


Stream<FullAudioPlayerState> get _fullAudioStateStream{

  return Rx.combineLatest4(
      AudioService.queueStream,
      AudioService.currentMediaItemStream,
      AudioService.playbackStateStream,
      AudioService.positionStream,
          (queue, mediaItem, playbackState, position) => FullAudioPlayerState(
              queue,
              mediaItem,
              playbackState,
              position
          ));
}


