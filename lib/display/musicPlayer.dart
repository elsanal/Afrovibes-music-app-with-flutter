import 'dart:io';

import 'package:afromuse/pages/myInfo/MyPosts.dart';
import 'package:afromuse/services/uploadToDatabase.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/laoding.dart';
import 'package:afromuse/sharedPage/methoCalls.dart';
import 'package:afromuse/staticPage/TextFieldDeco.dart';
import 'package:afromuse/uploadFile/filePicker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_visualizers/Visualizers/LineBarVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:path/path.dart';

class MusicPlayerShow extends StatefulWidget {
  String file;
  MusicPlayerShow({this.file});
  @override
  _MusicPlayerShowState createState() => _MusicPlayerShowState();
}

class _MusicPlayerShowState extends State<MusicPlayerShow> {
  String musicPath;
  File mediaFile;
  AudioPlayer _audioPlayer = new AudioPlayer();
  final schoffoldKey = GlobalKey<ScaffoldState>();
  var  fileExtension ;
  String filename;
  bool isPlaying = false;
  Duration _duration  = new Duration();
  Duration _position = new Duration();
  bool isLooping = false;
  String title;
  String description;
  String album = 'single';
  String type = 'music';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  int _minute;
  int _second;




  void playMusic(){
    _audioPlayer.play(musicPath, isLocal: true);
    setState(() {
      isPlaying = true;
    });
  }
  void stopMusic(){
    _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      _duration = new Duration(seconds: 0);
      _position = new Duration(seconds: 0);
      _minute = 0;
      _second = 0;
    });
  }
  void pauseMusic(){
    _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }
  forwardMusic(final audioPosition){
    Duration jump = new Duration(seconds: 10);
    _audioPlayer.seek(audioPosition + jump);
  }
  reverseMusic(final audioPosition){
    Duration jump = new Duration(seconds: 10);
    _audioPlayer.seek(audioPosition - jump);
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.file!=null){
      setState(() {
        musicPath = widget.file;
        mediaFile = File(widget.file);
      });
    }
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    _audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _audioPlayer.onPlayerCompletion.listen((event) {
      stopMusic();
    });
    ScreenUtil.init(context);
    return loading?Loading():Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: gradient
          ),
          child: ListView(
            children: <Widget>[
              StreamBuilder(
                  stream: _audioPlayer.onAudioPositionChanged,
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Container(child: Text(''),);
                    }else{
                      _audioPlayer.onAudioPositionChanged.listen((event) {
                        setState(() {
                          _position = event;
                          _minute = event.inMinutes.toInt();
                          _second = event.inSeconds.toInt();
                          if(event.inSeconds.toInt() % 60 == 0){
                            _second = event.inSeconds.toInt() - ((event.inSeconds.toInt()~/60).toInt() * 60);
                          }
                          else{
                            _second = event.inSeconds.toInt() - ((event.inSeconds.toInt()~/60).toInt() * 60);
                          }
                        });
                      });
                    }
                    return Container();
                  }
              ),
              StreamBuilder(
                  stream: _audioPlayer.onDurationChanged,
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Container(child: Text(''),);
                    }else{
                      _audioPlayer.onDurationChanged.listen((event) {
                        setState(() {
                          _duration = event;
                        });
                      });
                    }
                    return Container();
                  }
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                new SizedBox(height: ScreenUtil().setWidth(100),),
                _minute!=null? new Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(_minute<10?"0$_minute":"$_minute", style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 18
                          )
                      ),),
                      new Text(' : '),
                      new Text(_second<10?"0$_second":"$_second", style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 18
                        )
                      ),),
                    ],
                  ),
                ):Container(),
               new SizedBox(height: ScreenUtil().setWidth(100),),
               widget.file!=null?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.replay_10, size: ScreenUtil().setWidth(100),color: Colors.red,),
                      onPressed: ()=>reverseMusic(_position)
                  ),
                  isPlaying?IconButton(
                    icon: Icon(Icons.pause,size:ScreenUtil().setWidth(100),color: Colors.red,),
                    onPressed: pauseMusic,
                  ):IconButton(
                      icon: Icon(Icons.play_arrow,size: ScreenUtil().setWidth(100),color: Colors.red,),
                      onPressed: playMusic
                  ),
                  IconButton(
                      icon: Icon(Icons.stop, size: ScreenUtil().setWidth(100),color: Colors.red,),
                      onPressed: stopMusic
                  ),
                  IconButton(
                      icon: Icon(Icons.forward_10, size: ScreenUtil().setWidth(100),color: Colors.red,),
                      onPressed: ()=>forwardMusic(_position)
                  ),
                ],
              ):Container(),
              ],),
            ],
          ),
        ),
      ),
    );
  }
}