import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/searchBar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusicHeader extends StatefulWidget {
  bool isPlaying;
  DocumentSnapshot document;
  MusicHeader(this.isPlaying, this.document);
  @override
  _MusicHeaderState createState() => _MusicHeaderState();
}

class _MusicHeaderState extends State<MusicHeader> {

  bool isSearchField = false;
  AudioPlayer _audioPlayer = new AudioPlayer();

  void searchToggle(){
    setState(() {
      isSearchField = !isSearchField;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer.play(widget.document['contentUrl'], isLocal: false);
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context);
    return (widget.isPlaying)&(widget.document!=null)?Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setWidth(40),
      ),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      width: Width,
      height: ScreenUtil().setHeight(height*(9/10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          isSearchField?TextFieldForm(searchToggle: searchToggle,):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new GestureDetector(
                child: Container(
                  child: Text("Menu"),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Text("New music"),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Text("Favorites"),
                ),
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: searchToggle,
                      child: Container(child: Icon(Icons.search),)),
                  new GestureDetector(
                    child: Container(
                      child: Text("Search"),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text("Author + music title + album name"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new GestureDetector(
                child: Container(
                  child: Icon(Icons.skip_previous),
                ),
              ),
              new GestureDetector(
                onTap: (){
                  //MusicPlayerClass(document: widget.document).playMusic(widget.isPlaying);
                },
                child: Container(
                  child: Icon(Icons.fast_rewind),
                ),
              ),
              new GestureDetector(
                onTap: (){
                  MusicPlayerClass(document: widget.document, audioPlayer: _audioPlayer).playMusic();
                  print(widget.document);
                  print(widget.isPlaying);
                },
                child: Container(
                  child: Icon(Icons.play_circle_outline),
                ),
              ),
              new GestureDetector(
                onTap: (){
                  MusicPlayerClass(document: widget.document, audioPlayer: _audioPlayer).stopMusic();
                },
                child: Container(
                  child: Icon(Icons.stop),
                ),
              ),
              new GestureDetector(
                onTap: (){
//                  MusicPlayerClass(document: widget.document).fMusic(widget.isPlaying);
                },
                child: Container(
                  child: Icon(Icons.fast_forward),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Icon(Icons.skip_next),
                ),
              ),
            ],
          ),
        ],
      ),
    ):Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setWidth(20),
      ),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(50),
        right: ScreenUtil().setWidth(50),
        top: ScreenUtil().setWidth(50),
        bottom: ScreenUtil().setWidth(50),
      ),
      width: Width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          isSearchField?TextFieldForm(searchToggle: searchToggle,):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new GestureDetector(
                child: Container(
                  child: Text("Menu"),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Text("New music"),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Text("Favorites"),
                ),
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: searchToggle,
                      child: Container(child: Icon(Icons.search),)),
                  new GestureDetector(
                    child: Container(
                      child: Text("Search"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
