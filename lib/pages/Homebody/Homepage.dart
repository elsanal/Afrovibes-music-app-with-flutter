import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/music/Music.dart';
import 'package:afromuse/pages/myInfo/Mepage.dart';
import 'package:afromuse/pages/radio/Radio.dart';
import 'package:afromuse/pages/streaming/InLive.dart';
import 'package:afromuse/pages/video/Video.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _currentIndex = 1;


  List<Widget> pageList = [Homepagebody(), Music(),
    Video(), LiveStream(), RadioFm(), Mepage()];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: gradient
        ),
        child: pageList[_currentIndex],
      ),
      bottomNavigationBar: _bottomBar(context,),
    );
  }


  _bottomBar(context,) {
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
                        Icons.home_sharp, Music(), false, 'Home', 0, ),
                    _bottomItems(
                        Icons.queue_music_outlined, Music(), false, 'Music', 1,),
                    _bottomItems(
                        Icons.my_library_music_rounded, Music(), false, '', 2,),
                    _bottomItems(
                        Icons.video_collection_outlined, Music(), false, 'videos', 3, ),
                    _bottomItems(
                        Icons.new_releases_outlined, Music(), false, 'Latest',
                        4,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  _bottomItems(IconData icon, Widget widget, bool active, String title,
      int index,) {
    return Container(
      child: InkWell(
        onTap: () {

          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          children: [
            Icon(icon, color: Colors.black, size: ScreenUtil().setWidth(90),),
            title != '' ? new Text(title) : SizedBox(height: 0,),
          ],
        ),
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

    // path.cubicTo(3*sw/12, 0, 3*sw/12 , 0, 4*sw/12,0);
    // path.cubicTo(6*sw/12, 0, 6*sw/12 , 0, 6*sw/12,0);
    // path.cubicTo(5*sw/12, 0, 5*sw/12 , 7*sh/8, 6*sw/12,7*sh/8);
    // path.cubicTo(7*sw/12, 7*sh/8, 7*sw/12 , 0, 7*sw/12, 0);
    // path.cubicTo(9*sw/12, 0, 9*sw/12 , 0, 10*sw/12,0);
    // path.cubicTo(11*sw/12, 0, 11*sw/12 , 0, sw,0);
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
