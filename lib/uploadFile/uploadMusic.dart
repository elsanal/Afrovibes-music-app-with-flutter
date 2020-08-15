import 'package:afromuse/sharedPage/methoCalls.dart';
import 'package:afromuse/uploadFile/filePicker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_visualizers/Visualizers/LineBarVisualizer.dart';
import 'package:flutter_visualizers/visualizer.dart';
import 'package:path/path.dart';

class UploadMusic extends StatefulWidget {
  String file;
  UploadMusic({this.file});
  @override
  _UploadMusicState createState() => _UploadMusicState();
}

class _UploadMusicState extends State<UploadMusic> {
  String musicPath;
  AudioPlayer _audioPlayer;
  final schoffoldKey = GlobalKey<ScaffoldState>();
  var  fileExtension ;
  String filename;
  bool isPlaying = false;


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


//   onLoading(BuildContext context){
//    showDialog(
//        context: context,
//      barrierDismissible: false,
//      builder: (BuildContext context){
//          return Dialog(
//            child: new Row(
//              children: <Widget>[
//                new CircularProgressIndicator(),
//                new Padding(
//                    padding: EdgeInsets.all(8.0),
//                  child: Text("Loading"),
//                )
//              ],
//            ),
//          );
//      }
//    );
//  }
//   dismissLoading(){
//    Navigator.pop();
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
  void resumeMusic(){
    _audioPlayer.pause();
  }
  void pauseMusic(){
    _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }
  void forwardMusic(){
    _audioPlayer.seek(Duration(seconds: 10));
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

   @override
  void initState() {
    // TODO: implement initState
     _audioPlayer = AudioPlayer();
     setState(() {
       musicPath = widget.file;
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
    return Container(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                  ),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(150)),
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(child: new Icon(Icons.music_video, color: Colors.indigo,))),
              new SizedBox(height: 1,),
              new Container(
                padding: EdgeInsets.all(15),
                child: Text(filename, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              widget.file!=null?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isPlaying?IconButton(
                    icon: Icon(Icons.pause,size: 50,color: Colors.red,),
                    onPressed: pauseMusic,
                  ):IconButton(
                    icon: Icon(Icons.play_arrow,size: 50,color: Colors.red,),
                    onPressed: playMusic
                  ),
                  IconButton(
                      icon: Icon(Icons.stop, size: 50,color: Colors.red,),
                      onPressed: stopMusic
                  ),
                  IconButton(
                      icon: Icon(Icons.forward_10, size: 50,color: Colors.red,),
                      onPressed: forwardMusic
                  ),

                ],
              ):Container(),
              SizedBox(height: 50,),
              RaisedButton(
                onPressed: (){
                  setState(() {
                    musicPath = null;
                  });
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>PickFile()));
                },
                child: Container(
                  child: Text("Tap to select another music"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


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

