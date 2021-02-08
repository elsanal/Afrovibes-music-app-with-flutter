import 'dart:math';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/sharedPage/swipedetector.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PlayerSwip extends StatefulWidget {
  MediaItem mediaItem;
  List<MediaItem> queue;
  PlayerSwip({this.mediaItem, this.queue});
  @override
  _PlayerSwipState createState() => _PlayerSwipState();
}

class _PlayerSwipState extends State<PlayerSwip> with TickerProviderStateMixin{

  AnimationController _animationController;

  int _index = 0;
  @override
  void initState() {
    _index = AudioService.queue.indexOf(widget.mediaItem);
    _animationController = AnimationController(vsync: this, duration: Duration(seconds:10))..repeat();
    // TODO: implement initState
    super.initState();
  }

  Future<void> updateIndex(int index)async{
   Duration duration = Duration(milliseconds: 1000);
   return Future.delayed(duration, (){
     setState(() {
       _index = index;
     });
   });
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
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: width*(2.3/4),
      width: width*(2.3/4),
      color: Colors.transparent,
      child: Swiper(
          scrollDirection: Axis.horizontal,
          itemHeight: width*(2/4),
          itemWidth: width*(2/4),
          viewportFraction: 0.7,
          scale: 0.5,
          fade: 0.1,
          onTap: (value){
            print(value);
          },
          onIndexChanged: (value)async{
            if(value < _index){
              updateIndex(value);
              await AudioService.skipToPrevious();
            }else{
              updateIndex(value);
              await AudioService.skipToNext();
            }
          },
          loop: true,
          autoplayDisableOnInteraction: true,
          curve: Curves.easeOutSine,
          duration: 500,
          itemCount: widget.queue.length,
        containerHeight: width*(2/4),
        containerWidth: width*(2/4),
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                            image: AssetImage("assets/playerDisk3.png"),
                            fit: BoxFit.cover
                        ),
                      ),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(35),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.mediaItem.artUri??"assets/artists/floby.jpeg"),
                      ),
                    ),
                  )
                ),
            ],
          );
        }
      ),
    );
  }
}
