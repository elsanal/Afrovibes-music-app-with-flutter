import 'package:afromuse/authentification/authentify.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/pages/local/playlist.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/auth.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/services/settings.dart';
import 'package:afromuse/services/userModel.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';




Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().readDataPrefs();
  recentPlayedMusic = await Sqlite(dataBaseName: singleDatabase,
      tableName: RECENT_PLAYED_TABLE).retrieveMusic();
  recentPlayedMusic.forEach((element) {
    print(element.file);
  });
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
  @override
  void initState() {
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




