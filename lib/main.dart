import 'package:afromuse/authentification/authentify.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/pages/local/playlist.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/auth.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/services/settings.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';


List<SystemUiOverlay> overlays = [SystemUiOverlay.top];

Future<void> main() async{
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,]);
  WidgetsFlutterBinding.ensureInitialized();
  bool ready = await restoreValue();
  if(ready){
    runApp(MyApp());
  }
}

Future<bool> restoreValue()async{
  await Preferences().readDataPrefs();
  currentPlayingList.value = await Sqlite(dataBaseName: CURRENT_PLAYING_DB,
      tableName: CURRENT_PLAYING_TABLE).retrieveMusic();
  myRecentPlayed.value = await Sqlite(dataBaseName: RECENT_PLAYED_DB,
      tableName: RECENT_PLAYED_TABLE).retrieveMusic();
  myFavorite.value = await Sqlite(dataBaseName: FAVORITE_DB,
      tableName: FAVORITE_TABLE).retrieveMusic();
  myPlaylist.value = await Sqlite(dataBaseName: PLAYLIST_DB,
      tableName: PLAYLIST_TABLE).retrieveMusic();
  return true;
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




