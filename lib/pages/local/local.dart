import 'dart:typed_data';

import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/pages/local/allFolders.dart';
import 'package:afromuse/pages/local/allSongs.dart';
import 'package:afromuse/pages/local/playlist.dart';
import 'package:afromuse/sharedPage/TopMenu.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class Local extends StatefulWidget {
  @override
  _LocalState createState() => _LocalState();
}
int selectedIndex = 0;
List myfavSong = [

  {
    'artist' : 'Maitre gims',
    'song_name': 'Tout donner',
    'category':'Hip-Hop',
    'duration' : '3:00',
    'album_name' : 'Subliminal',
    'rate' : 1.0,
    'num_part' :86,
    'num_view' : 12,
    'num_dld' : 25,
    'image' : 'maitregims.jpeg'
  },
  {
    'artist' : 'Awa Boussim',
    'song_name': 'Koregore',
    'category':'Kora',
    'duration' : '4:00',
    'album_name' : 'Philo',
    'rate' : 4.5,
    'num_part' :153,
    'num_view' : 756,
    'num_dld' : 32,
    'image' : 'awaboussim.jpeg'
  },
  {
    'artist' : 'Smarty',
    'song_name': 'Chapeau du chef',
    'category':'Rap',
    'duration' : '4:10',
    'album_name' : 'Single',
    'rate' : 5.0,
    'num_part' :43,
    'num_view' : 953,
    'num_dld' : 3204,
    'image' : 'smarty.jpeg'
  },
  {
    'artist' : 'Black M',
    'song_name': 'Sur ma route',
    'category':'Rap',
    'duration' : '3:30',
    'album_name' : 'La route',
    'rate' : 2.5,
    'num_part' :125,
    'num_view' : 354,
    'num_dld' : 75,
    'image' : 'blackm.jpeg'
  },
  {
    'artist' : 'Debordo Leekunfa',
    'song_name': 'Aperitif',
    'category':'Hip-Hop',
    'duration' : '3:00',
    'album_name' : 'Subliminal',
    'rate' : 1.0,
    'num_part' :86,
    'num_view' : 12,
    'num_dld' : 25,
    'image' : 'debordoleekunfa.jpeg'
  },
  {
    'artist' : 'Dez Altino',
    'song_name': 'Kabogde',
    'category':'Rap',
    'duration' : '3:30',
    'album_name' : 'La route',
    'rate' : 2.5,
    'num_part' :125,
    'num_view' : 354,
    'num_dld' : 75,
    'image' : 'dezaltino.jpeg'
  },
  {
    'artist' : 'Salif Keita',
    'song_name': 'Tekere',
    'category':'Rap',
    'duration' : '4:10',
    'album_name' : 'Single',
    'rate' : 5.0,
    'num_part' :43,
    'num_view' : 953,
    'num_dld' : 3204,
    'image' : 'salifkeita.jpeg'
  },
  {
    'artist' : 'Davido',
    'song_name': 'Chioma',
    'category':'Kora',
    'duration' : '4:00',
    'album_name' : 'Philo',
    'rate' : 4.5,
    'num_part' :153,
    'num_view' : 756,
    'num_dld' : 32,
    'image' : 'davido.jpeg'
  },
];









class _LocalState extends State<Local> {
  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final tle_cont_w = width*(1/3)-4;
    return Container(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.black,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: topMenu('All Songs',0,selectedIndex, context)
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: topMenu('Folders',1,selectedIndex, context)
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 3;
                          });
                        },
                        child: topMenu('Playlists',3,selectedIndex, context)
                    ),
                  ],),
              ),
              Expanded(
                  child: new Container(color: Colors.grey[200],
                    child:selectedIndex ==0 ? LocalSongs():
                    selectedIndex==1?LocalAlbums():Playlist(),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}








