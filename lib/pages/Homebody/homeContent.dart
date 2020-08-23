import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:afromuse/display/musicPlayer.dart';
import 'package:afromuse/display/videoPlayer.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/sharedPage/containerDeco.dart';
import 'package:afromuse/uploadFile/alertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                color: Colors.grey[400]
            ),
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(10),
              left: ScreenUtil().setHeight(10),
              right: ScreenUtil().setHeight(10),
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
