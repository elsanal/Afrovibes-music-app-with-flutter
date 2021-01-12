import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path/path.dart';

class DragPlayer extends StatefulWidget {
  DragPlayer();
  @override
  _DragPlayerState createState() => _DragPlayerState();
}

class _DragPlayerState extends State<DragPlayer> {

  int iconSizeDefault = 90;
  int iconSizePlay = 160;
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioManager _audioManager = AudioManager.instance;
  void playMusic(){
    print("play called");
    if(_audioManager.isPlaying){
      _audioManager.toPause();
    }else{
      _audioManager.play();
    }

  }
  void stopMusic(){
    print("stop called");
    _audioManager.stop();

  }
  void pauseMusic(){
    print("pause called");
    _audioManager.toPause();
  }



  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _audioManager.release();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 90,
      width: width*(5/6),
      child: Scaffold(
        body: Container(
          height: 90,
          width: width*(5/6),
          //color: Colors.white,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                  Radius.circular(8.0)
              )
          ),
          child: Stack(
            children:[
              Positioned(
                left: 100,
                child: Container(
                  width: width,
                  height: 110,
                  child:ValueListenableBuilder(
                    valueListenable: currentSongIndex,
                    builder: (context,value,_widget){
                      return Marques(allInternalSongs.value[audio.value.curIndex ].artist +
                          ' - ' + allInternalSongs.value[audio.value.curIndex].title, Colors.white);
                    },
                  )
                ),
              ),
              Positioned(
                child: Container(
                  child: Image.asset('assets/equilizer.jpeg'),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 10,
                child: Container(
                  width: width*(3/6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _bottomItems(
                          Icons.skip_previous_outlined ,1, iconSizeDefault),
                      _bottomItems(
                          isPlaying.value == true?Icons.pause_circle_outline_outlined:
                          Icons.play_circle_outline_outlined ,2, iconSizeDefault),
                      _bottomItems(
                          Icons.skip_next_outlined ,3, iconSizeDefault),
                    ],
                  ),
                ),)
            ],
          ),
        ),
      ),
    );
  }

  _bottomItems(IconData icon_outlined, int index,int iconSize) {

    return Container(
      height: 50,
      width: 50,
      color: Colors.black,
      padding: EdgeInsets.only(
        top: 10,
        left: 15
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  if(index == 2){
                    setState(() {
                      isPlaying.value = !isPlaying.value;

                    });

                  }else if((index == 1) & (_audioManager.curIndex  > 0)){
                    setState(() {
                      currentSongIndex.value = currentSongIndex.value - 1;
                      _audioManager.previous();
                    });
                  }else if((index == 3) & (_audioManager.curIndex <
                      allInternalSongs.value.length)){
                    setState(() {
                      currentSongIndex.value = currentSongIndex.value + 1;
                      _audioManager.next();
                    });
                  }else{

                  }
                });
              },
              child: Column(
                children: [
                  Icon(icon_outlined,
                    color: Colors.white,
                    size: ScreenUtil().setWidth(iconSizeDefault),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}

class Dragger extends StatefulWidget {
  double height;
  double width;
  Dragger({this.height,this.width,});
  @override
  _DraggerState createState() => _DraggerState();
}

class _DraggerState extends State<Dragger> {
  double top =0;
  double left = 0;
  @override
  void initState() {
    top = widget.height-93.5;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: Draggable(
        child: Container(
             padding: EdgeInsets.only(
               top: top,
               left: left,
             ),
          child: DragPlayer(),
        ),
        feedback: Container(
          padding: EdgeInsets.only(
            top: top,
            left: left,
          ),
          child: DragPlayer(),
        ),
        childWhenDragging:  Container(
          padding: EdgeInsets.only(
            top: top,
            left: left,
          ),
          child: DragPlayer(),
        ),
        onDragCompleted: (){},
        onDragEnd: (drag){
          drag.velocity.pixelsPerSecond.dy.ceilToDouble();
          setState(() {
            if((top + drag.offset.dy) < 0.0){
              isTapedToPlay.value = false;
            }else if((top + drag.offset.dy) < (height - 250)){
              top = top + drag.offset.dy;
            }else if((top + drag.offset.dy) > (height - 50)){
              isTapedToPlay.value = false;
            }else {
              top = top ;
            }
            if(( drag.offset.dx) > (widget.width - widget.width*(1/3))){
              isTapedToPlay.value = false;
            }else if((drag.offset.dx) < - widget.width*(0.7)){
              isTapedToPlay.value = false;
            }else if((drag.offset.dx)< 0.0){
              left = 0;
            }else if((drag.offset.dx + left) > widget.width*(1/6)){
              left = widget.width*(1/6);
            }
            else{
              left = left + drag.offset.dx;
            }
          });
        },
      ),
    );
  }
}



























