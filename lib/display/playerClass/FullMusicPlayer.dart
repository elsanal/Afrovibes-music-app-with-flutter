import 'package:afromuse/display/playerClass/PlayerSwiper.dart';
import 'package:afromuse/pages/Homebody/ShowAlbum.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class FullMusicPlayer extends StatefulWidget {
  @override
  _FullMusicPlayerState createState() => _FullMusicPlayerState();
}

class _FullMusicPlayerState extends State<FullMusicPlayer> {

  _func(){

  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: Colors.black87,
          body: Container(
              height: heigth,
              width: width,
              //color: Colors.black87,
              child: Stack(children: [
                Positioned(
                  left: 8,
                    top: 0,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                        onPressed: ()=>Navigator.of(context).pop(true))
                ),
                Positioned(
                  right: 8,
                    top: 10,
                    child: Icon(Icons.queue_music_sharp,color: Colors.black,)),
                Positioned(
                  bottom: 0,
                    left: 5,
                    right: 5,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(width: 2, color: Colors.grey[200])
                      ),
                      shadowColor: Colors.grey[200],
                      child: Container(height: 280,),
                    )
                ),
                Positioned(
                  top: 50,
                    child: PlayerSwiper()),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 210,
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
                  bottom: 220,
                  child: Slider(
                    activeColor: Colors.black87,
                      inactiveColor: Colors.black,
                      max: 5,
                      min: 0,
                      value: 3,
                      onChanged: null),
                ),
                Positioned(
                  left: 40,
                  right: 40,
                  bottom: 170,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _PlayerButtonSuffle(Icons.loop_rounded, _func()),
                      _PlayerButtonSuffle(Icons.shuffle_rounded, _func()),
                    ],),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 90,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     _PlayerButton(Icons.skip_previous_rounded,_func(),60),
                      _PlayerButton(Icons.play_circle_outline_rounded, _func(),60),
                      _PlayerButton(Icons.skip_next_rounded, _func(),60),
                    ],),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 15,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _PlayerService(Icons.playlist_add_rounded,_func(),30),
                      _PlayerService(Icons.share_rounded,_func(),30),
                      _PlayerService(Icons.download_rounded,_func(),30),
                      _PlayerService(Icons.insert_comment_rounded,_func(),30),
                      _PlayerService(Icons.favorite_border_rounded,_func(),30),
                    ],),
                ),
              ],),
            ),
          ),
      ),
    );
  }

  Widget _PlayerButton(IconData icon, Function function, double size){
    return InkWell(
      onTap: (){},
      child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size),
              side: BorderSide(width: 2, color: Colors.grey[200])
          ),
          child: Container(
              height: size,
              width: size,
              //color: Colors.amber,
              child: new Icon(
                icon,
                size: size,
                color: Colors.white,)
          )
      ),
    );
  }

  Widget _PlayerButtonSuffle(IconData icon, Function function){
    return InkWell(
      onTap: (){},
      child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(width: 2, color: Colors.grey[200])
          ),
          child: Container(
              height: 30,
              width: 30,
              //color: Colors.amber,
              child: new Icon(
                icon,
                size: 30,
                color: Colors.white,)
          )
      ),
    );
  }

  Widget _PlayerService(IconData icon, Function function, double size){
    return InkWell(
      onTap: (){},
      child: Container(
          height: size,
          width: size,
          //color: Colors.amber,
          child: new Icon(
            icon,
            size: size,
            color: Colors.black,)
      ),
    );
  }


}
