import 'dart:async';
import 'dart:typed_data';

import 'package:afromuse/display/playerClass/DragScrollablePlayer.dart';
import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/pages/local/allFolders.dart';
import 'package:afromuse/pages/local/allSongs.dart';
import 'package:afromuse/pages/local/playlist.dart';
import 'package:afromuse/sharedPage/TopMenu.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/constant.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class Local extends StatefulWidget {
  @override
  _LocalState createState() => _LocalState();
}
int _selectedIndex = 0;


class _LocalState extends State<Local> {

  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                color: Colors.black,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: (){
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: topMenu('All Songs',0,_selectedIndex, context)
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: topMenu('Folders',1, _selectedIndex, context)
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            _selectedIndex = 3;
                          });
                        },
                        child: topMenu('Playlists',3, _selectedIndex, context)
                    ),
                  ],),
              ),
            ),
            Positioned(
              top: 50,
              child: Center(
                child: new Container(
                  color: Colors.grey[200],
                  child: _selectedIndex ==0 ? LocalSongs():
                  _selectedIndex==1?LocalAlbums():Playlist(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








