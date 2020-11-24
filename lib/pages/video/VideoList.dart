import 'package:afromuse/display/videoPlayer.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/sharedPage/containerDeco.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    final width =  MediaQuery.of(context).size.width;
    ScreenUtil.init(context);
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: getData().dataFutureDB(),
          builder: (context, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Container();
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    DocumentSnapshot document = snapshot.data.documents[index];
                    if(document['type']!='video'){
                      return Container();
                    }else{
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
                              new VideoFromWeb(videoFile: document['contentUrl'].toString(),
                                width: document['width'],height: document['height'],),
                              articleBottom(document, width),
                            ],
                            ),
                          ),
                          new SizedBox(height: ScreenUtil().setWidth(30),)
                        ],
                      );
                    }
                  }
              );
            }
          }
      )
    );
  }
}
