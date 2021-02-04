import 'dart:math';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PlayerSwip extends StatefulWidget {
  @override
  _PlayerSwipState createState() => _PlayerSwipState();
}

class _PlayerSwipState extends State<PlayerSwip> with TickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds:10))..repeat();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Container(
      width: width*(3/4),
      height: width*(3/4),
      color: Colors.transparent,
      child: Container(
        //color: Colors.red,
        child: new Swiper(
          scrollDirection: Axis.horizontal,
          itemHeight: heigth*(2/4),
          itemWidth: width*(2/4),
          viewportFraction: 0.9,
          scale: 0.9,
          loop: true,
          autoplayDisableOnInteraction: true,
          duration: 500,
          itemCount: currentPlayingList.value.length,
          itemBuilder:(context, index){
            Music music = currentPlayingList.value[index];
            return Container(
                child: Column(
                    children: [
                      AnimatedBuilder(
                        animation:_animationController,
                        builder: (_, child){
                          return Transform.rotate(
                            angle: _animationController.value*2*pi,
                            child: child,
                          );
                        },
                        child: Card(
                          color: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width*(2/4))),
                          child: Container(
                            width: width*(2/4),
                            height: width*(2/4),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(width*(2/4))
                              ),
                              image: DecorationImage(
                                  image: AssetImage(music.artwork!=null?music.artwork:"assets/playerDisk3.png"),
                                  fit: BoxFit.cover
                              ),
                            ),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(45),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(music.artwork!=null?music.artwork:"assets/artists/floby.jpeg"),
                            ),
                          ),
                        ),
                      ),
                    ]
                )
            );
          },
        ),
      ),
    );
  }
}
