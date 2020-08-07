import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/uploadPhotos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void uploadFileAlert(BuildContext context){
  ScreenUtil.init(width: 1080, height: 1920);
  Alert(
      context: context,
      title: "Multimedia",
      content: Column(
      children: <Widget>[
        SizedBox(height: ScreenUtil().setWidth(50),),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient
            ),
            //focusColor: Colors.redAccent[200],
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Photos from camera", style: TextStyle(
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
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Videos from camera", style: TextStyle(
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
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Music from Gallery", style: TextStyle(
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
        GestureDetector(
          onTap: (){
            print("Photos");
            Navigator.pop(context);
            Navigator.push(context, new MaterialPageRoute(builder: (context)=>UploadPhoto()));

          },
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Photos from Gallery", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
                new Icon(Icons.photo_library,
                  size: ScreenUtil().setWidth(100),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setWidth(50),),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient
            ),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Videos from Gallery", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
                new Icon(Icons.video_library,
                  size: ScreenUtil().setWidth(100),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

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