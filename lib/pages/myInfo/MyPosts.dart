import 'package:afromuse/display/musicPlayer.dart';
import 'package:afromuse/display/videoPlayer.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/sharedPage/containerDeco.dart';
import 'package:afromuse/uploadFile/alertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('My Posts'),
          actions: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.add_to_photos, color: Colors.white,size: ScreenUtil().setWidth(80),),
                  onPressed: (){
                    uploadFileAlert(context);
                  },
                  focusColor: Colors.redAccent,
                  ),
                SizedBox(width: ScreenUtil().setWidth(40),),
                Icon(Icons.live_tv,color: Colors.white,size: ScreenUtil().setWidth(80),),
                SizedBox(width: ScreenUtil().setWidth(40),),
                Icon(Icons.settings,color: Colors.white,size: ScreenUtil().setWidth(80),),
                SizedBox(width: ScreenUtil().setWidth(40),),
              ],
            ),
          ],
        ),
//        floatingActionButton: FloatingAddButton(),
        body: Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(10),
            left: ScreenUtil().setHeight(10),
            right: ScreenUtil().setHeight(10),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[500]
          ),
          child: StreamBuilder(
//              initialData: getData().dataFromDB(),
              stream: getData().dataFromDB(),
              builder: (context,AsyncSnapshot snapshot){
                 if(!snapshot.hasData){
                  return Container();
                }else{
                  return Container(
                    child: ListView.builder(
                         itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index){
                          DocumentSnapshot document = snapshot.data.documents[index];
                           if(document['type'] == 'music'){
                             return Column(
                               children: [
                                 Container(
                                   margin: EdgeInsets.only(
                                     left: ScreenUtil().setHeight(10),
                                     right: ScreenUtil().setHeight(10),
                                   ),
                                   decoration: containerDeco,
                                   child: Column(
                                   children: [
                                     //////// title, time, date
                                     articleHead(document),
                                     ////// this is the content
                                     new Container(
                                       color: Colors.green,
                                       height: ScreenUtil().setWidth(500),
                                       width: width,
                                       child: MusicPlayerShow(file: document['contentUrl'],)
                                     ),
                                     //// the Like, Comment and Share
                                     articleBottom(document, width),
                                   ],
                                 ),
                                 ),
                                 new SizedBox(height: ScreenUtil().setWidth(30),)
                               ],
                             );
                           } else if(document['type'] == 'video'){
                             return Column(
                               children: [
                                 Container(
                                   margin: EdgeInsets.only(
                                     left: ScreenUtil().setHeight(10),
                                     right: ScreenUtil().setHeight(10),
                                   ),
                                   decoration: containerDeco,
                                   child: Column(children: [
                                    articleHead(document),
                                    new VideoFromWeb(videoFile: document['contentUrl'],),
                                    articleBottom(document, width),
                                    ],
                                   ),
                                 ),
                                 new SizedBox(height: ScreenUtil().setWidth(30),)
                               ],
                             );
                           }else if(document['type'] == 'photo'){
                             return Column(
                               children: [
                                 Container(
                                   margin: EdgeInsets.only(
                                     left: ScreenUtil().setHeight(10),
                                     right: ScreenUtil().setHeight(10),
                                   ),
                                   decoration: containerDeco,
                                   child: Column(children: [
                                     articleHead(document),
                                     new Container(
                                         color: Colors.green,
                                         width: width,
                                         child: Image.network(document['contentUrl'])
                                     ),
                                     articleBottom(document, width),
                                   ],
                                   ),
                                 ),
                                 new SizedBox(height: ScreenUtil().setWidth(30),)
                               ],
                             );
                           }else if(document['type'] == 'direct'){
                             return Column(
                               children: [
                                 Container(
                                   margin: EdgeInsets.only(
                                     left: ScreenUtil().setHeight(10),
                                     right: ScreenUtil().setHeight(10),
                                   ),
                                   decoration: containerDeco,
                                   child: Column(children: [
                                     articleHead(document),
                                     new Container(
                                         color: Colors.green,
                                         height: ScreenUtil().setWidth(500),
                                         width: width,
                                         child: Icon(Icons.live_tv, size: ScreenUtil().setWidth(300),)
                                     ),
                                     articleBottom(document, width)
                                   ],
                                   ),
                                 ),
                                 new SizedBox(height: ScreenUtil().setWidth(30),)
                               ],
                             );
                           }else {
                             return Container(child: Text('Nothing'),);
                           }
                        }
                    )
                  );
                }
              }
          )
        ),
      ),
    );
  }
}



