import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  bool isSearchField = false;
  bool isMenu = false;

  void searchToggle(){
    setState(() {
      isSearchField = !isSearchField;
    });
  }
  void menuToggle(){
    setState(() {

      isMenu = !isMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    ScreenUtil.init(width: 1080, height: 1920);
    return isMenu?Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      width: Width,
      height: ScreenUtil().setHeight(height*(2/3)),
      decoration: BoxDecoration(
          gradient: gradient,
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
                  child: IconButton(
                      icon: Icon(Icons.cancel), 
                      onPressed:menuToggle
                  ),
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
    ):Container(
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(50),
        right: ScreenUtil().setWidth(50),
        top: ScreenUtil().setWidth(30),
        bottom: ScreenUtil().setWidth(30),
      ),
      width: Width,
      decoration: BoxDecoration(
          //gradient: gradient,
          color: Colors.white,
//          border: Border.all(
//              width: 1,
//              color: Colors.redAccent
//          ),
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
                onTap: menuToggle,
                child: Container(
                  child: Text("Menu")
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: GestureDetector(
                        onTap: searchToggle,
                        child: Icon(Icons.search)),),
                  new Container(
                    child: GestureDetector(
                      onTap: searchToggle,
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
