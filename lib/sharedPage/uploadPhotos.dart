import 'dart:io';

import 'package:afromuse/services/database.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticPage/TextFieldDeco.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {

  File imageFile;
  File selectedImage;
  String title;
  String description;
  String album = 'single';
  String type = 'photo';
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    selectImage();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void selectImage()async{
    PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
     selectedImage = File(image.path);
    if(selectedImage != null){
      print("selecting image");
      cropImage(selectedImage);
    }
  }

   cropImage(File image)async{
    print("Cropping image");
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxHeight: 1920,
        maxWidth: 1080,
    );
    if(croppedImage != null){
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

   _uploadImage()async{
    final StorageReference imageRef = FirebaseStorage.instance.ref().child('contentRef');
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final StorageUploadTask uploadTask = imageRef.child(user.uid.toString()).putFile(imageFile);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var mediaUrl = imageUrl.toString();
    var userUid = user.uid.toString();
    print(userUid);
    saveToDataBase(mediaUrl, userUid);
  }

  void saveToDataBase(String mediaUrl, String userUid)async{
     var databaseTimeKey = new DateTime.now();
     var formaTime = new DateFormat("EEEE, hh:mm aaa");
     var formaDate = new DateFormat("MMM d, yyyy");
     String date = formaDate.format(databaseTimeKey);
     String time = formaTime.format(databaseTimeKey);
     await Database(userUid: userUid).Post(title, description, mediaUrl, album, type, date, time);
   }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 1080, height: 1920);
    return Container(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            imageFile!=null?Container(
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
                      child: new Image.file(imageFile)),
                  new SizedBox(height: 1,),
                  GestureDetector(
                    onTap: selectImage,
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
                     await _uploadImage();
                     Navigator.pop(context);
                  },
                  color: Colors.redAccent,
                  ),
                  new SizedBox(height: 100,),
                ],
              ),
            ):GestureDetector(
              onTap: selectImage,
              child: Column(
                children: <Widget>[
                  selectedImage!=null?Container(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                        top: ScreenUtil().setWidth(20),
                      ),
                      child: new Image.file(selectedImage)):Container(),
                  new Icon(Icons.add_to_photos, size: 100, color: Colors.indigo,),
                  new SizedBox(height: 15,),
                  new Text("Choose a photo", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
