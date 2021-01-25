<<<<<<< Updated upstream
=======
import 'package:afromuse/display/playerClass/DragScrollablePlayer.dart';
import 'package:afromuse/display/playerClass/FullMusicPlayer.dart';
import 'package:afromuse/display/playerClass/MusicPlayer.dart';
import 'package:afromuse/pages/Homebody/Drawer.dart';
>>>>>>> Stashed changes
import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/music/Music.dart';
import 'package:afromuse/pages/myInfo/Mepage.dart';
import 'package:afromuse/pages/streaming/InLive.dart';
import 'package:afromuse/pages/video/Video.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
>>>>>>> Stashed changes

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

<<<<<<< Updated upstream
  int _currentIndex = 0;


  List<Widget> pageList=[Homepagebody(),Music(),LiveStream(),
   Video(),Mepage()];
=======
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
  int iconSizeDefault = 70;
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

  // void _playerToggle(){
  //   _showFullPlayer = !_showFullPlayer;
  // }

  @override
  Widget build(BuildContext context){

    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.orange[800],
      //appBar:_myAppBar(),
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
                          List<Music> musicList = new List();
                          List<Music> recentMusic = new List();
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
             value: SystemUiOverlayStyle.light.copyWith(
           statusBarColor: Theme.of(context).bottomAppBarColor
            ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white
                //gradient: gradient
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
                      if(value == false){
                        _isFull = false;
                        return _bottomBar(context, HomepageCurrentIndex.value);
                      }else{
                        _isFull = true;
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
      //bottomNavigationBar: _bottomBar(context,_currentIndex),
    );
  }
>>>>>>> Stashed changes


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradient
      ),
      child: pageList[_currentIndex],
    );
  }
<<<<<<< Updated upstream
=======
   Widget _myAppBar(){
    return ValueListenableBuilder(
        valueListenable: isFull,
        builder: (context, value, widget){
          if(value == false){
            return AppBar(
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
                Icon(Icons.search, color: Colors.black,),
                SizedBox(width: 8,)
              ],
            );
          }else{
            return Container();
          }
        });






   }


>>>>>>> Stashed changes
}
