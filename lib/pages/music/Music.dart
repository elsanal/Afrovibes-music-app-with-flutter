import 'package:afromuse/pages/music/MusicHeader.dart';
import 'package:afromuse/pages/music/MusicList.dart';
import 'package:afromuse/staticPage/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
   bool isPlaying = false;



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              new MusicHeader(isPlaying),
              new Container(color: Colors.white,height: 5,),
              new Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        isPlaying = true;
                      });
                    },
                      child: new ListOfMusic(musicList: musicList,)
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

