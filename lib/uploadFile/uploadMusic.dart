import 'dart:io';

import 'package:afromuse/pages/myInfo/MyPosts.dart';
import 'package:afromuse/services/uploadToDatabase.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/laoding.dart';
import 'package:afromuse/sharedPage/methoCalls.dart';
import 'package:afromuse/staticPage/TextFieldDeco.dart';
import 'package:afromuse/uploadFile/filePicker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_visualizers/Visualizers/LineBarVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:marquee/marquee.dart';
import 'package:path/path.dart';

class UploadMusic extends StatefulWidget {
  String file;
  UploadMusic({this.file});
  @override
  _UploadMusicState createState() => _UploadMusicState();
}

class _UploadMusicState extends State<UploadMusic> {
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


//   selectMusic()async{
////    onLoading(context);
////    var path = await AudioPicker.pickAudio();
//    String file = await FilePicker.getFilePath();
////    dismissLoading(context);
//    setState(() {
//      musicPath = file;
//    });
//    _audioPlayer.stop();
//  }

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

  loop(){
    if(isLooping == true){
      _audioPlayer.onPlayerCompletion.listen((event) {
        setState(() {
          _audioPlayer.seek(Duration(seconds: 0));
        });
        playMusic();
      });
    }else{
      _audioPlayer.onPlayerCompletion.listen((event) {
        setState(() {
          _audioPlayer.seek(Duration(seconds: 0));
        });
        stopMusic();
      });

    }
  }

//  void getMime()async{
//////    String ext = extension(musicPath);// the extension
//    String filename =  basename(musicPath);//file complet name
//    String Mime = mime(musicPath);// type/ext
//    var mimeStr = Mime.split('/').first;// get the type of the file
//    setState(() {
//      fileExtension = mimeStr;
//    });
//  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
  }

   @override
  void initState() {
    // TODO: implement initState
     setState(() {
       musicPath = widget.file;
       mediaFile = File(widget.file);
     });
     filename =  basename(musicPath);//file complet name
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
    ScreenUtil.init(context);
    loop();
    return loading?Loading():Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: gradient
          ),
          child: ListView(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(150)),
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width/2,
                  child: FittedBox(child: new Icon(Icons.music_video, color: Colors.indigo,))),
              new SizedBox(height: ScreenUtil().setWidth(5),),
              Container(
                height: ScreenUtil().setWidth(100),
                  child: _Marques(filename)
              ),
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
                  SizedBox(width: ScreenUtil().setWidth(30),),
                  isLooping?IconButton(
                      icon: Icon(Icons.lock_outline, size: ScreenUtil().setWidth(50),color: Colors.red,),
                      onPressed: (){
                        setState(() {
                          isLooping = false;
                        });
                      }
                  ):IconButton(
                  icon: Icon(Icons.lock_open, size: ScreenUtil().setWidth(50),color: Colors.red,),
                      onPressed: (){
                       setState(() {
                         isLooping = true;
                       });
                  }
                  ),

                ],
              ):Container(),
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
              _minute!=null? new Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Text(_minute<10?"0$_minute":"$_minute"),
                    new Text(' : '),
                    new Text(_second<10?"0$_second":"$_second"),
                  ],
                ),
              ):Container(),
              SizedBox(height: ScreenUtil().setWidth(10),),
             _position!=null? new Slider(
                  value: _position.inSeconds.toDouble(),
                  min: 0.0,
                  max: _duration.inSeconds.toDouble(),
                  activeColor: Colors.red,
                  inactiveColor: Colors.black,
                  onChanged: (double value){
                    setState(() {
                      seekToSecond(value.toInt());
                      value = value;
                    });
                  }
              ):Container(child: Text(''),),
              SizedBox(height: ScreenUtil().setWidth(10),),
              GestureDetector(
                onTap: (){
                  setState(() {
                    musicPath = null;
                  });
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (context)=>PickFile()));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(150),
                    right: ScreenUtil().setWidth(150)
                  ),
                  color: Colors.black,
                  child: new Text("Click here to change the music",
                    style: TextStyle(
                        color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              new SizedBox(height: ScreenUtil().setWidth(30),),
             new Form(
               key: _formKey,
                 child: new Column(
                   children: [

                     new SizedBox(height: 15,),
                     Container(
                       margin: EdgeInsets.only(
                         left: ScreenUtil().setWidth(20),
                         right: ScreenUtil().setWidth(20),
                       ),
                       child: new TextFormField(
                         onChanged: (val){
                           setState(() {
                             title = val;
                           });
                         },
                         textCapitalization: TextCapitalization.characters,
                         validator: (val)=>val.isEmpty?"Please enter a title":null,
                         decoration: decorationUpload.copyWith(hintText: "Please enter the title"),

                       ),
                     ),
                     new SizedBox(height: ScreenUtil().setWidth(80),),
                     Container(
                       margin: EdgeInsets.only(
                         left: ScreenUtil().setWidth(20),
                         right: ScreenUtil().setWidth(20),
                       ),
                       child: new TextFormField(
                         onChanged: (val){
                           setState(() {
                             description = val;
                           });
                         },
                         textCapitalization: TextCapitalization.sentences,
                         validator: (val)=>val.isEmpty?"Please describe the picture":null,
                         decoration: decorationUpload.copyWith(hintText: "Please describe the picture"),
                         maxLines: null,
                         maxLength: 1000,
                         minLines: 10,
                       ),
                     ),
                     new SizedBox(height: ScreenUtil().setWidth(20),),
                     RaisedButton(
                       child: Text("Submit", style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: 25
                       ),
                       ),
                       onPressed: ()async{
                         if(_formKey.currentState.validate()) {
                           setState(() {
                             loading = true;
                           });

                           dynamic result = await uploadFile(
                               title, description, mediaFile, album, type, '.mp3');
                           if (result == null) {
                             return  Navigator.pushReplacement(
                                 context, new MaterialPageRoute(
                                 builder: (context) => MyPosts()));
                           } else {
                             setState(() {
                               loading = false;
                             });
                           }
                         }
                       },
                       color: Colors.redAccent,
                     ),
                     new SizedBox(height: 100,),
                   ],
                 )
             )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _Marques(String filename){
  return new Container(
    padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
    child: Marquee(
      text: filename!=null?filename:'',
      style: TextStyle(fontWeight: FontWeight.bold),
      blankSpace: 10,
      velocity: 20,
      pauseAfterRound: Duration(seconds: 1),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      startPadding: 10.0,
      accelerationCurve: Curves.linear,
      accelerationDuration: Duration(seconds: 1),
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    ),
  );
}


///////////////////////////PlaySong
class PlaySong extends StatefulWidget {
  @override
  _PlaySongState createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  int playerId;

  Future<void> initPlatformState() async {
    methodCalls.playSong();
    int sessionId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      sessionId = await methodCalls.getSessionId();
    } on Exception {
      sessionId = null;
    }

    setState(() {
      playerId = sessionId;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> wave = [10, 3, 4, 6, 23];
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          child: new Visualizer(
            builder: (
            BuildContext context, wave){
              return CustomPaint(
                painter: new LineBarVisualizer(
                    waveData: wave,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.redAccent),
                willChange: true,
                isComplex: true,
                child: FittedBox(child: Container(color: Colors.green,)),
              );
            },
            id:playerId,
          ),
        ),
      ),
    );
  }

}



