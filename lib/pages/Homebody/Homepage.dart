import 'package:afromuse/display/playerClass/DragScrollablePlayer.dart';
import 'package:afromuse/pages/Homebody/Drawer.dart';
import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/favorite/showFavorite.dart';
import 'package:afromuse/pages/latest/Latest.dart';
import 'package:afromuse/pages/local/local.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/pages/recent/recentPlayed.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticPage/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _currentIndex = 0;
  String Title = "Home";


  List<Widget> pageList = [Homepagebody(), Latest(),ShowFavorite(),
    RecentPlayed(),Local()];

  int iconSizeDefault = 70;
  int iconSizePlay = 160;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.orange[800],
      appBar: AppBar(
        centerTitle: true,
        title: Text(Title),
        backgroundColor: Colors.orange[800],
        leading:IconButton(
            icon:Icon(Icons.menu,color: Colors.black,),
            onPressed:()=>scaffoldKey.currentState.openDrawer()
        ),
        actions: [
          Icon(Icons.search, color: Colors.white,),
          SizedBox(width: 8,)
        ],
      ),
      drawer: mainDrawer(),
      body: Container(
           height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: gradient
        ),
        child: Stack(
            children: [
              pageList[_currentIndex],
              isTapedToPlay? Dragger(height: height-184,width: width,selectedSong: selectedSong,)
                  :Container(),
              Positioned(
                bottom: 0.0,
                  child:_bottomBar(context, _currentIndex),
              ),
            ],
        ),
      ),
      //bottomNavigationBar: _bottomBar(context,_currentIndex),
    );
  }


  _bottomBar(context,int _currentIndex) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(170),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 5
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomItems(
              Icons.home_outlined,Icons.home_sharp,'Home', 0,iconSizeDefault),
            _bottomItems(
              Icons.new_releases_outlined,Icons.new_releases,'Hotest', 1,iconSizeDefault),
            _bottomItems(
                Icons.favorite_border_outlined,Icons.favorite_rounded,'Favorite', 2,iconSizeDefault),
            _bottomItems(
              Icons.watch_later_outlined,Icons.watch_later,'Recent', 3,iconSizeDefault),
            _bottomItems(
                Icons.folder_outlined,Icons.folder_rounded,'Library', 4,iconSizeDefault),
          ],
        ),
      ),
    );
  }


  _bottomItems(IconData icon_outlined, IconData icon_filled, String title, int index,int iconSize) {
    return Container(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
            Title = title;
          });
        },
        child: Column(
          children: [
            _currentIndex == index?Icon(icon_filled,
              color: Colors.redAccent,
              size: ScreenUtil().setWidth(90),
            ):Icon(icon_outlined,
              color: Colors.black,
              size: ScreenUtil().setWidth(iconSizeDefault),
            ),
            title != '' ? new Text(title,style: GoogleFonts.roboto(textStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: _currentIndex == index?Colors.redAccent:Colors.black,
            )),)
             : SizedBox(height: 0,),
          ],
        )
      ),
    );
  }

  Widget _appBar(){
    return Container(
      margin: EdgeInsets.only(
        top: 0
      ),
      color : Colors.orange[800],
      child: ListTile(
        // centerTitle: true,
        title: Text(Title),
        // backgroundColor: Colors.orange[800],
        leading:IconButton(
            icon:Icon(Icons.menu,color: Colors.black,),
            onPressed:()=>scaffoldKey.currentState.openDrawer()
        ),
        trailing: Icon(Icons.search, color: Colors.white,),
      ),
    );
  }

}


class _bottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    path.lineTo(sw, sh);
    path.addOval(Rect.fromCircle(
        center: Offset(48.55*sw/100,sh/2),radius: ScreenUtil().setWidth(90)));

    path.lineTo(sw, sh);
    //path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}