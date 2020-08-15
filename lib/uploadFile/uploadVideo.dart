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
  int FILESIZE = 10000000;

  void selectVideo()async{
    PickedFile video;
    if(widget.isCamera){
       video = await ImagePicker().getVideo(source: ImageSource.camera);
    }else{
       video = await ImagePicker().getVideo(source: ImageSource.gallery);
    }
    File _selectedVideo = File(video.path);
    if(_selectedVideo != null){
      int fileSize = _selectedVideo.lengthSync();
      if(fileSize > FILESIZE){
        fileSizeAlert(context);
      }else{
        setState(() {
          mediaFile = _selectedVideo;
        });
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
  if(widget.file == null){
    selectVideo();
  }else{
    setState(() {
      mediaFile = widget.file;
    });
  }
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            mediaFile!=null?Container(
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
                      child: mediaFile!=null?VideoFromPhone(videoFile: mediaFile,):Container()),
//                  new SizedBox(height: 1,),
                  GestureDetector(
                    onTap: (){
                      selectVideo();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                      ),
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
                      await uploadImage(title, description, mediaFile, album, type);
                      Navigator.pop(context);
                    },
                    color: Colors.redAccent,
                  ),
                  new SizedBox(height: 100,),
                ],
              ),
            ):GestureDetector(
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


}

