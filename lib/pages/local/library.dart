import 'dart:async';
import 'dart:typed_data';
import 'package:afromuse/pages/local/SongsFromAlbum.dart';
import 'package:afromuse/pages/local/allFolders.dart';
import 'package:afromuse/pages/local/allSongs.dart';
import 'package:afromuse/pages/local/displayAlbumContain.dart';
import 'package:afromuse/pages/local/displayPlaylistContain.dart';
import 'package:afromuse/pages/local/playlist.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:afromuse/sharedPage/TopMenu.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/sharedPage/createPlaylist.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/staticValues/constant.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class Local extends StatefulWidget {
  @override
  _LocalState createState() => _LocalState();
}



class _LocalState extends State<Local> {
  int _position ;

  List<Widget> libraryPages = [
    LocalSongs(),
    LocalAlbums(),
    Playlist(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ValueListenableBuilder(
          valueListenable: libraryCurrentPage,
          builder: (context, value, widget){
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    color: Colors.black87,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                            onTap: ()async{
                              _position = await Preferences().readScrollPosition(libraryAllSongsPositionKey);
                              libraryPages[0] = LocalSongs(position: _position,);
                              setState(() {
                                libraryCurrentPage.value = 0;
                              });
                            },
                            child: topMenu('All Songs',0,value, context)
                        ),
                        InkWell(
                            onTap: (){
                              setState(() {
                                libraryCurrentPage.value = 1;
                              });
                            },
                            child: topMenu('Folders',1, value, context)
                        ),
                        InkWell(
                            onTap: (){
                              setState(() {
                                libraryCurrentPage.value = 2;
                              });
                            },
                            child: topMenu('Playlists',2, value, context)
                        ),
                      ],),
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 0,
                  right: 0,
                  bottom:135,
                  child: Center(
                    child: new Container(
                        //color: Colors.grey[200],
                        child: libraryPages[value]
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}








