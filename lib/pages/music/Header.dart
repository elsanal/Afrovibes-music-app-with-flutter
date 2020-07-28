import 'package:afromuse/sharedPage/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusicHeader extends StatefulWidget {
  @override
  _MusicHeaderState createState() => _MusicHeaderState();
}

class _MusicHeaderState extends State<MusicHeader> {

  bool isSearchField = false;

  void searchToggle(){
    setState(() {
      isSearchField = !isSearchField;
    });
  }


  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    ScreenUtil.init(width: 1080, height: 1920);
    return  Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      width: Width,
      height: ScreenUtil().setHeight(height*(9/10)),
      decoration: BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(
              width: 1,
              color: Colors.redAccent
          ),
          borderRadius: BorderRadius.circular(
              ScreenUtil().setHeight(20)
          )
      ),
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
                child: Container(
                  child: Icon(Icons.fast_rewind),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Icon(Icons.play_circle_outline),
                ),
              ),
              new GestureDetector(
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
    );
  }
}
