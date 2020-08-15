import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/uploadFile/filePicker.dart';
import 'package:afromuse/uploadFile/uploadPhotos.dart';
import 'package:afromuse/uploadFile/uploadVideo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

 uploadFileAlert(BuildContext context){
  ScreenUtil.init(context);
  Alert(
      context: context,
      title: "Multimedia",
      content: Column(
      children: <Widget>[
        SizedBox(height: ScreenUtil().setWidth(50),),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>UploadPhoto(isCamera: true,)));
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient
            ),
            //focusColor: Colors.redAccent[200],
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Photo", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
                new Icon(Icons.photo_camera,
                  size: ScreenUtil().setWidth(100),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setWidth(50),),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>UploadVideo(isCamera: true,)));
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Video", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
                new Icon(Icons.videocam,
                  size: ScreenUtil().setWidth(100),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setWidth(50),),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>PickFile()));
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Gallery", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
                new Icon(Icons.library_music,
                  size: ScreenUtil().setWidth(100),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setWidth(50),),
      ],
  ),
    buttons: [
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

