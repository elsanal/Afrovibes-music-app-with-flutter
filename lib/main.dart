import 'package:afromuse/authentification/authentify.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/pages/music/Music.dart';
import 'package:afromuse/pages/myInfo/Mepage.dart';
import 'package:afromuse/pages/myInfo/MyPosts.dart';
import 'package:afromuse/pages/radio/Radio.dart';
import 'package:afromuse/pages/streaming/InLive.dart';
import 'package:afromuse/pages/video/Video.dart';
import 'package:afromuse/services/auth.dart';
import 'package:afromuse/services/settings.dart';
import 'package:afromuse/services/userModel.dart';
import 'package:afromuse/uploadFile/filePicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenficationService().user,
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AfroVibes',
        home: Authentify(),
        routes: {
          '/home' : (context)=>Homepage(),
          '/music' : (context)=>Music(),
          '/video' : (context)=>Video(),
          '/direct' : (context)=>LiveStream(),
          '/radio' : (context)=>RadioFm(),
          '/account' : (context)=>Mepage(),
          '/setting' : (context)=>Settings(),
          '/myPost' : (context)=>MyPosts(),
          '/pickFile':(context)=>PickFile()
        },
      ),
    );
  }
}



