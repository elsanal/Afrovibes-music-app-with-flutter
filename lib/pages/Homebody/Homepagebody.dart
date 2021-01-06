import 'package:afromuse/pages/Homebody/NewAlbum.dart';
import 'package:afromuse/pages/Homebody/RecentPlay.dart';
import 'package:afromuse/pages/Homebody/ShowAlbum.dart';
import 'package:afromuse/pages/Homebody/ShowArtist.dart';
import 'package:afromuse/pages/Homebody/Suggestion.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'PopularSong.dart';


class Homepagebody extends StatefulWidget {
  @override
  _HomepagebodyState createState() => _HomepagebodyState();
}

class _HomepagebodyState extends State<Homepagebody> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.grey[270]
            ),
            width: width,
            height: height,
            child: ListView(
              shrinkWrap: true,
              //physics: ClampingScrollPhysics(),
              children: <Widget>[
                Row(
                  children: [
                    Expanded(child: AlbumRow()),
                  ],
                ),
                Row(
                  children: [
                  Expanded(child: RecentlyPlayed())
                ],
                ),
                Row(
                  children: [
                    Expanded(child: Artist()),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Suggestion())
                  ],
                ),
                Row(
                  children: [
                  Expanded(child: PopularSongs())
                ],
                ),
                Row(
                  children: [
                    Expanded(child: NewAlbum())
                  ],
                ),
                new Container(height: 120,)
              ],
            ),
          )
      ),
    );
  }
}






















