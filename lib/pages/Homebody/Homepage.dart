import 'package:afromuse/display/playerClass/DragScrollablePlayer.dart';
import 'package:afromuse/display/playerClass/FullMusicPlayer.dart';
import 'package:afromuse/pages/Homebody/Drawer.dart';
import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/favorite/showFavorite.dart';
import 'package:afromuse/pages/latest/Latest.dart';
import 'package:afromuse/pages/local/displayAlbumContain.dart';
import 'package:afromuse/pages/local/displayPlaylistContain.dart';
import 'package:afromuse/pages/local/library.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/pages/local/playlist.dart';
import 'package:afromuse/pages/recent/recentPlayed.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:flutter/material.dart';
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
    RecentPlayed(),
    Local(),
    Categories(),
    DisplayPlaylistContain(),
    DisplayAlbumContain(),
  ];
  int iconSizeDefault = 70;
  int iconSizePlay = 160;
  bool _showFullPlayer = false;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    setState(() {
      releasePlayer.value = true;
    });
    super.dispose();
  }

  void _playerToggle(){
    _showFullPlayer = !_showFullPlayer;
  }

  @override
  Widget build(BuildContext context){

    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.orange[800],
      appBar: AppBar(
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: HomepageCurrentIndex,
            builder: (context, value, widget){
              return Text(appBArTitle.value);
            },
        ),
        backgroundColor:Colors.orange[800],
        leading:IconButton(
            icon:Icon(Icons.menu,color: Colors.black,),
            onPressed:()=>scaffoldKey.currentState.openDrawer()
        ),
        actions: [
          Icon(Icons.search, color: Colors.white,),
          SizedBox(width: 8,)
        ],
      ),
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: gradient
          ),
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
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
                    return Dragger(height: height-184,
                      width: width,);
                  }else{
                    return Container();
                  }
                },
              ),
              Positioned(
                bottom: 0.0,
                child:_bottomBar(context, HomepageCurrentIndex.value),
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: _bottomBar(context,_currentIndex),
    );
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


class _bottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    path.lineTo(sw, sh);
    path.addOval(Rect.fromCircle(
        center: Offset(48.55*sw/100,sh/2),radius: ScreenUtil().setWidth(90)));

    path.lineTo(sw, sh);
    //path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}