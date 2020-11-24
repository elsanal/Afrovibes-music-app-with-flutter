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

  int _currentIndex = 0;


  List<Widget> pageList=[Homepagebody(),Music(),
   Video(),LiveStream(),RadioFm(),Mepage()];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      // body: Container(
      //   decoration: BoxDecoration(
      //       gradient: gradient
      //   ),
      //   child: pageList[_currentIndex],
      // ),
      bottomNavigationBar: _bottomBar(context),
    );
  }
}

_bottomBar(context){
  return Container(
    child: Stack(
      children: [
        Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: _bottomClipper(),
              child: Container(
                height: ScreenUtil().setHeight(190),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white38, Colors.white60]
                  )
                ),
              ),
            )
        ),
        Positioned(
          bottom: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomItems(Icons.home_outlined,Homepagebody(), true),
                SizedBox(width: 12,),
                _bottomItems(Icons.settings_backup_restore, Music(), false),
                SizedBox(width: 20,),
                _bottomItems(Icons.play_circle_fill_outlined, Music(), false),
                SizedBox(width: 20,),
                _bottomItems(Icons.file_copy, Music(), false),
                SizedBox(width: 10,),
                _bottomItems(Icons.video_call, Music(), false),
              ],
            )
        ),
      ],
    ),
  );
}


_bottomItems(IconData icon, Widget widget, bool active){
  return Container(
    child: InkWell(
      child: Icon(icon,color: Colors.black,size: ScreenUtil().setWidth(180),),
    ),
  );
}


class _bottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    path.cubicTo(3*sw/12, 0, 3*sw/12 , 0, 4*sw/12,0);
    path.cubicTo(5*sw/12, 0, 5*sw/12 , 7*sh/8, 6*sw/12,7*sh/8);
    path.cubicTo(7*sw/12, 7*sh/8, 7*sw/12 , 0, 8*sw/12, 0);
    path.cubicTo(9*sw/12, 0, 9*sw/12 , 0, 10*sw/12,0);
    path.cubicTo(11*sw/12, 0, 11*sw/12 , 0, sw,0);

    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
