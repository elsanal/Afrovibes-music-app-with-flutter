// import 'dart:math';
// import 'dart:ui';
//
// import 'package:afromuse/display/playerClass/FullMusicPlayer.dart';
// import 'package:afromuse/services/models.dart';
// import 'package:afromuse/sharedPage/bodyView.dart';
// import 'package:afromuse/sharedPage/gradients.dart';
// import 'package:afromuse/staticValues/valueNotifier.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:colorful_safe_area/colorful_safe_area.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// class MusicPlayer extends StatefulWidget {
//   @override
//   _MusicPlayerState createState() => _MusicPlayerState();
// }
// int count = 0;
// class _MusicPlayerState extends State<MusicPlayer> with TickerProviderStateMixin{
//   double iconSizeDefault = 30;
//   int iconSizePlay = 160;
//   AnimationController _animationController;
//   int index = 0;
//   double _cursor = 0;
//   AudioPlayer _audioPlayer = AudioPlayer();
//   int _hour;
//   int _minute;
//   int _second;
//   int _hourT;
//   int _minuteT;
//   int _secondT;
//   Duration _duration  = new Duration();
//   Duration _position = new Duration();
//
//   playMusic(){
//     print("play called");
//     _audioPlayer.play(
//         currentPlayingList.value[currentSongIndex.value].file, isLocal: true,stayAwake: true);
//   }
//   void stopMusic(){
//     print("stop called");
//     _audioPlayer.stop();
//
//   }
//   void pauseMusic(){
//     print("pause called");
//     _audioPlayer.pause();
//   }
//   skipPrevious(){
//     print("play previous");
//     setState(() {
//       currentSongIndex.value = currentSongIndex.value - 1;
//       isPlaying.value = true;
//       count = 0;
//     });
//     _audioPlayer.play(
//         currentPlayingList.value[currentSongIndex.value].file, isLocal: true,stayAwake: true);
//   }
//   skipNext(){
//     print("play next");
//     if(isShuffle.value == true){
//       Random randomIndex = new Random();
//       int index = randomIndex.nextInt(currentPlayingList.value.length);
//       setState(() {
//         currentSongIndex.value = index;
//         isPlaying.value = true;
//         count = 0;
//       });
//     }else if(isLooping.value == true){
//       setState(() {
//         currentSongIndex.value = currentSongIndex.value;
//         isPlaying.value = true;
//         count = 0;
//       });
//     }else{
//       setState(() {
//         currentSongIndex.value = currentSongIndex.value +1;
//         isPlaying.value = true;
//         count = 0;
//       });
//     }
//     _audioPlayer.play(
//         currentPlayingList.value[currentSongIndex.value].file, isLocal: true,stayAwake: true);
//   }
//
//
//
//
//
//   @override
//   void initState() {
//     if((isPlaying.value == true)){
//       _audioPlayer.play(
//           currentPlayingList.value[currentSongIndex.value].file,isLocal: true,stayAwake: true);
//     }
//     _animationController = AnimationController(vsync: this, duration: Duration(seconds:10))..repeat();
//     print("new calllllll to playyyyyyyyyy");
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   void dispose() {
//     print('disposer');
//     _audioPlayer.release();
//     _audioPlayer.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
//   _func(){
//
//   }
//    _WaitToUpdate(){
//     return Future.delayed(Duration(seconds: 1),()=>_UpdatePlayer());
//    }
//   _UpdatePlayer(){
//     setState(() {
//       _duration = Duration(seconds: 0);
//       _position = Duration(seconds: 0);
//       _minute = 0;
//       _second = 0;
//       count = 0;
//       isPlaying.value = false;
//     });
//     if((_position == Duration(seconds: 0))
//     &(isPlaying.value == false)
//     &((isLooping.value== true)||(isShuffle.value == true))){
//       return skipNext();
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);
//     final width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     final height = MediaQuery
//         .of(context)
//         .size
//         .height;
//     return Stack(
//       children: [
//         StreamBuilder(
//             stream: _audioPlayer.onAudioPositionChanged,
//             builder: (context, snapshot){
//               if(!snapshot.hasData){
//                 return Container(child: Text(''),);
//               }else{
//                 _audioPlayer.onAudioPositionChanged.listen((event) {
//                   setState(() {
//                     //_cursor = event.inSeconds.toDouble();
//                     _position = event;
//                     _hour = _position.inHours.toInt();
//                     _minute = _position.inMinutes.toInt();
//                     _second = _position.inSeconds.toInt();
//                     if(_position.inSeconds.toInt() % 60 == 0){
//                       _second = _position.inSeconds.toInt() - ((_position.inSeconds.toInt()~/60).toInt() * 60);
//                     }
//                     else{
//                       _second =_position.inSeconds.toInt() - ((_position.inSeconds.toInt()~/60).toInt() * 60);
//                     }
//                     if(_position.inMinutes.toInt() % 60 == 0){
//                       _minute = _position.inMinutes.toInt() - ((_position.inMinutes.toInt()~/60).toInt() * 60);
//                     }
//                     else{
//                       _minute = _position.inMinutes.toInt() - ((_position.inMinutes.toInt()~/60).toInt() * 60);
//                     }
//                   });
//                 });
//                 _audioPlayer.onDurationChanged.listen((event) {
//                   setState(() {
//                     _duration = event;
//                     _hourT = (_duration.inHours).toInt();
//                     _minuteT = (_duration.inMinutes%60).toInt();
//                     _secondT = (_duration.inSeconds%60).toInt();
//                   });
//                 });
//                 _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState event)async{
//                   String _completed = "AudioPlayerState.COMPLETED";
//                   String _playing = "AudioPlayerState.PLAYING";
//                   print(event.toString());
//                   if((event.toString() == _completed)&(count <= 0)){
//                     count =1;
//                     _animationController.stop();
//                     await _WaitToUpdate();
//                   }else if(event.toString() == _playing){
//                     _animationController.repeat();
//                   }else{
//                     _animationController.stop();
//                   }
//                 });
//               }
//               return Container();
//             }
//         ),
//         new ValueListenableBuilder(
//             valueListenable: playerToggleNotifier,
//             builder:(context, value, widget){
//               if((value == false)){
//                 playMusic();
//               }
//               return Container();
//             }
//         ),
//         Container(
//           height: height,
//           width: width,
//           child: !isFull.value ? GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isFull.value = !isFull.value;
//                 });
//               },
//               child: _halfPlayer()
//           ) : ColorfulSafeArea(
//             color: Colors.black.withOpacity(0.3),
//             child: Container(
//               height: height,
//               width: width,
//               color: Colors.black,
//               padding: EdgeInsets.only(
//                   bottom: 20
//               ),
//               child: Stack(children: [
//                 Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     top: 0,
//                     child: Container(
//                       //height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.9),
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(50),
//                           bottomRight: Radius.circular(50),
//                         ),
//                         image: DecorationImage(
//                             image: ExactAssetImage(
//                                 currentPlayingList.value[currentSongIndex.value]
//                                     .artwork != null ?
//                                 currentPlayingList.value[currentSongIndex.value]
//                                     .artwork
//                                     : "assets/artists/dezaltino.jpeg"),
//                             fit: BoxFit.cover,
//                             alignment: Alignment.center
//                         ),
//                       ),
//                       child: new BackdropFilter(
//                         filter: new ImageFilter.blur(
//                             sigmaX: width / 5, sigmaY: height / 2),
//                         child: new Container(
//                           decoration: new BoxDecoration(
//                             color: Colors.black.withOpacity(0.3),
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(50),
//                               bottomRight: Radius.circular(50),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                 ),
//                 Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     top: 0,
//                     child: Container(
//                       height: height,
//                       width: width,
//                       //color: Colors.black,
//                       child: _fullPlayer(),)),
//               ],),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   _bottomItems(IconData icon_outlined, int index,double iconSize,) {
//     return Container(
//       height: iconSize,
//       width: iconSize,
//       color: Colors.transparent,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Container(
//           child: GestureDetector(
//               onTap: () async{
//                 setState(() {
//                   if(index == 2){
//                     setState((){
//                       isPlaying.value = !isPlaying.value;
//                       if(isPlaying.value == true){
//                         _audioPlayer.play(
//                             currentPlayingList.value[currentSongIndex.value].file,isLocal: true,stayAwake: true);
//                       }else{
//                         _audioPlayer.pause();
//                       }
//                     });
//                   }else if((index == 1) & (currentSongIndex.value  > 0)){
//                     setState((){
//                       currentSongIndex.value = currentSongIndex.value - 1;
//                       if(isPlaying.value == true){
//                         _audioPlayer.play(
//                             currentPlayingList.value[currentSongIndex.value].file,isLocal: true, stayAwake: true);
//                       }else{
//                         _audioPlayer.pause();
//                       }
//                     });
//
//                   }else if((index == 3) & (currentSongIndex.value <
//                       currentPlayingList.value.length-1)){
//                     setState((){
//                       currentSongIndex.value = currentSongIndex.value + 1;
//                       if(isPlaying.value == true){
//                         _audioPlayer.play(
//                             currentPlayingList.value[currentSongIndex.value].file,isLocal: true,stayAwake: true);
//                       }else{
//                         _audioPlayer.pause();
//                       }
//                     });
//                   }else if(index == 0){
//                      setState(() {
//                        isLooping.value = !isLooping.value;
//                        if(isLooping.value == true){
//                          isShuffle.value = false;
//                        }
//
//                      });
//                   }else if (index == 4){
//                     setState(() {
//                       isShuffle.value = !isShuffle.value;
//                       if(isShuffle.value == true){
//                         isLooping.value = false;
//                       }
//                     });
//                   }else{
//                     setState(() {
//                       isLooping.value = false;
//                       isShuffle.value = false;
//                     });
//                   }
//                 });
//               },
//               child: Center(
//                 child: Icon(icon_outlined,
//                   color: (isLooping.value)&((index==0))?Colors.redAccent
//                       :(isShuffle.value)&((index==4))?Colors.redAccent:Colors.white,
//                   size: iconSize,
//                 ),
//               )
//           ),
//         ),
//       ),
//     );
//   }
//
//   _halfPlayer(){
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top,]);
//     return Container(
//       //height: 90,
//       width: width,
//       margin: EdgeInsets.only(
//           top: height*(13.40/16),
//           left: 1,
//           right: 1
//       ),
//
//       decoration: BoxDecoration(
//         color: Colors.black,
//       ),
//       child: Stack(
//         children:[
//           Positioned(
//             left: 5,
//             top: 10,
//             right: 20,
//             child: Center(
//               child: Container(
//                   width: width,
//                   height: 100,
//                   child: ValueListenableBuilder(
//                     valueListenable: currentSongIndex,
//                     builder: (context,value,_widget){
//                       return Marques(currentPlayingList.value[currentSongIndex.value].artistName +
//                           ' - ' + currentPlayingList.value[currentSongIndex.value].musicTitle, Colors.white);
//                     },
//                   )
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0.0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 width: width*(1.6/6),
//                 color: Colors.black,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     _bottomItems(
//                         isPlaying.value == true?Icons.pause_circle_filled_rounded:
//                         Icons.play_circle_fill_rounded ,2, 50),
//                     _bottomItems(
//                         Icons.skip_next_rounded ,3, 50),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           ValueListenableBuilder(
//             valueListenable: releasePlayer,
//             builder: (context, value, widget){
//               if(value){
//                 _audioPlayer.release();
//               }
//               return Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   _fullPlayer(){
//     final width = MediaQuery.of(context).size.width;
//     final heigth = MediaQuery.of(context).size.height;
//     //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,]);
//     print("FullPlayer");
//     return Container(
//       //color: Colors.wh,
//       color: Colors.transparent,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: AnnotatedRegion<SystemUiOverlayStyle>(
//             value: SystemUiOverlayStyle.light.copyWith(
//                 statusBarColor: Colors.white.withOpacity(0),
//                 systemNavigationBarColor: Colors.white,
//                 systemNavigationBarIconBrightness: Brightness.dark
//             ),
//             child: Container(
//               height: heigth,
//               width: width,
//               color : Colors.transparent,
//               child: Stack(children: [
//                 Positioned(
//                     left: 8,
//                     top: 0,
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
//                       onPressed: (){
//                         setState(() {
//                           isFull.value = !isFull.value;
//                         });
//                       },
//                     )
//                 ),
//                 Positioned(
//                     right: 8,
//                     top: 10,
//                     child: Icon(Icons.queue_music_sharp,color: Colors.white,)),
//                 Positioned(
//                     left: 0,
//                     right: 0,
//                     top: 150,
//                     child: PlayerSwip(context)),
//                 Positioned(
//                     top: 0,
//                     left: 40,
//                     right: 40,
//                     child: Center(
//                       child: Container(
//                           width: width*(1),
//                           height: 30,
//                           child: Center(
//                             child: ValueListenableBuilder(
//                               valueListenable: currentSongIndex,
//                               builder: (context,value,_widget){
//                                 return Marques(currentPlayingList.value[currentSongIndex.value].musicTitle, Colors.white);
//                               },
//                             ),
//                           )
//                       ),
//                     )),
//                 Positioned(
//                     top: 30,
//                     left: 20,
//                     right: 20,
//                     child: Center(
//                       child: new Container(
//                           child: ValueListenableBuilder(
//                             valueListenable: currentSongIndex,
//                             builder: (context, value, widget){
//                               return Text(
//                                 currentPlayingList.value[currentSongIndex.value].artistName,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w400
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               );
//                             },
//                           )
//                       ),
//                     )
//                 ),
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 180,
//                   child: new Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _PlayerService(Icons.playlist_add_rounded,_func(),30),
//                       _PlayerService(Icons.share_rounded,_func(),30),
//                       _PlayerService(Icons.download_rounded,_func(),30),
//                       _PlayerService(Icons.insert_comment_rounded,_func(),30),
//                       _PlayerService(Icons.favorite_border_rounded,_func(),30),
//                     ],),
//                 ),
//                 Positioned(
//                   left: 5,
//                   right: 5,
//                   bottom: 90,
//                   child: Container(
//                     child: new Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         _minute!=null?new Text(
//                           ( (_hourT<=0?"":(_hour<10)?"0$_hour : ":"$_hour : ")  +
//                               (_minute<10?"0$_minute":"$_minute" ) +
//                                   ' : ' + (_second<10?"0$_second":"$_second")
//                           ) ,
//                         style: GoogleFonts.lato(
//                             textStyle: TextStyle(
//                                 fontWeight: FontWeight.w800,
//                                 color: Colors.white,
//                                 fontSize: 18
//                             )
//                         ),):Container(),
//                         Expanded(
//                           child: SliderTheme(
//                             data: SliderTheme.of(context).copyWith(
//                               activeTrackColor: Colors.redAccent,
//                               inactiveTrackColor: Colors.grey[400],
//                               trackShape: RectangularSliderTrackShape(),
//                               trackHeight: 2.0,
//                               thumbColor: Colors.red[700],
//                               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
//                               overlayColor: Colors.red.withAlpha(32),
//                               overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
//                             ),
//                             child: Slider(
//                               max: _duration.inMicroseconds.toDouble(),
//                               min: 0.0,
//                               value: _position.inMicroseconds.toDouble(),
//                               divisions: _duration.inMicroseconds.toInt()==0?1:_duration.inMicroseconds.toInt(),
//                               mouseCursor: MouseCursor.defer,
//                               onChanged: (value){
//                                 setState(() {
//                                   _audioPlayer.seek(Duration(microseconds: value.toInt()));
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         _minuteT!=null?new Text(
//                           ((_hourT<=0?"":((_hourT>0)&(_hourT<10))?"0$_hourT : ":"$_hourT : ")  +
//                               (_minuteT<10?"0$_minuteT":"$_minuteT" ) +
//                               ' : ' + (_secondT<10?"0$_secondT":"$_secondT")
//                           ) ,
//                           style: GoogleFonts.lato(
//                               textStyle: TextStyle(
//                                   fontWeight: FontWeight.w800,
//                                   color: Colors.white,
//                                   fontSize: 18
//                               )
//                           ),):Container(),
//                       ],),
//                   ),
//                 ),
//
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 25,
//                   child: new Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       _bottomItems(Icons.loop_rounded, 0, 35),
//                       _bottomItems(Icons.skip_previous_rounded, 1, 50),
//                       _bottomItems( isPlaying.value == true?Icons.pause_circle_filled_rounded:
//                       Icons.play_circle_fill_rounded , 2, 60),
//                       _bottomItems(Icons.skip_next_rounded, 3, 50),
//                       _bottomItems(Icons.shuffle_rounded, 4, 35),
//                     ],),
//                 ),
//               ],),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _PlayerService(IconData icon, Function function, double size){
//     return InkWell(
//       onTap: (){},
//       child: Container(
//           height: size,
//           width: size,
//           //color: Colors.amber,
//           child: new Icon(
//             icon,
//             size: size,
//             color: Colors.white,)
//       ),
//     );
//   }
//
//   Widget PlayerSwip(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final heigth = MediaQuery.of(context).size.height;
//     return Container(
//       width: width*(3/4),
//       height: width*(3/4),
//       color: Colors.transparent,
//       child: Container(
//         //color: Colors.red,
//         child: new Swiper(
//           scrollDirection: Axis.horizontal,
//           itemHeight: heigth*(2/4),
//           itemWidth: width*(2/4),
//           viewportFraction: 0.9,
//           scale: 0.9,
//           loop: true,
//           autoplayDisableOnInteraction: true,
//           duration: 500,
//           itemCount: currentPlayingList.value.length,
//           itemBuilder:(context, index){
//             Music music = currentPlayingList.value[index];
//             return Container(
//               child: Column(
//                 children: [
//                   AnimatedBuilder(
//                     animation:_animationController,
//                     builder: (_, child){
//                       return Transform.rotate(
//                         angle: _animationController.value*2*pi,
//                         child: child,
//                       );
//                     },
//                     child: Card(
//                       color: Colors.grey[600],
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(width*(2/4))),
//                       child: Container(
//                         width: width*(2/4),
//                         height: width*(2/4),
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(width*(2/4))
//                           ),
//                           image: DecorationImage(
//                               image: AssetImage(music.artwork!=null?music.artwork:"assets/playerDisk3.png"),
//                               fit: BoxFit.cover
//                           ),
//                         ),
//                         margin: EdgeInsets.all(5),
//                         padding: EdgeInsets.all(45),
//                         child: CircleAvatar(
//                           backgroundImage: AssetImage(music.artwork!=null?music.artwork:"assets/artists/floby.jpeg"),
//                         ),
//                       ),
//                     ),
//                   ),
//                  ]
//               )
//             );
//           },
//         ),
//       ),
//     );
//   }
//
// }