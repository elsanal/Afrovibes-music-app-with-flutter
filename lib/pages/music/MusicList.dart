import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfMusic extends StatefulWidget {
  DocumentSnapshot document;
  ListOfMusic({this.document});
  @override
  _ListOfMusicState createState() => _ListOfMusicState();
}

class _ListOfMusicState extends State<ListOfMusic> {


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final mediaquery = MediaQuery.of(context).size;
    return  new Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setSp(20),
      ),
      padding: EdgeInsets.only(
        left: ScreenUtil().setSp(20),
        right: ScreenUtil().setSp(20),
        top: ScreenUtil().setSp(20),
        bottom: ScreenUtil().setSp(20),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              ScreenUtil().setHeight(50)
          )
      ),

      width: mediaquery.width,
      child: new Row(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                child: CircleAvatar(
                  backgroundImage: new AssetImage(
                      'assets/profile.jpeg'),
                ),
              ),
              new SizedBox(
                width: 5,
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: <Widget>[
                    new Text('artiste',
                      overflow: TextOverflow.ellipsis,
                    ),
                    new Text(widget.document['Album'],)
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: new Container(
                height: ScreenUtil().setWidth(100),
                child: Marques(widget.document['title'])
            ),
          ),
          SizedBox(width: 1,),
          SizedBox(width: 1,)
        ],
      ),
    );
  }
}


