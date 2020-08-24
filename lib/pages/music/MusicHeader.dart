import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/searchBar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';

class MusicHeader extends StatefulWidget {
  bool isPlaying;
  bool isClicked;
  int index;
  AudioPlayer audioPlayer;
  List<DocumentSnapshot> document;
  MusicHeader(this.isPlaying, this.document, this.index, this.audioPlayer, this.isClicked);
  @override
  _MusicHeaderState createState() => _MusicHeaderState();
}

class _MusicHeaderState extends State<MusicHeader> {

  bool isSearchField = false;
//  AudioPlayer _audioPlayer = new AudioPlayer();
  bool playNow = true;
  bool isClicked = false;
  Duration _duration  = new Duration();
  Duration _position = new Duration();
  int _minute;
  int _second;

  void searchToggle(){
    setState(() {
      isSearchField = !isSearchField;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_audioPlayer.play(widget.document['contentUrl'], isLocal: false);
  }

  @override
  Widget build(BuildContext context) {
    if(playNow){
      setState(() {
        isClicked = widget.isClicked;
      });
    }else {
      if(isClicked != widget.isClicked){
        setState(() {
          isClicked = true;
        });
      }
    }
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
          Container(
            height: ScreenUtil().setWidth(100),
            child: Marquee(text: widget.document[widget.index]['title']),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.skip_previous,),
                  onPressed: (){
                   new MusicPlayerClass( audioPlayer: widget.audioPlayer).stopMusic();
                    setState(() {
                      playNow = false;
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.fast_rewind,),
                  onPressed: (){
                   new MusicPlayerClass( audioPlayer: widget.audioPlayer).stopMusic();
                    setState(() {
                      playNow = false;
                    });
                  }
              ),
              playNow||isClicked?IconButton(
                icon: Icon(Icons.pause,),
                onPressed: (){
                  MusicPlayerClass(document: widget.document, audioPlayer: widget.audioPlayer).pauseMusic();
                  setState(() {
                    playNow = false;
                  });
                }
              ):IconButton(
                  icon: Icon(Icons.play_arrow,),
                  onPressed: (){
                    MusicPlayerClass(document: widget.document,audioPlayer: widget.audioPlayer, index: widget.index).playMusic();
                    setState(() {
                      playNow = true;
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.stop,),
                  onPressed: (){
                    MusicPlayerClass(audioPlayer: widget.audioPlayer).stopMusic();
                    setState(() {
                      playNow = false;
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.fast_forward,),
                  onPressed: (){
                    MusicPlayerClass(audioPlayer: widget.audioPlayer).stopMusic();
                    setState(() {
                      playNow = false;
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.skip_next,),
                  onPressed: (){
                    MusicPlayerClass(audioPlayer: widget.audioPlayer).stopMusic();
                    setState(() {
                      playNow = false;
                    });
                  }
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
