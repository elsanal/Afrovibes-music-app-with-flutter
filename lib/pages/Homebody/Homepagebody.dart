import 'package:afromuse/pages/Homebody/homeContent.dart';
import 'package:afromuse/pages/Homebody/homeHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepagebody extends StatefulWidget {
  @override
  _HomepagebodyState createState() => _HomepagebodyState();
}

class _HomepagebodyState extends State<Homepagebody> {

  List<Map<String, String>> Artists = [
    {'artist' : "Moussa", "title" : "la beauté", "type" : "audio"},
    {'artist' : "ali", "title" : "la vie", "type" : "video"},
    {'artist' : "Ousaa", "title" : "rien de bon", "type" : "streaming"},
    {'artist' : "Ousana", "title" : "ecouter", "type" : "video"},
    {'artist' : "Karim", "title" : "bientot", "type" : "video"},
    {'artist' : "amidou", "title" : "aurevoir", "type" : "audio"},
    {'artist' : "oscar", "title" : "Viens", "type" : "streaming"},
    {'artist' : "Mousa", "title" : "on va voir", "type" : "audio"},
    ];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 1080, height: 1920);
    final mediaquery = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              new HomeHeader(),
              Expanded(child: Center(child: new HomeContent(Artists: Artists,)))
            ],
          ),
        )
      ),
    );
  }
}
