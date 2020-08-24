import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/pages/music/MusicHeader.dart';
import 'package:afromuse/pages/music/MusicList.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
   bool isPlaying = false;
   List<DocumentSnapshot> _documentSnapshot;
   int _index = 0;
   bool isClicked = false;
   AudioPlayer _audioPlayer = new AudioPlayer();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      child: Container(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: gradient
            ),
            child: Container(
              margin: EdgeInsets.only(
                left: ScreenUtil().setHeight(5),
                right: ScreenUtil().setHeight(5),
              ),
              child: Column(
                children: <Widget>[
                  new SizedBox(height: ScreenUtil().setHeight(25),),
                  MusicHeader(isPlaying, _documentSnapshot, _index, _audioPlayer, isClicked),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height*(2/3),
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(40),
                        left: ScreenUtil().setHeight(8),
                        right: ScreenUtil().setHeight(8),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ScreenUtil().setHeight(50)) ,
                            topRight: Radius.circular(ScreenUtil().setHeight(50)) ,
                            bottomLeft: Radius.circular(ScreenUtil().setHeight(50)) ,
                            bottomRight: Radius.circular(ScreenUtil().setHeight(50)) ,
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
                                            _documentSnapshot = snapshot.data.documents;
                                            _index = index;
                                            isPlaying = true;
                                            isClicked = !isClicked;
                                            MusicPlayerClass(document: _documentSnapshot,audioPlayer: _audioPlayer, index: index).playMusic();
                                            print(isPlaying);
                                          });
                                        },
                                        child: Container(
                                            child:new ListOfMusic(document: document,)
                                        ),
                                      );
                                    }
                                  }
                              );
                            }
                          }
                      ),
                    ),
                  ),
                  Container(height: 2,)
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

