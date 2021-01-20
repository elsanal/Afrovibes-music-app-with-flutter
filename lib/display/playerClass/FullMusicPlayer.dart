import 'package:afromuse/display/playerClass/PlayerSwiper.dart';
import 'package:afromuse/pages/Homebody/ShowAlbum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class FullMusicPlayer extends StatefulWidget {
  @override
  _FullMusicPlayerState createState() => _FullMusicPlayerState();
}

class _FullMusicPlayerState extends State<FullMusicPlayer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.orange[800],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black87,
          body: Container(
              height: heigth,
              width: width,
              child: Card(
                elevation: 5,
                child: Stack(children: [
                  Positioned(
                    left: 8,
                      top: 0,
                      child: IconButton(
                          icon: Icon(Icons.expand_more, size: 40,),
                          onPressed: ()=>Navigator.of(context).pop(true))
                  ),
                  Positioned(
                    right: 8,
                      top: 0,
                      child: Icon(Icons.queue_music_sharp, size: 40,)),
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 250,
                      child: Card(
                        color: Colors.red,
                      )),
                  Positioned(
                    top: 50,
                      child: PlayerSwiper()),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 175,
                    child: Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text("05:40"),
                          new Text("03:02"),
                        ],),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 140,
                    child: Slider(
                        max: 5,
                        min: 0,
                        value: 3,
                        onChanged: null),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 80,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        new Icon(Icons.loop_outlined),
                        new Icon(Icons.skip_previous_rounded),
                        new Icon(Icons.play_circle_outline),
                        new Icon(Icons.skip_next_rounded),
                        new Icon(Icons.shuffle_rounded),
                      ],),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        new Icon(Icons.playlist_add_rounded),
                        new Icon(Icons.share),
                        new Icon(Icons.download_outlined),
                        new Icon(Icons.mode_comment_outlined),
                        new Icon(Icons.favorite_border_outlined),
                      ],),
                  ),
                ],),
              ),
            ),
          ),
      ),
    );
  }
}
