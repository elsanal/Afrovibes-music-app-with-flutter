import 'dart:io';

import 'package:afromuse/pages/myInfo/MyPosts.dart';
import 'package:afromuse/services/uploadToDatabase.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/laoding.dart';
import 'package:afromuse/staticPage/TextFieldDeco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class UploadPhoto extends StatefulWidget {
  bool isCamera;File file;
  UploadPhoto({this.isCamera, this.file});
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {

  File mediaFile;
  File selectedImage;
  String title;
  String description;
  String album = 'single';
  String type = 'photo';

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState

  if(widget.file != null){
    setState(() {
      selectedImage = widget.file;
    });
    cropImage(selectedImage);
  }else{
    selectImage();
  }
    super.initState();
  }


  void selectImage()async{
    PickedFile image;
    if(widget.isCamera){
      image = await ImagePicker().getImage(source: ImageSource.camera);
    }else{
      image = await ImagePicker().getImage(source: ImageSource.gallery);

    }
     selectedImage = File(image.path);
    if(selectedImage != null){
      cropImage(selectedImage);
    }
  }

   cropImage(File image)async{
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxHeight: 1920,
        maxWidth: 1080,
    );
    if(croppedImage != null){
      setState(() {
        mediaFile = croppedImage;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
   ScreenUtil.init(context);
    return loading?Loading():Container(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            mediaFile!=null?Container(
              decoration: BoxDecoration(
                  gradient: gradient
              ),
              child: Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20),
                          top: ScreenUtil().setWidth(20),
                        ),
                        child: new Image.file(mediaFile)),
                    new SizedBox(height: 1,),
                    GestureDetector(
                      onTap: (){
                        selectImage();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20),
                        ),
                        color: Colors.black,
                        child: new Text("Click here to change the picture",
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
                        textCapitalization: TextCapitalization.characters,
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
                        textCapitalization: TextCapitalization.sentences,
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
                ),
              ),
            ):GestureDetector(
              onTap: (){
                selectImage();
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
                        child: FittedBox(child: new Icon(Icons.photo_library))),
                    new SizedBox(height: 15,),
                    new Text("Click here to choose a picture", style: TextStyle(
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
}
