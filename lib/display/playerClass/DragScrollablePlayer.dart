import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class DragPlayer extends StatefulWidget {
  List<SongInfo> selectedSong;
  int index;
  DragPlayer({this.selectedSong, this.index});
  @override
  _DragPlayerState createState() => _DragPlayerState();
}

ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
int iconSizeDefault = 90;
int iconSizePlay = 160;
ScrollController _controller;


class _DragPlayerState extends State<DragPlayer> {
  @override
  void initState() {
    _currentIndex.value = widget.index;
    // TODO: implement initState
    super.initState();
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
                  child: ValueListenableBuilder(
                    valueListenable: songIndex,
                    builder: (context,value,_widget){
                      return Marques(widget.selectedSong[value].artist +
                          ' - ' + widget.selectedSong[value].title, Colors.white);
                    },
                  ),
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
                  int totalSongs = widget.selectedSong.length;
                  if(index == 2){
                    setState(() {
                      isPlaying.value = !isPlaying.value;
                    });
                  }else if((index == 1) & (songIndex.value > 0)){
                    setState(() {
                      songIndex.value = songIndex.value - 1;
                      isPlaying.value = true;
                    });
                  }else if((index == 3) & (songIndex.value < totalSongs)){
                    setState(() {
                      songIndex.value = songIndex.value + 1;
                      isPlaying.value = true;
                    });
                  }else{

                  }
                  if(isPlaying.value == true){
                    MusicPlayerClass(
                      file: widget.selectedSong[songIndex.value].filePath.toString(),
                      isLocal: true,
                      //audioPlayer: audioPlayer
                    ).playMusic();
                  }else{
                    MusicPlayerClass(
                      file: widget.selectedSong[songIndex.value].filePath.toString(),
                      isLocal: true,
                      //audioPlayer: audioPlayer
                    ).pauseMusic();
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
  int index;
  List<SongInfo> selectedSong;
  Dragger({this.height,this.width, this.selectedSong, this.index});
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
          child: DragPlayer(selectedSong: widget.selectedSong,index: widget.index),
        ),
        feedback: Container(
          padding: EdgeInsets.only(
            top: top,
            left: left,
          ),
          child: DragPlayer(selectedSong: widget.selectedSong,index: widget.index),
        ),
        childWhenDragging:  Container(
          padding: EdgeInsets.only(
            top: top,
            left: left,
          ),
          child: DragPlayer(selectedSong: widget.selectedSong,index: widget.index),
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



























