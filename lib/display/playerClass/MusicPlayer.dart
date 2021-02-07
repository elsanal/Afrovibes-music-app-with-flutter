import 'dart:math';
import 'dart:ui';
import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/display/playerClass/CurrentPlayingQueue.dart';
import 'package:afromuse/display/playerClass/FullMusicPlayer.dart';
import 'package:afromuse/display/playerClass/HalfPlayer.dart';
import 'package:afromuse/display/playerClass/PlayerControlButton.dart';
import 'package:afromuse/display/playerClass/PlayerSwiper.dart';
import 'package:afromuse/display/playerClass/PlayerserviceButton.dart';
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
import 'package:flutter_audio_query/flutter_audio_query.dart';
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
  // // double iconSizeDefault = 30;
  // // int iconSizePlay = 160;
  // // int index = 0;
  // int _currentHour;
  // int _currentMinute;
  // int _currentSecond;
  // int _totalHour;
  // int _totalMinute;
  // int _totalSecond;
  // Duration _duration = new Duration();
  // Duration _position = new Duration();

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
            builder: (context, snapshot) {
              final audioState = snapshot.data;
              final queue = audioState?.queue;
              final mediaItem = audioState?.mediaItem;
              final playbackState = audioState?.playbackState;
              Duration _position = new Duration();
              Duration _duration = new Duration();
              if(!AudioService.running){
                  return Container();
              }  else if (!snapshot.hasData){
                return Container();
              } else if (queue == null || mediaItem == null || playbackState == null){
                return Container();
              }else {
                _position = audioState?.position;
                _duration = mediaItem.duration;
                return ValueListenableBuilder(
                    valueListenable: isFull,
                    builder: (context, value, widget) {
                      if (value == true) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                isFull.value = false;
                              });
                            },
                            child: HalfPlayer(mediaItem, playbackState, queue, context)
                        );
                      } else {
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
                                                  mediaItem.artUri != null ?
                                                  mediaItem.artUri
                                                      : "assets/artists/dezaltino.jpeg"),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center
                                          ),
                                        ),
                                        child: new BackdropFilter(
                                          filter: new ImageFilter.blur(
                                              sigmaX: width / 5,
                                              sigmaY: height / 2),
                                          child: new Container(
                                            decoration: new BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                  0.3),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(
                                                    50),
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
                                        child: FullMusicPlayer(
                                            playbackState, mediaItem, queue, context, _position),)),
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
                                                  mediaItem.artUri != null ?
                                                  mediaItem.artUri
                                                      : "assets/artists/dezaltino.jpeg"),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center
                                          ),
                                        ),
                                        child: new BackdropFilter(
                                          filter: new ImageFilter.blur(
                                              sigmaX: width / 5,
                                              sigmaY: height / 2),
                                          child: new Container(
                                            decoration: new BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                  0.3),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(50),
                                                bottomRight: Radius.circular(
                                                    50),
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
                                        child: FullMusicPlayer(
                                            playbackState, mediaItem, queue, context, _position),)),
                                ],),
                              ),
                              childWhenDragging: Container(
                                height: height,
                                width: width,
                                color: Colors.transparent,
                              ),

                              onDragEnd: (drag) {
                                if (drag.offset.dy > 100) {
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

}


Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest4<List<MediaItem>,
      MediaItem,
      PlaybackState,
      Duration,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
    AudioService.positionStream,
        (queue, mediaItem, playbackState, position) =>
        AudioState(
          queue,
          mediaItem,
          playbackState,
          position,
        ),
  );
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    final value = min(_dragValue ?? widget.position?.inMilliseconds?.toDouble(),
        widget.duration.inMilliseconds.toDouble());
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.redAccent,
        inactiveTrackColor: Colors.grey[400],
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 2.0,
        thumbColor: Colors.red[700],
        thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 5.0),
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(
            overlayRadius: 28.0),
      ),
      child: Slider(
        min: 0.0,
        max: widget.duration.inMilliseconds.toDouble(),
        value: value,
        onChanged: (value) {
          if (!_dragging) {
            _dragging = true;
          }
          setState(() {
            _dragValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged(Duration(milliseconds: value.round()));
          }
        },
        onChangeEnd: (value) {
          if (widget.onChangeEnd != null) {
            widget.onChangeEnd(Duration(milliseconds: value.round()));
          }
          _dragging = false;
        },
      ),
    );
  }

}

