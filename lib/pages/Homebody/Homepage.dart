import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/music/Music.dart';
import 'package:afromuse/pages/myInfo/Mepage.dart';
import 'package:afromuse/pages/radio/Radio.dart';
import 'package:afromuse/pages/streaming/InLive.dart';
import 'package:afromuse/pages/video/Video.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
          gradient: gradient
      ),
      child: pageList[_currentIndex],
    );
  }
}
