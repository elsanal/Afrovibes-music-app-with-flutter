import 'package:afromuse/display/playerClass/MusicPlayer.dart';
import 'package:afromuse/display/playerClass/PlayerMainScreen.dart';
import 'package:afromuse/pages/Homebody/BottomBar.dart';
import 'package:afromuse/pages/Homebody/Drawer.dart';
import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/pages/favorite/showFavorite.dart';
import 'package:afromuse/pages/latest/Latest.dart';
import 'package:afromuse/pages/local/displayAlbumContain.dart';
import 'package:afromuse/pages/local/displayPlaylistContain.dart';
import 'package:afromuse/pages/local/library.dart';
import 'package:afromuse/pages/recent/recentPlayed.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {

  List<Widget> pageList = [
    Homepagebody(),
    Latest(),
    ShowFavorite(),
    RecentPlayed(),
    Local(),
    Categories(),
    DisplayPlaylistContain(),
    DisplayAlbumContain(),
  ];
  int iconSize = 30;
  int iconSizePlay = 160;
  bool _isFull = false;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
// TODO: implement dispose
    setState(() {
      releasePlayer.value = true;
    });
    super.dispose();
  }
  @override
  void initState() {
    _isFull = isFull.value;
// TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height ;
    return ScreenUtilInit(
        designSize: Size(width, height),
        allowFontScaling: true,
      builder: () {
        return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black.withOpacity(0.9),
            drawer: mainDrawer(),
            body: WillPopScope(
              onWillPop: (){
                return showDialog(
                    context: context,
                    builder: (context) =>
                        AlertDialog(title: Text('Are you leaving YenMusic?'), actions: <Widget>[
                          RaisedButton(
                            child: Text('yes'),
                            onPressed: ()async{
                              releasePlayer.value = true;
                              List<MediaItem> musicList = new List();
                              List<MediaItem> recentMusic = new List();
                              bool prefsSaved = await Preferences().autoSavePlayerCurrentInfo();
                              currentPlayingList.value.forEach((song){
                                musicList.add(song);
                              });
                              myRecentPlayed.value.forEach((song) {
                                recentMusic.add(song);
                              });
                              bool sqliteSaved = await Sqlite(dataBaseName: CURRENT_PLAYING_DB,
                                  tableName: CURRENT_PLAYING_TABLE).saveSqliteDB(musicList);
                              bool sqliteRecent = await Sqlite(dataBaseName: RECENT_PLAYED_DB, tableName: RECENT_PLAYED_TABLE)
                                  .saveSqliteDB(recentMusic);
                              if(prefsSaved && sqliteSaved & sqliteRecent){
                                Navigator.of(context).pop(true);
                              }
                            },),
                          RaisedButton(
                              child: Text('cancel'),
                              onPressed: () => Navigator.of(context).pop(false)),
                        ]));
              },
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark.copyWith(
                    statusBarColor: Colors.white.withOpacity(0),
                  systemNavigationBarColor: Colors.white,
                  systemNavigationBarIconBrightness: Brightness.dark
                ),
                child: AudioServiceWidget(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                      ),
                      child: Stack(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _myAppBar(),
                              Container(
                                color: Colors.white,
                                height: height,
                                padding: EdgeInsets.only(
                                    bottom: 50
                                ),
                                child: ValueListenableBuilder(
                                  valueListenable: HomepageCurrentIndex,
                                  builder: (context, value, widget){
                                    return pageList[value];
                                  },
                                ),
                              ),
                            ],
                          ),
                          ValueListenableBuilder(
                          valueListenable: isTapedToPlay,
                          builder: (context, value, widget){
                            if(value == true){
                              return MusicPlayer();
                            }else{
                              return Container();
                            }
                          },
                          ),
                          Positioned(
                            bottom: 0,
                            child: ValueListenableBuilder(
                              valueListenable: isFull,
                              builder: (context, value, widget){
                                if(value == true){
                                  _isFull = true;
                                  return bottomBar(context, HomepageCurrentIndex.value, iconSize);
                                }else{
                                 _isFull = false;
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
              ),
            ),
        );
      }
    );
  }
  Widget _myAppBar(){
    return ValueListenableBuilder(
        valueListenable: isFull,
        builder: (context, value, widget){
          if(value == true){
            return AppBar(
              elevation: 0,
              centerTitle: true,
              title: ValueListenableBuilder(
                valueListenable: HomepageCurrentIndex,
                builder: (context, value, widget){
                  return Text(appBArTitle.value, style: TextStyle(
                      color: Colors.black
                  ),);
                },
              ),
              backgroundColor:Colors.white,
              leading:IconButton(
                  icon:Icon(Icons.menu,color: Colors.black,),
                  onPressed:()=>scaffoldKey.currentState.openDrawer()
              ),
              actions: [
                IconButton(
                    icon:Icon(Icons.search, color: Colors.black,),
                    onPressed: (){}
                ),
                SizedBox(width: 8,)
              ],
            );
          }else{
            return Container();
          }
        });
  }
}


