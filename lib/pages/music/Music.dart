import 'package:afromuse/pages/music/Header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {

  List<String> musicList = ["Maitre Gims", "Floby","Maitre Gims",
                          "Floby", "ALif Naba", "AMY", "ALif Naba", "AMY",
                           "Maitre Gims", "Floby","Maitre Gims",
                           "Floby", "ALif Naba", "AMY", "ALif Naba", "AMY",];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(height: 1920,width: 1080);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              new MusicHeader(),
              new Expanded(child: new ListOfMusic(musicList: musicList,)),
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfMusic extends StatefulWidget {
  List<String> musicList;
  ListOfMusic({this.musicList});
  @override
  _ListOfMusicState createState() => _ListOfMusicState();
}

class _ListOfMusicState extends State<ListOfMusic> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(height: 1920,width: 1080);
    final mediaquery = MediaQuery.of(context).size;
    return  Scaffold(
      body: Container(
        child: new ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: widget.musicList.length,
            itemBuilder:(context, index){
              return  new Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setSp(20),
                  right: ScreenUtil().setSp(20),
                  bottom: ScreenUtil().setSp(20),
                ),
                color: Colors.grey,
                width: mediaquery.width,
                child: new Row(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                          child: CircleAvatar(
                            backgroundImage: new AssetImage('assets/profile.jpeg'),
                          ),
                        ),
                        new Column(
                          children: <Widget>[
                            new Text(widget.musicList[index]),
                            new Text('album')
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: new Container(
                        child: Center(child: Text("Music title")),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: null),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}


