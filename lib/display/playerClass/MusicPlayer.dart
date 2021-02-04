import 'dart:math';
import 'dart:ui';
import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/display/playerClass/CurrentPlayingQueue.dart';
import 'package:afromuse/display/playerClass/FullMusicPlayer.dart';
import 'package:afromuse/display/playerClass/HalfPlayer.dart';
import 'package:afromuse/display/playerClass/PlayerControlButton.dart';
import 'package:afromuse/display/playerClass/PlayerSwiper.dart';
import 'package:afromuse/display/playerClass/PlayerserviceButton.dart';
import 'package:afromuse/display/playerClass/StartAudioService.dart';
import 'package:afromuse/pages/local/SongsFromAlbum.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rxdart/rxdart.dart';


class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}
int count = 0;
class _MusicPlayerState extends State<MusicPlayer> {
  double iconSizeDefault = 30;
  int iconSizePlay = 160;
  int index = 0;
  int _currentHour;
  int _currentMinute;
  int _currentSecond;
  int _totalHour;
  int _totalMinute;
  int _totalSecond;
  Duration _duration  = new Duration();
  Duration _position = new Duration();

  // List<MediaItem> queue ;
  // MediaItem mediaItem ;
  // PlaybackState playbackState;
  // AudioState audioState;

  @override
  void initState() {
    startAudioPlayerBtn();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
      children: [
        StreamBuilder<AudioState>(
          stream: _audioStateStream,
            builder: (context, AsyncSnapshot<AudioState> snapshot){
              if(!snapshot.hasData){
                return Container(child: Center(child: Text("Connecting"),),);
              }else{
                var audioState = snapshot.data;
                var queue = audioState?.queue;
                var mediaItem = audioState?.mediaItem;
                var playbackState = audioState?.playbackState??
                    PlaybackState(processingState: AudioProcessingState.connecting, playing: false, actions: null);
                var processingState = playbackState??AudioProcessingState.none;

                if(processingState !=AudioProcessingState.none){
                  _position = audioState?.position;
                }
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
                _currentHour = (_position.inHours).toInt();
                _totalHour = (_duration.inHours).toInt();
                _totalMinute = (_duration.inMinutes%60).toInt();
                _totalSecond = (_duration.inSeconds%60).toInt();
                return ValueListenableBuilder(
                    valueListenable: isFull,
                    builder:(context, value, widget){
                      if(value == true){
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                isFull.value = false;
                              });
                            },
                            child: _halfPlayer(mediaItem, playbackState,queue)
                        );
                      }else{
                        return ColorfulSafeArea(
                          color: Colors.black.withOpacity(0.3),
                          child: Container(
                            height: height,
                            width: width,
                            color: Colors.black,
                            padding: EdgeInsets.only(
                                bottom: 20
                            ),
                            child: Draggable(
                              child: Container(
                                height: height,
                                width: width,
                                child: Stack(children: [
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        //height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.9),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            bottomRight: Radius.circular(50),
                                          ),
                                          image: DecorationImage(
                                              image: ExactAssetImage(
                                                  currentPlayingList.value[currentSongIndex.value]
                                                      .artwork != null ?
                                                  currentPlayingList.value[currentSongIndex.value]
                                                      .artwork
                                                      : "assets/artists/dezaltino.jpeg"),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center
                                          ),
                                        ),
                                        child: new BackdropFilter(
                                          filter: new ImageFilter.blur(
                                              sigmaX: width / 5, sigmaY: height / 2),
                                          child: new Container(
                                            decoration: new BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(50),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        height: height,
                                        width: width,
                                        //color: Colors.black,
                                        child:FullMusicPlayer(playbackState, mediaItem, queue),)),
                                ],),
                              ),
                              feedback: Container(
                                height: height,
                                width: width,
                                child: Stack(children: [
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        //height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.9),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50),
                                            bottomRight: Radius.circular(50),
                                          ),
                                          image: DecorationImage(
                                              image: ExactAssetImage(
                                                  currentPlayingList.value[currentSongIndex.value]
                                                      .artwork != null ?
                                                  currentPlayingList.value[currentSongIndex.value]
                                                      .artwork
                                                      : "assets/artists/dezaltino.jpeg"),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center
                                          ),
                                        ),
                                        child: new BackdropFilter(
                                          filter: new ImageFilter.blur(
                                              sigmaX: width / 5, sigmaY: height / 2),
                                          child: new Container(
                                            decoration: new BoxDecoration(
                                              color: Colors.black.withOpacity(0.3),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(50),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        height: height,
                                        width: width,
                                        //color: Colors.black,
                                        child:FullMusicPlayer(playbackState, mediaItem, queue),)),
                                ],),
                              ),
                              childWhenDragging: Container(
                                height: height,
                                width: width,
                                color: Colors.transparent,
                              ),

                              onDragEnd: (drag){
                                if(drag.offset.dy > 100){
                                  isFull.value = true;
                                }
                              },
                            ),
                          ),
                        );
                      }
                    }
                );
              }
          }
        ),

      ],
    );
  }

   Widget _halfPlayer(MediaItem mediaItem, PlaybackState playbackState, List<MediaItem> queue){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top,]);
    return Container(
      //height: 90,
      width: width,
      margin: EdgeInsets.only(
          top: height*(13.60/16),
          left: 1,
          right: 1
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.1, color: Colors.grey[400], style: BorderStyle.solid),
        )
      ),
      child: Stack(
        children:[
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
            bottom: 72,
            child: Center(
              child: Container(
                width: width*(1.6/6),
                // color: Colors.black,
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
                      Icons.play_circle_fill_rounded ,50, Colors.grey[400]),
                    ),
                    GestureDetector(
                        onTap: ()async{
                          if(mediaItem == queue.last){
                            return;
                          }
                          await AudioService.skipToNext();
                        },
                        child: bottomItems(Icons.skip_next_rounded,50,Colors.grey[400])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget FullMusicPlayer(PlaybackState playbackState, MediaItem mediaItem, List<MediaItem> queue) {
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
                child:  Container(
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
                        child: IconButton(
                            icon: Icon(Icons.queue_music_sharp,color: Colors.white,),
                            onPressed: (){
                              Alert(
                                  context: context,
                                  title: "Current list",
                                content: Container(
                                  height: heigth*(1/2),
                                    width: width,
                                    child: CurrentPlayingQueue(currentQueue: queue,))
                              )..show();
                            }
                        )),
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
                              ( (_totalHour<=0?"":_currentHour<10?"0$_currentHour : ":"$_currentHour : ")  +
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
                                  onChangeEnd: (value){
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
                              ),):Text("-- : --"),
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
                              onTap: ()async{
                                print(playbackState.repeatMode.toString());
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
                                  await AudioServiceBackground.setMediaItem(queue.last);
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
                                  await AudioServiceBackground.setMediaItem(queue.first);
                                }
                                await AudioService.skipToNext();
                              },
                              child: bottomItems(Icons.skip_next_rounded,50,Colors.white)),
                          bottomItems(Icons.favorite_border_rounded,35,Colors.white),
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




}

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest4<List<MediaItem>, MediaItem, PlaybackState,Duration,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
    AudioService.positionStream,
        (queue, mediaItem, playbackState, position) => AudioState(
      queue,
      mediaItem,
      playbackState,
            position,
    ),
  );
}


