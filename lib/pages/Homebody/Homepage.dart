import 'package:afromuse/display/playerClass/DragScrollablePlayer.dart';
import 'package:afromuse/display/playerClass/FullMusicPlayer.dart';
import 'package:afromuse/display/playerClass/MusicPlayer.dart';
import 'package:afromuse/display/playerClass/PlayerMainScreen.dart';
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
import 'package:google_fonts/google_fonts.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}
appBarTitleFunc(int pageIndex){
  if(pageIndex == 0){
    appBArTitle.value = 'Home';
  }else if(pageIndex == 1){
    appBArTitle.value = 'Hotest';
  }else if(pageIndex == 2){
    appBArTitle.value = 'Favorite';
  }else if(pageIndex == 3){
    appBArTitle.value = 'Recent';
  }else if(pageIndex == 4){
    appBArTitle.value = 'Library';
  }else if(pageIndex == 5){
    appBArTitle.value = 'Category';
  }else{
    appBArTitle.value = 'Error';
  }
  return appBArTitle.value;
}

class _HomepageState extends State<Homepage> {

  List<Widget> pageList = [
    Homepagebody(),
    Latest(),
    ShowFavorite(),
    PlayerMainScreen(),
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


  @override
  Widget build(BuildContext context){
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height ;
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
                      // ValueListenableBuilder(
                      // valueListenable: isTapedToPlay,
                      // builder: (context, value, widget){
                      //   if(value == true){
                      //     return PlayerMainScreen();
                      //   }else{
                      //     return Container();
                      //   }
                      // },
                      // ),
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
        ),
    );
  }

  Widget _myAppBar(){
    return ValueListenableBuilder(
        valueListenable: isFull,
        builder: (context, value, widget){
          if(value == false){
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
                  onPressed: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context){
                      return PlayerMainScreen();
                    })
                  ),
                ),
                SizedBox(width: 8,)
              ],
            );
          }else{
            return Container();
          }
        });
  }

  _bottomBar(context,int _currentIndex) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(170),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.only(
            top: 5
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomItems(
                Icons.home_outlined,Icons.home_sharp,'Home', 0,iconSizeDefault),
            _bottomItems(
                Icons.new_releases_outlined,Icons.new_releases,'Latest', 1,iconSizeDefault),
            _bottomItems(
                Icons.favorite_border_outlined,Icons.favorite_rounded,'Favorite', 2,iconSizeDefault),
            _bottomItems(
                Icons.watch_later_outlined,Icons.watch_later,'Recent', 3,iconSizeDefault),
            _bottomItems(
                Icons.folder_outlined,Icons.folder_rounded,'Library', 4,iconSizeDefault),
          ],
        ),
      ),
    );
  }

  _bottomItems(IconData icon_outlined, IconData icon_filled, String title, int index,int iconSize) {
    return Container(
      child: InkWell(
          onTap: () {
            setState(() {
              HomepageCurrentIndex.value = index;
              appBarTitleFunc(index);
            });
          },
          child: ValueListenableBuilder(
            valueListenable: HomepageCurrentIndex,
            builder: (context, value, widget){
              return Column(
                children: [
                  value == index?Icon(icon_filled,
                    color: Colors.redAccent,
                    size: ScreenUtil().setWidth(90),
                  ):Icon(icon_outlined,
                    color: Colors.black,
                    size: ScreenUtil().setWidth(iconSizeDefault),
                  ),
                  title != '' ? new Text(title,style: GoogleFonts.roboto(textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: value == index?Colors.redAccent:Colors.black,
                  )),)
                      : SizedBox(height: 0,),
                ],
              );
            },

          )
      ),
    );
  }



}