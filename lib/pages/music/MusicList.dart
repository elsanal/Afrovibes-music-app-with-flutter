import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        decoration: BoxDecoration(
            gradient: gradient
        ),
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
                padding:EdgeInsets.only(
                  left: ScreenUtil().setSp(20),
                  right: ScreenUtil().setSp(20),
                  top: ScreenUtil().setSp(20),
                  bottom: ScreenUtil().setSp(20),
                ) ,
//                decoration: BoxDecoration(
//                  gradient: gradient
//                ),
                color: Colors.white,
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
                        new SizedBox(
                          width: 5,
                        ),
                        Container(
                          width : ScreenUtil().setWidth(300),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(widget.musicList[index],
                                overflow: TextOverflow.ellipsis,
                              ),
                              new Text('album',)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: new Container(
                        child: Center(
                          child: Text("Music title, this should be moving "
                            "from right to left",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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


