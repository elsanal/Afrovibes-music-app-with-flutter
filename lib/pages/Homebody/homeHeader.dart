import 'package:afromuse/sharedPage/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

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
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(20),
      ),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      width: Width,
      height: ScreenUtil().setHeight(height*(2/3)),
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
                  child: Text("New musics"),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Text("New videos"),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new GestureDetector(
                child: Container(
                  child: Text("Favorites"),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Text("Playlists"),
                ),
              ),
              new GestureDetector(
                child: Container(
                  child: Text("isLive"),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
