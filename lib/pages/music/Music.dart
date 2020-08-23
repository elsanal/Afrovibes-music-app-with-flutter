import 'package:afromuse/pages/music/MusicHeader.dart';
import 'package:afromuse/pages/music/MusicList.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
   bool isPlaying = false;
   DocumentSnapshot _documentSnapshot;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient
        ),
        child: Column(
          children: <Widget>[
            new SizedBox(height: ScreenUtil().setHeight(25),),
            new MusicHeader(isPlaying, _documentSnapshot),
            Container(
              height: MediaQuery.of(context).size.height*(2/3),
//              padding: EdgeInsets.only(
//                top: ScreenUtil().setHeight(100)
//              ),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().setHeight(50)) ,
                    topRight: Radius.circular(ScreenUtil().setHeight(50)) ,
                  )
              ),
              child: new StreamBuilder(
                  stream: getData().dataFromDB(),
                  builder: (context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData){
                      return Container();
                    }else{
                        return new ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder:(context, index){
                          DocumentSnapshot document = snapshot.data.documents[index];
                          if(document['type'] != 'music'){
                            return Container();
                          }else {
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                _documentSnapshot = document;
                                isPlaying = true;
                                print(isPlaying);
                              });
                            },
                            child: Container(
                                child:new ListOfMusic(document: document,)
                            ),
                          );
                          }
                        });
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

