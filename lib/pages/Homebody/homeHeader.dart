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
    ScreenUtil.init(context);
    return
//    return isMenu?Container(
//      padding: EdgeInsets.only(
//        left: ScreenUtil().setWidth(20),
//        right: ScreenUtil().setWidth(20),
//      ),
//      width: Width,
//      height: ScreenUtil().setHeight(height*(2/3)),
//      decoration: BoxDecoration(
//          gradient: gradient,
//          border: Border.all(
//              width: 1,
//              color: Colors.redAccent
//          ),
//          borderRadius: BorderRadius.circular(
//              ScreenUtil().setHeight(20)
//          )
//      ),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          isSearchField?TextFieldForm(searchToggle: searchToggle,):
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              new GestureDetector(
//                child: Container(
//                  child: IconButton(
//                      icon: Icon(Icons.cancel),
//                      onPressed:menuToggle
//                  ),
//                ),
//              ),
//              new GestureDetector(
//                child: Container(
//                  child: Text("New musics"),
//                ),
//              ),
//              new GestureDetector(
//                child: Container(
//                  child: Text("New videos"),
//                ),
//              ),
//              Row(
//                children: <Widget>[
//                  GestureDetector(
//                      onTap: searchToggle,
//                      child: Container(child: Icon(Icons.search),)),
//                  new GestureDetector(
//                    child: Container(
//                      child: Text("Search"),
//                    ),
//                  ),
//                ],
//              )
//            ],
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              new GestureDetector(
//                child: Container(
//                  child: Text("Favorites"),
//                ),
//              ),
//              new GestureDetector(
//                child: Container(
//                  child: Text("Playlists"),
//                ),
//              ),
//              new GestureDetector(
//                child: Container(
//                  child: Text("isLive"),
//                ),
//              ),
//
//            ],
//          ),
//        ],
//      ),
//    ):

      Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(5),
          ),
            margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(2),
                      right: ScreenUtil().setWidth(2),
            ),
            width: Width,
            decoration: BoxDecoration(
              gradient: gradient,
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
                      child: Text("")
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
                          child: Text("Search", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),),
                        ),
                      ),
                      Container(width: ScreenUtil().setWidth(30)),
                    ],
                  )
                ],
              ),
                  Container(height: ScreenUtil().setWidth(15)),
                  new HoriListview(),
                  Container(height: ScreenUtil().setWidth(10)),
                  Container(height: ScreenUtil().setWidth(20),color: Colors.grey,)
        ],
      ),
    );
  }
}

class HoriListview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.orange,
      height: ScreenUtil().setWidth(200),
      child: new ListView(
        //shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
            onTap :(){
              Navigator.pushNamed(context, '/home');
            },
            child: new Container(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setWidth(120),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.home, color: Colors.black,
                        size: ScreenUtil().setWidth(100),),
                      new Text("Home", style: TextStyle(
                        color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap :(){
              Navigator.pushNamed(context, '/music');
            },
            child: new Container(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setWidth(120),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.library_music, color: Colors.black,
                        size: ScreenUtil().setWidth(100),),
                      new Text("Musics", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap :(){
              Navigator.pushNamed(context, '/video');
            },
            child: new Container(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setWidth(120),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.video_library, color: Colors.black,
                        size: ScreenUtil().setWidth(100),),
                      new Text("Videos", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap :(){
              Navigator.pushNamed(context, '/direct');
            },
            child: new Container(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setWidth(120),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.live_tv, color: Colors.black,
                        size: ScreenUtil().setWidth(100),),
                      new Text("Direct", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap :(){
              Navigator.pushNamed(context, '/radio');
            },
            child: new Container(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setWidth(120),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.radio, color: Colors.black,
                        size: ScreenUtil().setWidth(100),),
                      new Text("Radio", style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap :(){
              Navigator.pushNamed(context, '/account');
            },
            child: new Container(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setWidth(120),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.account_box, color: Colors.black,
                        size: ScreenUtil().setWidth(100),),
                      new Text("Account", style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          //new SizedBox(width: ScreenUtil().setWidth(20),),
          GestureDetector(
            onTap :(){
              Navigator.pushNamed(context, '/setting');
            },
            child: new Container(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ScreenUtil().setWidth(150),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.settings, color: Colors.black,
                        size: ScreenUtil().setWidth(100),),
                      Expanded(
                        child: new Text("Settings", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          new SizedBox(width: ScreenUtil().setWidth(20),),
        ],
      ),
    );
  }
}

