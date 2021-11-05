import 'package:afromuse/pages/Homebody/Homepagebody.dart';
import 'package:afromuse/pages/drawer/albums.dart';
import 'package:afromuse/pages/drawer/artists.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/pages/drawer/download.dart';
import 'package:afromuse/pages/drawer/login.dart';
import 'package:afromuse/pages/drawer/musics.dart';
import 'package:afromuse/pages/drawer/playlist.dart';
import 'package:afromuse/pages/drawer/setting.dart';
import 'package:afromuse/pages/drawer/suggestion.dart';
import 'package:afromuse/pages/drawer/terms_and_conditions.dart';
import 'package:afromuse/pages/favorite/showFavorite.dart';
import 'package:afromuse/pages/latest/Latest.dart';
import 'package:afromuse/pages/local/displayAlbumContain.dart';
import 'package:afromuse/pages/local/displayPlaylistContain.dart';
import 'package:afromuse/pages/local/library.dart';
import 'package:afromuse/pages/recent/recentPlayed.dart';
import 'package:flutter/cupertino.dart';

/////// Homepage Widgets List ////////////////////

List<Widget> homepageWidgets = [
  Homepagebody(), // main homepage index 0
  Latest(),       // new albums, songs index 1
  ShowFavorite(), // show the favorite songs of the User index 2
  RecentPlayed(), // all the 40 songs played   index 3
  Local(),        // all the internal songs, album, artists of the device   index 4
  Artists(),       // index 5
  Musics(),// index 6
  Album(),// index 7
  Categories(),   // different genre of music// index 8
  Playlist(),// index 9
  Suggestion(),// index 10
  Download(),// index 11
  Setting(),// index 12
  Login(),// index 13
  TermCondition(),// index 14
  DisplayPlaylistContain(), // Display the contain of a local playlist// index 15
  DisplayAlbumContain(),  // Display the contain of a local album// index 16
];

/////// Library Widgets List ////////////////////





/////// Homepage Widgets List ////////////////////




/////// Homepage Widgets List ////////////////////





/////// Homepage Widgets List ////////////////////






/////// Homepage Widgets List ////////////////////





/////// Homepage Widgets List ////////////////////