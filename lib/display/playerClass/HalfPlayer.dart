import 'dart:math';
import 'package:afromuse/display/playerClass/PlayerControlButton.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


Widget HalfPlayer(MediaItem mediaItem, PlaybackState playbackState,
    List<MediaItem> queue,BuildContext context, Duration position) {
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
  return ScreenUtilInit(
      designSize: Size(width, height),
      allowFontScaling: true,
    builder: () {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: ScreenUtil().setHeight(116),
            width: width,
            margin: EdgeInsets.only(
                //top: height * (13.50 / 16),
                left: 1,
                right: 1
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                      width: 0.4, color: Colors.grey[400], style: BorderStyle.solid),
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
                  bottom: 65,
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  child: SeekBar(
                                    duration: mediaItem?.duration ?? Duration.zero,
                                    position: position ?? Duration.zero,
                                    onChangeEnd: (newPosition) {
                                      AudioService.seekTo(newPosition);
                                    },
                                  ),
                                ),
                                bottomItems(playbackState.playing == true ? Icons
                                    .pause_circle_filled_rounded :
                                Icons.play_circle_fill_rounded, 50, Colors.grey[500]),

                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () async {
                                if (mediaItem == queue.last) {
                                  return;
                                }
                                await AudioService.skipToNext();
                              },
                              child: bottomItems(
                                  Icons.skip_next_rounded, 50, Colors.grey[500])
                              )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
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

  Widget innerText(double value){

  }

  @override
  Widget build(BuildContext context) {
    final value = min(_dragValue ?? widget.position?.inMilliseconds?.toDouble(),
        widget.duration.inMilliseconds.toDouble());
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return SleekCircularSlider(
      min: 0.0,
      max: widget.duration.inMilliseconds.toDouble(),
      initialValue: value,
      appearance: CircularSliderAppearance(
        size: 46,
        angleRange: 360,
        customColors: CustomSliderColors(
          trackColor: Colors.grey,
          progressBarColor: Colors.red,
          dotColor: Colors.redAccent
        ),
        customWidths: CustomSliderWidths(
          progressBarWidth: 3,
          trackWidth: 3
        )
      ),
      innerWidget:(value)=>Text(''),
      onChange: (value) {
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
    );
  }
}