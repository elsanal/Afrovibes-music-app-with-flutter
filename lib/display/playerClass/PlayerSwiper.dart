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
                child: Draggable(
                  dragAnchor: DragAnchor.child,
                  axis: Axis.horizontal,
                  ignoringFeedbackSemantics: true,
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
                      padding: EdgeInsets.all(45),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.mediaItem.artUri??"assets/artists/floby.jpeg"),
                      ),
                    ),
                  ),
                  feedback: Card(
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
                      padding: EdgeInsets.all(45),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.mediaItem.artUri??"assets/artists/floby.jpeg"),
                      ),
                    ),
                  ),
                  childWhenDragging: Card(
                    color: Colors.grey[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width*(2/4))),
                    child: Container(
                      width: width*(2.2/4),
                      height: width*(2.2/4),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.all(
                            Radius.circular(width*(2/4))
                        ),
                      ),

                    ),
                  ),
                  onDragEnd: (drag)async{
                    if(drag.offset.dx < 100){
                      await AudioService.skipToNext();
                    }else if(drag.offset.dy > 170){
                     await AudioService.skipToPrevious();
                    }else{

                    }
                  },
                ),
              ),
            ]
        )
    );
  }
}
