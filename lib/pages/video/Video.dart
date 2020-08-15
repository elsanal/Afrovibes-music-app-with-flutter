import 'package:afromuse/pages/video/VideoHeader.dart';
import 'package:afromuse/pages/video/VideoList.dart';
import 'package:afromuse/staticPage/content.dart';
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
//    ScreenUtil.init(height: 1920,width: 1080);
    final mediaquery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                new VideoHeader(),
                Expanded(child: Center(child: new VideoList(Artists: Artists,)))
              ],
            ),
          )
      ),
    );
  }
}

//
//return Scaffold(
//body: Container(
//child: ListView(
//children: <Widget>[
//new Container(
//color: Colors.grey,
//width: mediaquery.width,
//child: new Row(
//children: <Widget>[
//new Row(
//children: <Widget>[
//new Container(
//child: CircleAvatar(
//backgroundImage: new AssetImage('assets/profile.jpeg'),
//),
//),
//new Column(
//children: <Widget>[
//new Text("Author"),
//new Text('country')
//],
//),
//],
//),
//Expanded(
//child: new Container(
//child: Center(child: Text("Film name")),
//),
//),
//IconButton(
//icon: Icon(Icons.more_vert),
//onPressed: null)
//],
//),
//),
//new Container(
//color: Colors.redAccent,
//height: mediaquery.width*(4/7),
//),
//Container(
//color: Colors.grey,
//child: new Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//new Container(
//child: IconButton(
//icon: Icon(Icons.thumb_up),
//onPressed: null),
//),
//new Container(
//child: Text('Comments'),
//),
//new Container(
//child: IconButton(
//icon: Icon(Icons.favorite_border),
//onPressed: null),
//)
//],
//),
//)
//],
//),
//)
//);

