import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(height: 1920,width: 1080);
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            new Container(
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
                          new Text("Author"),
                          new Text('country')
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
                      icon: Icon(Icons.more_vert),
                      onPressed: null)
                ],
              ),
            ),
            new Container(
              color: Colors.redAccent,
              height: mediaquery.width*(1/3),
              child: Center(
                child: IconButton(
                    icon: Icon(Icons.play_circle_outline,
                      size: ScreenUtil().setWidth(200),
                      color: Colors.white,
                    ),
                    onPressed: null)
              ),
            ),
            Container(
              color: Colors.grey,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    child: IconButton(
                          icon: Icon(Icons.thumb_up),
                          onPressed: null),
                  ),
                  new Container(
                    child: Row(
                      children: <Widget>[
                        Text('Comments'),
                        Icon(Icons.chat_bubble_outline,color: Colors.redAccent,)
                      ],
                    ),
                  ),
                  new Container(
                    child: IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: null),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
