import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  int iconSizeDefault = 90;
  int iconSizePlay = 160;

  int index;
  AudioPlayer _audioPlayer = AudioPlayer();
  //AudioManager _audioManager = AudioManager.instance;
  void playMusic(){
    print("play called");
    _audioPlayer.play(
        currentPlayingList.value[currentSongIndex.value].file, isLocal: true,stayAwake: true);
  }
  void stopMusic(){
    print("stop called");
    _audioPlayer.stop();

  }
  void pauseMusic(){
    print("pause called");
    _audioPlayer.pause();
  }

  @override
  void initState() {
    if((isPlaying.value == true)&(isDragging.value == false)){
      _audioPlayer.play(
          currentPlayingList.value[currentSongIndex.value].file,isLocal: true,stayAwake: true);
    }
    print("new calllllll to playyyyyyyyyy");
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    print('disposer');
    _audioPlayer.release();
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
        backgroundColor: Colors.transparent,
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
                        return Marques(currentPlayingList.value[currentSongIndex.value].artistName +
                            ' - ' + currentPlayingList.value[currentSongIndex.value].musicTitle, Colors.white);
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
                ),
              ),
              ValueListenableBuilder(
                valueListenable: releasePlayer,
                builder: (context, value, widget){
                  if(value){
                    _audioPlayer.release();
                  }
                  return Container();
                },
              )
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
              onTap: () async{
                setState(() {
                  if(index == 2){
                    setState((){
                      isPlaying.value = !isPlaying.value;
                      if(isPlaying.value == true){
                        _audioPlayer.play(
                            currentPlayingList.value[currentSongIndex.value].file,isLocal: true,stayAwake: true);
                      }else{
                        _audioPlayer.pause();
                      }
                    });
                  }else if((index == 1) & (currentSongIndex.value  > 0)){
                    setState((){
                      currentSongIndex.value = currentSongIndex.value - 1;
                      if(isPlaying.value == true){
                        _audioPlayer.play(
                            currentPlayingList.value[currentSongIndex.value].file,isLocal: true, stayAwake: true);
                      }else{
                        _audioPlayer.pause();
                      }
                    });

                  }else if((index == 3) & (currentSongIndex.value <
                      currentPlayingList.value.length-1)){
                    setState((){
                      currentSongIndex.value = currentSongIndex.value + 1;
                      if(isPlaying.value == true){
                        _audioPlayer.play(
                            currentPlayingList.value[currentSongIndex.value].file,isLocal: true,stayAwake: true);
                      }else{
                        _audioPlayer.pause();
                      }
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