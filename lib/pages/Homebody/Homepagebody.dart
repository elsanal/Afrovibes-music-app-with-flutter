import 'package:afromuse/pages/Homebody/NearBy.dart';
import 'package:afromuse/pages/Homebody/ShowAlbum.dart';
import 'package:afromuse/pages/Homebody/ShowArtist.dart';
import 'package:afromuse/pages/Homebody/Suggestion.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

import 'PopularSong.dart';


class Homepagebody extends StatefulWidget {
  @override
  _HomepagebodyState createState() => _HomepagebodyState();
}

class _HomepagebodyState extends State<Homepagebody> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
        designSize: Size(width, height),
        allowFontScaling: true,
      builder: () {
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
                        Expanded(child: Artist()),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: NearByUsers()),
                      ],
                    ),
                    new Container(height: 120,)
                  ],
                ),
              )
          ),
        );
      }
    );
  }
}






















