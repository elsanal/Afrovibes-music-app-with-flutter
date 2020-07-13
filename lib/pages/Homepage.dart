import 'package:afromuse/pages/Homepagebody.dart';
import 'package:afromuse/pages/Mepage.dart';
import 'package:afromuse/pages/Music.dart';
import 'package:afromuse/pages/Video.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _currentIndex = 0;


  List<Widget> pageList=[Homepagebody(),Music(),
   Video(),Mepage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pageList[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              title: Text("Music"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              title: Text("Video"),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Me"),
            ),
          ],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        selectedLabelStyle: TextStyle(),
        type: BottomNavigationBarType.fixed,
        onTap: (index){
            setState(() {
              _currentIndex = index;
            });
        },
      ),
    );
  }
}
