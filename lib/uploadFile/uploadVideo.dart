import 'dart:async';
import 'dart:io';

import 'package:afromuse/services/uploadToDatabase.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticPage/TextFieldDeco.dart';
import 'package:afromuse/uploadFile/filePicker.dart';
import 'package:afromuse/uploadFile/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:video_compress/video_compress.dart';


class UploadVideo extends StatefulWidget {
  bool isCamera;File file;
  UploadVideo({this.isCamera, this.file});
  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {

  File mediaFile;
  String title;
  String description;
  String album = 'single';
  String type = 'video';
  int FILESIZE = 50000000;
  int ConvertToMega = 1000000;

  Subscription _subscription;
  String isProgress = '0';
  final _flutterVideoCompressed = VideoCompress();
  MediaInfo _compressedVideoInfo = MediaInfo(path: '');
  String originSize;
  String compressSize;
  int duration;

  final _streamController = StreamController<bool>.broadcast();

  void selectVideo()async {
    PickedFile video;
    if (widget.isCamera) {
      video = await ImagePicker().getVideo(source: ImageSource.camera);
    } else {
      video = await ImagePicker().getVideo(source: ImageSource.gallery);
    }

    File _selectedVideo = File(video.path);

    if (_selectedVideo != null) {
      mediaFile = widget.file;
      compressVideoSize(_selectedVideo);
      _subscription = VideoCompress.compressProgress$.subscribe((progress) {
        setState(() {
          isProgress = progress.toStringAsFixed(0);
        });
      });
    }
  }

  Future<void> compressVideoSize(File file)async{
    print("#######################************************************##################");
    String fileSizeString;

    _streamController.sink.add(true);
    final compressVideoInfo = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      frameRate: 24,
      includeAudio: true,
    );
    setState(() {
      _compressedVideoInfo = compressVideoInfo;
      originSize = (file.lengthSync()/ConvertToMega).toStringAsFixed(0);
      compressSize = (_compressedVideoInfo.filesize/ConvertToMega).toStringAsFixed(0);
      duration = (_compressedVideoInfo.duration/1000).round();
    });

    int fileSize = (_compressedVideoInfo.filesize~/ConvertToMega).toInt();
//    String fileSizeString = (_compressedVideoInfo.filesize/ConvertToMega).toStringAsFixed(0);
//    String originSize = (file.lengthSync()/ConvertToMega).toStringAsFixed(0);
//    print('Origin video size = '+ originSize);
//    print('Compressed video size = ' +fileSizeString);
    _streamController.sink.add(false);
    if(fileSize > FILESIZE){
      return fileSizeAlert(context);
    }
    print("2#######################************************************##################2");
  }


  @override
  void initState() {
    // TODO: implement initState
  if(widget.file != null){
    mediaFile = widget.file;
    compressVideoSize(widget.file);
    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      setState(() {
        isProgress = progress.toStringAsFixed(0);
      });
    });
  }else{
    setState(() {
      selectVideo();
    });
  }
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription.unsubscribe();
    _streamController.close();
    VideoCompress.deleteAllCache();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            mediaFile==null?GestureDetector(
              onTap: (){
                selectVideo();
              },
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20),
                          top: ScreenUtil().setWidth(20),
                        ),
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,
                        child: FittedBox(child: new Icon(Icons.video_library))),
                    new SizedBox(height: 15,),
                    new Text("Click here to choose a video", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black
                    ),)
                  ],
                ),
              ),
            ):VideoCompress.isCompressing?Container(
              child: new StreamBuilder<bool>(
                  stream: _streamController.stream,
                  builder:(context, AsyncSnapshot<bool> snapshot){
                    if(snapshot.data == false){
                      return Container(child: Text('Waiting...', style: TextStyle(color: Colors.black),),);
                    }else{
                      return Center(
                        child: Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                gradient: gradient
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new CircularProgressIndicator(backgroundColor: Colors.redAccent,),
                                SizedBox(height: 10,),
                                new Text("Loading", style: TextStyle(color: Colors.black),),
                                new Padding(padding: EdgeInsets.all(10),
                                  child: Text(isProgress + ' %', style: TextStyle(color: Colors.black),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
              ),
            ):Container(
              decoration: BoxDecoration(
                  gradient: gradient
              ),
              child: new Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                        top: ScreenUtil().setWidth(20),
                      ),
                      child: _compressedVideoInfo.file!=null?VideoFromPhone(videoFile: _compressedVideoInfo.file,):Container()),
//                  new SizedBox(height: 1,),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(20),
                    ),
                    padding: EdgeInsets.all(5),
                    color: Colors.black,
                    child: new Text('Origin size = ' + originSize + ' MB',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  ),
                  new SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(20),
                    ),
                    padding: EdgeInsets.all(5),
                    color: Colors.black,
                    child: new Text('Compressed size = ' + compressSize + ' MB',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  ),
                  new SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(20),
                    ),
                    padding: EdgeInsets.all(5),
                    color: Colors.black,
                    child: new Text('Compression duration : $duration sec',
                      style: TextStyle(
                          color: Colors.white
                      ),),
                  ),
                  new SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      mediaFile = null;
                      selectVideo();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                      ),
                      padding: EdgeInsets.all(5),
                      color: Colors.black,
                      child: new Text("Click here to change the video",
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  ),
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
                      validator: (val)=>val.isEmpty?"Please enter a title":null,
                      decoration: decorationUpload.copyWith(hintText: "Please enter the title"),

                    ),
                  ),
                  new SizedBox(height: 15,),
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
                      validator: (val)=>val.isEmpty?"Please describe the picture":null,
                      decoration: decorationUpload.copyWith(hintText: "Please describe the picture"),
                      maxLines: null,
                      maxLength: 1000,
                      minLines: 10,
                    ),
                  ),
                  new SizedBox(height: 15,),
                  RaisedButton(
                    child: Text("Submit", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                    ),
                    onPressed: ()async{
                      await uploadImage(title, description, _compressedVideoInfo.file, album, type);
                      VideoCompress.deleteAllCache();
                      Navigator.pop(context);
                    },
                    color: Colors.redAccent,
                  ),
                  new SizedBox(height: 100,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void fileSizeAlert(BuildContext context){
//    ScreenUtil.init(width: 1080, height: 1920);
    Alert(
        context: context,
        title: "The video's size should be less or equal to 100 MB",
        buttons: [
          DialogButton(
            child: Text("Choose another video", style: TextStyle(
                fontSize: 18,
                color: Colors.white
            ),),
            onPressed: (){
//              selectVideo();
              Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>PickFile()));
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          DialogButton(
            child: Text("CANCEL", style: TextStyle(
                fontSize: 18,
                color: Colors.white
            ),),
            onPressed: ()=>Navigator.pop(context),
            color: Colors.black,
          ),
        ]
    )..show();
  }
//
//  loadingState(){
//    Alert(
//        context: context,
//        title: '',
//        content: new StreamBuilder<bool>(
//            stream: _streamController.stream,
//            builder:(context, AsyncSnapshot<bool> snapshot){
//              if(snapshot.data == true){
//                return Card(
//                    child: Container(
//                      decoration: BoxDecoration(
//                          gradient: gradient
//                      ),
//                      child: Column(
//                        children: [
//                          new CircularProgressIndicator(),
//                          new Text("Loading", style: TextStyle(color: Colors.black),),
//                          new Padding(padding: EdgeInsets.all(10),
//                            child: Text('$isProgress %', style: TextStyle(color: Colors.black),),
//                          ),
//
//                        ],
//                      ),
//                  ),
//                );
//
//              }else{
//                return Container();
//              }
//            }
//        )
//    )..show();
//  }

}

