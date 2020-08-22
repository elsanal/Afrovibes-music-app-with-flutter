import 'dart:async';
import 'dart:io';
import 'package:afromuse/pages/myInfo/MyPosts.dart';
import 'package:afromuse/services/uploadToDatabase.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/laoding.dart';
import 'package:afromuse/staticPage/TextFieldDeco.dart';
import 'package:afromuse/uploadFile/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:media_info/media_info.dart' as FileInfo;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rxdart/subjects.dart';
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
  bool loading = false;
  String isProgress = '0';
//  MediaInfo _originFile = MediaInfo(path: '');
  MediaInfo _compressedVideoInfo = MediaInfo(path: '');
  String originSize;
  String compressSize;
  int duration;
//  Map<String, dynamic> mediaInfo;
  final _formKey = GlobalKey<FormState>();
  StreamController<bool> _streamController = new BehaviorSubject();
  Subscription _subscription;


  void selectVideo()async {
    PickedFile video;
    if (widget.isCamera) {
      video = await ImagePicker().getVideo(source: ImageSource.camera);
    } else {
      video = await ImagePicker().getVideo(source: ImageSource.gallery);
    }

    File _selectedVideo = File(video.path);
    if (_selectedVideo != null) {
      setState((){
        mediaFile = _selectedVideo;

      });
      print('We are progessing toward #############################################: select1');
      compressVideoSize(_selectedVideo);
      print('We are progessing toward #############################################: select2');
      _subscription = VideoCompress.compressProgress$.subscribe((event) {
        setState((){
          isProgress = event.toStringAsFixed(0);
          print('We are progessing toward #############################################: $event');
        });
      });

      print('We are progessing toward #############################################: select3');
    }

  }

  Future<void> compressVideoSize(File file)async{
    print("#######################************************************##################");
    _streamController.add(true);
    final compressVideoInfo = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      frameRate: 24,
    );
    setState(() {
      _compressedVideoInfo = compressVideoInfo;
    });
    int fileSize = (_compressedVideoInfo.filesize).toInt();
    if(fileSize > FILESIZE){
      return fileSizeAlert(context);
    }
    _streamController.add(false);
    print("2#######################************************************##################2");
  }


  @override
  void initState() {
    // TODO: implement initState

  if(widget.file != null){
    setState(() {
      mediaFile = widget.file;
    });
//    _originFile = MediaInfo(path: mediaFile.path);
    print('We are progessing toward #############################################: Init1');
    compressVideoSize(mediaFile);
    print('We are progessing toward #############################################: Init2');
    _subscription = VideoCompress.compressProgress$.subscribe((event) {
      setState(() {
        isProgress = event.toStringAsFixed(0);
        print('We are progessing toward #############################################: $event');
      });
    });

  }else{
    selectVideo();
  }
  super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    _subscription.unsubscribe();
    VideoCompress.deleteAllCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Container(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            mediaFile==null?GestureDetector(
              onTap: (){
                _streamController.close();
                _subscription.unsubscribe();
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
            )
                :VideoCompress.isCompressing?Container(
              child: new StreamBuilder<bool>(
                    stream: _streamController.stream,
                    builder:(context, AsyncSnapshot<bool>  snapshot){
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
            ): Container(
              decoration: BoxDecoration(
                  gradient: gradient
              ),
              child: Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    mediaFile!=null?VideoFromPhone(
                      videoFile: _compressedVideoInfo.file,
                      videoHigh: _compressedVideoInfo.height.toDouble(),
                      videoWidth: _compressedVideoInfo.width.toDouble(),
                    ):Container(),
                  new SizedBox(height: 3,),
                   GestureDetector(
                     onTap: (){
                       setState(() {
                         mediaFile = null;
                       });
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
                        if(_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });

                          dynamic result = await uploadFile(
                              title, description, _compressedVideoInfo.file,
                              album, type, '.mp4');
                          VideoCompress.deleteAllCache();

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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void fileSizeAlert(BuildContext context){
    ScreenUtil.init(context);
    Alert(
        context: context,
        title: "The video's size should be less or equal to 50 MB",
        buttons: [
          DialogButton(
            child: Text("Choose another video", style: TextStyle(
                fontSize: 18,
                color: Colors.white
            ),),
            onPressed: (){
              selectVideo();
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

}

