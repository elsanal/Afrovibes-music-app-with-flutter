import 'dart:math';

import 'package:afromuse/display/playerClass/FullMusicPlayer.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> with TickerProviderStateMixin{
  int iconSizeDefault = 30;
  int iconSizePlay = 160;
  AnimationController _animationController;
  int index;
  AudioPlayer _audioPlayer = AudioPlayer();
  //AudioManager _audioManager = AudioManager.instance;
  playMusic(){
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
  skipPrevious(){
    print("play previous");
    setState(() {
      currentSongIndex.value = currentSongIndex.value - 1;
    });
    _audioPlayer.play(
        currentPlayingList.value[currentSongIndex.value].file, isLocal: true,stayAwake: true);
  }
  skipNext(){
    print("play next");
    setState(() {
      currentSongIndex.value = currentSongIndex.value +1;
    });
    _audioPlayer.play(
        currentPlayingList.value[currentSongIndex.value].file, isLocal: true,stayAwake: true);
  }





  @override
  void initState() {
    if((isPlaying.value == true)&(isDragging.value == false)){
      _audioPlayer.play(
          currentPlayingList.value[currentSongIndex.value].file,isLocal: true,stayAwake: true);
    }
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 100))..repeat();
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
  _func(){

  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height  = MediaQuery.of(context).size.height;
    return Container(
      // height: height,
      // width: width,
      child: !isFull.value?GestureDetector(
        onTap: (){
          setState(() {
            isFull.value = !isFull.value;
          });
        },
        child: Container(
          height: 100,
          width: width,
          margin: EdgeInsets.only(
            top: height*(13.5/16),
          ),
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Stack(
            children:[
              Positioned(
                left: 5,
                top: 10,
                right: 20,
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
                top: 0.0,
                right: 0,
                child: Container(
                  width: width*(1.7/6),
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // _bottomItems(
                      //     Icons.skip_previous_outlined ,1, iconSizeDefault),
                      _bottomItems(
                          isPlaying.value == true?Icons.pause_circle_filled_rounded:
                          Icons.play_circle_fill_rounded ,2, iconSizeDefault),
                      _bottomItems(
                          Icons.skip_next_rounded ,3, iconSizeDefault),
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
              ),
            ],
          ),
        ),
      ):Container(
        height: height,
        width: width,
        child: Stack(children: [
          Positioned(
              bottom: 0,
              child: Container(
                height: height,
                width: width,
                child: _fullPlayer(),)),
        ],),
      ),
    );
  }

  _bottomItems(IconData icon_outlined, int index,int iconSize) {
    return Container(
      height: 50,
      width: 50,
      color: Colors.black,
      // padding: EdgeInsets.only(
      //     top: 5,
      //     left: 5
      // ),
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
                    size: 45,
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

  _fullPlayer(){
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Theme.of(context).primaryColor
        ),
        child: Container(
          height: heigth,
          width: width,
          child: SafeArea(
            child: Stack(children: [
              Positioned(
                  left: 8,
                  top: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    onPressed: (){
                      setState(() {
                        isFull.value = !isFull.value;
                      });
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
                  child: PlayerSwip(context)),
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
                              return Marques(currentPlayingList.value[currentSongIndex.value].musicTitle, Colors.white);
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
                              currentPlayingList.value[currentSongIndex.value].artistName,
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
                    _PlayerService(Icons.playlist_add_rounded,_func(),30),
                    _PlayerService(Icons.share_rounded,_func(),30),
                    _PlayerService(Icons.download_rounded,_func(),30),
                    _PlayerService(Icons.insert_comment_rounded,_func(),30),
                    _PlayerService(Icons.favorite_border_rounded,_func(),30),
                  ],),
              ),
              Positioned(
                left: 3,
                right: 3,
                bottom: 115,
                child: Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text("05:40",style: TextStyle(
                          color: Colors.white60
                      ),),
                      new Text("03:02",style: TextStyle(
                          color: Colors.white60
                      ),),
                    ],),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 100,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.red[700],
                    inactiveTrackColor: Colors.red[100],
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbColor: Colors.redAccent,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  ),
                  child: Slider(
                      max: 5,
                      min: 0,
                      value: 3,
                      onChanged: null),
                ),),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _PlayerButton(Icons.loop_rounded,_func(),30),
                    _PlayerButton(Icons.skip_previous_rounded,skipPrevious(),30),
                    _PlayerButton(Icons.play_circle_outline_rounded, playMusic(),60),
                    _PlayerButton(Icons.skip_next_rounded, skipNext(),30),
                    _PlayerButton(Icons.shuffle_rounded,_func(),30),
                  ],),
              ),
            ],),
          ),
        ),
      ),
    );
  }

  Widget _PlayerButton(IconData icon, Function function, double size){
    return InkWell(
      onTap: (){
        return function;
      },
      child: Container(
          height: size,
          width: size,
          //color: Colors.amber,
          child: new Icon(
            icon,
            size: size,
            color: Colors.white,)
      ),
    );
  }



  Widget _PlayerService(IconData icon, Function function, double size){
    return InkWell(
      onTap: (){},
      child: Container(
          height: size,
          width: size,
          //color: Colors.amber,
          child: new Icon(
            icon,
            size: size,
            color: Colors.white,)
      ),
    );
  }

  Widget PlayerSwip(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Container(
      width: width*(3/4),
      height: width*(3/4),//heigth*(2.3/4),
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: new Swiper(
          scrollDirection: Axis.horizontal,
          itemHeight: heigth*(2/4),
          itemWidth: width*(3/4),
          viewportFraction: 0.9,
          scale: 0.9,
          loop: true,
          autoplayDisableOnInteraction: true,
          duration: 500,
          itemCount: currentPlayingList.value.length,
          itemBuilder:(context, index){
            Music music = currentPlayingList.value[index];
            return Column(
              children: [
                AnimatedBuilder(
                  animation:_animationController,
                  builder: (_, child){
                    return Transform.rotate(
                      angle: _animationController.value*2*pi,
                      child: child,
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width*(2.7/4)/2)),
                    child: Container(
                      width: width*(2.7/4),
                      height: width*(2.7/4),//heigth*(1.5/4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                            Radius.circular(width*(2.7/4)/2)
                        ),
                        image: DecorationImage(
                            image: AssetImage(music.artwork!=null?music.artwork:"assets/equilizer.jpeg"),
                            fit: BoxFit.cover
                        ),
                      ),
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}