import 'dart:io';

import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/uploadFile/alertDialog.dart';
import 'package:afromuse/uploadFile/uploadMusic.dart';
import 'package:afromuse/uploadFile/uploadPhotos.dart';
import 'package:afromuse/uploadFile/uploadVideo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mime_type/mime_type.dart';


class PickFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    File pickedFile;
    String fileType;
    String filePath;

    filePicker()async{
      String path = await FilePicker.getFilePath();
      if(path!=null){
        String Mime = mime(path);
        var type = Mime.split('/').first;
        fileType = type.toString();
        pickedFile = File(path);
        filePath = path;

        if(fileType == "audio"){
          return Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>UploadMusic(file: filePath,)));
        }else if(fileType == "image"){
          return Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>UploadPhoto(file: pickedFile,isCamera: false,)));
        }else if(fileType == "video"){
          //return  Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=>UploadVideo(file: pickedFile,isCamera: false,)));
        }else{
          return uploadFileAlert(context);
        }
      }
    }
    filePicker();

    return Container(
      color: Colors.grey,
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(50),
        right: ScreenUtil().setWidth(50),
        top: ScreenUtil().setWidth(100),
        bottom: ScreenUtil().setWidth(100),
      ),
      child: Card(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           new CircularProgressIndicator(),
           SizedBox(height: ScreenUtil().setWidth(200),),
           GestureDetector(
             onTap: (){
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
               //Navigator.push(context, new MaterialPageRoute(builder: (context)=>UploadVideo(isCamera: true,)));
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
             onTap: filePicker,
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
         ],
       )
      ),
    );
  }
}



