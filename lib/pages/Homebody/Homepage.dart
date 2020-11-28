import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/latest/Latest.dart';
import 'package:afromuse/pages/local/local.dart';
import 'package:afromuse/pages/music/Music.dart';
import 'package:afromuse/pages/video/Video.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _currentIndex = 0;


  List<Widget> pageList = [Homepagebody(), Music(),Local(),
    Video(),Latest()];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        backgroundColor: Colors.orange[800],
        leading: Icon(Icons.menu, color: Colors.black,),
        actions: [
          Icon(Icons.search, color: Colors.white,),
          SizedBox(width: 8,)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: gradient
        ),
        child: pageList[_currentIndex],
      ),
      bottomNavigationBar: _bottomBar(context,_currentIndex),
    );
  }


  _bottomBar(context,int _currentIndex) {
    return Container(
      height: ScreenUtil().setHeight(235),
      child: Card(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: _bottomClipper(),
                child: Card(
                  elevation: 20,
                  color: Colors.white,
                  child: Container(
                    height: ScreenUtil().setHeight(190),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.redAccent,
                              Colors.yellow,
                              Colors.teal
                            ]
                        )
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: ScreenUtil().setWidth(40),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                //color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _bottomItems(
                      Icons.home_sharp,'Home', 0,),
                    _bottomItems(
                      Icons.queue_music_outlined,'Music', 1,),
                    _bottomItems(
                      Icons.my_library_music_rounded,'', 2,),
                    _bottomItems(
                      Icons.video_collection_outlined,'Videos', 3,),
                    _bottomItems(
                      Icons.new_releases_outlined,'Latest', 4,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  _bottomItems(IconData icon, String title, int index,) {

    return Container(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          children: [
            Icon(icon,
              color: _currentIndex == index?Colors.redAccent:Colors.black,
              size: ScreenUtil().setWidth(90),
            ),
            title != '' ? new Text(title,style: GoogleFonts.roboto(textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: _currentIndex == index?Colors.redAccent:Colors.black,
            )),)
             : SizedBox(height: 0,),
          ],
        )
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
    path.addOval(Rect.fromCircle(center: Offset(sw/2,sh/2),radius: ScreenUtil().setWidth(90)));

    path.lineTo(sw, sh);
    //path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}