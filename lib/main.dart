import 'package:afromuse/authentification/authentify.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/pages/local/playlist.dart';
import 'package:afromuse/services/auth.dart';
import 'package:afromuse/services/settings.dart';
import 'package:afromuse/services/userModel.dart';
import 'package:afromuse/staticPage/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

void main() {
  //readDataPrefs();
  runApp(AfroApp());
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
          '/music' : (context)=>Categories(),
          '/setting' : (context)=>Settings(),
        },
      ),
    );
  }
}

class AfroApp extends StatefulWidget {
  @override
  _AfroAppState createState() => _AfroAppState();
}

class _AfroAppState extends State<AfroApp> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  Future getAllSongs()async{
    allInternalSongs.value = await audioQuery.getSongs(sortType: SongSortType.DEFAULT);
  }
  @override
  void initState() {
    readDataPrefs();
    //getSongs_data();
     getAllSongs();
     //appBarTitleFunc(pageCurrentIndex.value);
    //allInternalSongs = getSongs_data();
    // TODO: implement initState
    super.initState();
  }
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
          '/music' : (context)=>Categories(),
          '/setting' : (context)=>Settings(),
        },
      ),
    );
  }
}




