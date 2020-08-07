import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/music/Music.dart';
import 'package:afromuse/pages/myInfo/Mepage.dart';
import 'package:afromuse/pages/streaming/InLive.dart';
import 'package:afromuse/pages/video/Video.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _currentIndex = 0;


  List<Widget> pageList=[Homepagebody(),Music(),LiveStream(),
   Video(),Mepage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pageList[_currentIndex],
      ),
//      bottomNavigationBar: BottomNavigationBar(
//          items: <BottomNavigationBarItem>[
//            new BottomNavigationBarItem(
//                icon: Icon(Icons.home),
//              title: Text("Home"),
//            ),
//            new BottomNavigationBarItem(
//              icon: Icon(Icons.library_music),
//              title: Text("Music"),
//            ),
//            new BottomNavigationBarItem(
//              icon: Icon(Icons.live_tv),
//              title: Text("Direct"),
//            ),
//            new BottomNavigationBarItem(
//              icon: Icon(Icons.video_library),
//              title: Text("Video"),
//            ),
//            new BottomNavigationBarItem(
//              icon: Icon(Icons.account_circle),
//              title: Text("Me"),
//            ),
//          ],
//        selectedItemColor: Colors.redAccent,
//        unselectedItemColor: Colors.black,
//        currentIndex: _currentIndex,
//        selectedLabelStyle: TextStyle(),
//        type: BottomNavigationBarType.fixed,
//        onTap: (index){
//            setState(() {
//              _currentIndex = index;
//            });
//        },
//      ),
    );
  }
}
