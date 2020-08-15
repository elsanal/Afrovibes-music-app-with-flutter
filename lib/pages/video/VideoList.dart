import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoList extends StatefulWidget {
  final List<Map<String, String>> Artists;
  VideoList({this.Artists});
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    ScreenUtil.init(context);
    return Container(
      color: Colors.white,
      child: GridView.builder(
        itemCount: widget.Artists.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: ScreenUtil().setSp(10),
            childAspectRatio: 0.7,
            crossAxisCount:(orientation == Orientation.portrait)?2:3),
        itemBuilder: (BuildContext context, index){
          return Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(ScreenUtil().setHeight(30)),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: gradient,
                  border: Border.all(
                      width: 1,
                      color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(
                      ScreenUtil().setHeight(30)
                  )
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new Image.asset("assets/profile.jpeg", fit: BoxFit.contain,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setSp(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Artist : " + widget.Artists[index]['artist']),
                        Text("Title   : "+ widget.Artists[index]['title']),
                        Text("Type   : "+ widget.Artists[index]['type']),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
