import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class DragPlayer extends StatefulWidget {
  SongInfo selectedSong;
  DragPlayer({this.selectedSong});
  @override
  _DragPlayerState createState() => _DragPlayerState();
}

int _currentIndex = 0;
int iconSizeDefault = 90;
int iconSizePlay = 160;
bool isPlaying = true;
ScrollController _controller;


class _DragPlayerState extends State<DragPlayer> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 90,
      width: width*(5/6) ,
      child: Container(
        //color: Colors.white,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
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
                height: 100,
                child: Marques(widget.selectedSong.artist + ' - ' + widget.selectedSong.title),
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
                        isPlaying == true?Icons.pause_circle_outline_outlined:
                        Icons.play_circle_outline_outlined ,2, iconSizeDefault),
                    _bottomItems(
                        Icons.skip_next_outlined ,3, iconSizeDefault),
                  ],
                ),
              ),)
          ],
        ),
      ),
    );
  }

  _bottomItems(IconData icon_outlined, int index,int iconSize) {

    return Container(
      height: 50,
      width: 50,
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 10,
        left: 15
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                  if(index == 2){
                    isPlaying = !isPlaying;
                  }
                  if(isPlaying){
                    MusicPlayerClass().pauseMusic();
                  }else{
                    MusicPlayerClass(
                      file: widget.selectedSong.filePath.toString(),
                      isLocal: true,
                    ).playMusic();
                  }
                });
              },
              child: Column(
                children: [
                  Icon(icon_outlined,
                    color: Colors.black,
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
  SongInfo selectedSong;
  Dragger({this.height,this.width, this.selectedSong});
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
    return Container(
      child: Draggable(
        child: Container(
             padding: EdgeInsets.only(
               top: top,
               left: left,
             ),
          child: DragPlayer(selectedSong: widget.selectedSong,),
        ),
        feedback: Container(
          padding: EdgeInsets.only(
            top: top,
            left: left,
          ),
          child: DragPlayer(selectedSong: widget.selectedSong,),
        ),
        childWhenDragging:  Container(
          padding: EdgeInsets.only(
            top: top,
            left: left,
          ),
          child: DragPlayer(selectedSong: widget.selectedSong,),
        ),
        onDragCompleted: (){},
        onDragEnd: (drag){
          setState(() {
            if((top + drag.offset.dy) > (widget.height - 90.0)){
              top = (widget.height - 90.0);
            }else if((top + drag.offset.dy-90.0) < 0.0){
              top = 0.0;
            }else{
              top =  top + drag.offset.dy-90.0;
            }
            if((left + drag.offset.dx) > (widget.width - 90.0)){
              left = (widget.width - 90.0);
            }else if((left + drag.offset.dx-90.0) < 0.0){
              left = 0;
            }else{
              left =  left + drag.offset.dx-90.0;
            }
          });
        },
      ),
    );
  }
}



























