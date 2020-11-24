import 'dart:io';

import 'package:afromuse/uploadFile/uploadVideo.dart';
import 'package:flutter/material.dart';
import 'package:video_trimmer/storage_dir.dart';
import 'package:video_trimmer/trim_editor.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:video_trimmer/video_viewer.dart';

class VideoTrimmer extends StatefulWidget {
  File videoFile;
  VideoTrimmer({this.videoFile});
  @override
  _VideoTrimmerState createState() => _VideoTrimmerState();
}

class _VideoTrimmerState extends State<VideoTrimmer> {

  double _startValue = 0.0;
  double _endValue = 0.0;
  File videoFile;
  File _selectedVideo;
  File file;

  bool _isPlaying = false;
  bool _isProgessVisibility = false;
  final Trimmer _trimmer = Trimmer();


  @override
  void initState() {
    // TODO: implement initState
    _trimmer.loadVideo(videoFile: widget.videoFile);
    file = File(widget.videoFile.path);
    super.initState();
  }




  Future<File> _saveVideo()async{
    setState(() {
      _isProgessVisibility = true;
    });
    File _value;
    final StorageDir temporaryStor = StorageDir.temporaryDirectory;
    await _trimmer.saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
                        .then((value){
                    setState(() {
                      _isProgessVisibility = true;
                      _value = File(value);
                    });
    });

    return _value;
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
            child: ListView(
              children: <Widget>[
              Visibility(
                  visible: _isProgessVisibility,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.redAccent,
                  )),
                RaisedButton(
                  onPressed: _isProgessVisibility?null:
                      ()async {
                    _saveVideo().then((value){
                      print('This is the out path : $value');
                      print(file.lengthSync());
                      setState(() {
                        videoFile = File(value.path);
                      });
                      final snackBar = SnackBar(content: Text('saved'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    });
                      },
                  child: Text("SAVE"),
                ),

                  widget.videoFile!=null?new VideoViewer():Container(child: Text("Nothing"),),
                widget.videoFile!=null?Center(
                  child: TrimEditor(
                    viewerWidth: MediaQuery.of(context).size.width,
                    viewerHeight: 50.0,
                    onChangeStart: (value){
                      _startValue = value;
                    },
                    onChangeEnd: (value){
                      _endValue = value;
                    },
                    onChangePlaybackState: (value){
                      setState(() {
                        _isPlaying = value;
                      });
                    },
                  ),
                ):Container(),
              RaisedButton(
                onPressed:()async{
                  final File file = await _saveVideo();
                  if(file!=null){
                    
                    // Navigator.push(context, new MaterialPageRoute(
                    //     builder: (context)=>UploadVideo())
                    // );
                  }
                },
                child: Text('validate'),
              ),
                FlatButton(
                  child: _isPlaying?Icon(Icons.pause, size: 50, color: Colors.black,):
                  Icon(Icons.play_arrow, size: 50, color: Colors.black,),
                  onPressed: ()async{
                    bool playbackState = await _trimmer.videPlaybackControl(
                        startValue: _startValue, endValue: _endValue);
                    setState(() {
                      _isPlaying = playbackState;
                    });
                  },
                )
              ],
            ),
          ),
        ),
    );
  }
}
