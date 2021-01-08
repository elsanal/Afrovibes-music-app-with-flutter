import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/constant.dart';
import 'package:afromuse/staticPage/preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class DragPlayer extends StatefulWidget {
  @override
  _DragPlayerState createState() => _DragPlayerState();
}

ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
int iconSizeDefault = 90;
int iconSizePlay = 160;
ScrollController _controller;


class _DragPlayerState extends State<DragPlayer> {

  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    if(isPlaying.value == true){
      MusicPlayerClass(
          file: SongLength.value>0?
          selectedSong[songIndex.value].filePath.toString():
          currentSongFilePath.value.toString(),
          isLocal: true,
          audioPlayer: _audioPlayer
      ).playMusic();
    }

    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
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
                    valueListenable: SongLength,
                    builder: (context,value,_widget){
                      if(value == 0){
                        return Marques(currentArtist.value +
                            ' - ' + currentSongTitle.value, Colors.white);
                      }else{
                        return Marques(selectedSong[songIndex.value].artist +
                            ' - ' + selectedSong[songIndex.value].title, Colors.white);
                      }
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
                    autoSaveIsPlaying();
                  }else if((index == 1) & (songIndex.value > 0)){
                    setState(() {
                      songIndex.value = songIndex.value - 1;
                      isPlaying.value = true;
                    });
                    autoSaveIsPlaying();
                    autoSaveIndexCurrentSong(
                      currentArtist.value,
                      currentSongTitle.value,
                      currentSongFilePath.value
                    );
                  }else if((index == 3) & (songIndex.value < SongLength.value)){
                    setState(() {
                      songIndex.value = songIndex.value + 1;
                      isPlaying.value = true;
                    });
                    autoSaveIsPlaying();
                    autoSaveIndexCurrentSong(
                        currentArtist.value,
                        currentSongTitle.value,
                        currentSongFilePath.value
                    );
                  }else{

                  }
                  if(isPlaying.value == true){
                    MusicPlayerClass(
                      file: SongLength.value>0?
                      selectedSong[songIndex.value].filePath.toString():
                      currentSongFilePath.value.toString(),
                      isLocal: true,
                      audioPlayer: _audioPlayer
                    ).playMusic();
                  }else{
                    MusicPlayerClass(
                      file: SongLength.value>0?
                      selectedSong[songIndex.value].filePath.toString():
                      currentSongFilePath.value.toString(),
                      isLocal: true,
                      audioPlayer: _audioPlayer
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



























