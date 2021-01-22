import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PlayerSwiper extends StatefulWidget {

  @override
  _PlayerSwiperState createState() => _PlayerSwiperState();
}

class _PlayerSwiperState extends State<PlayerSwiper> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: heigth*(2.3/4),
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: new Swiper(
            scrollDirection: Axis.horizontal,
            itemHeight: heigth*(2/4),
            itemWidth: width*(3/4),
            viewportFraction: 0.7,
            scale: 0.9,
            loop: true,
            autoplayDisableOnInteraction: true,
            duration: 500,
            itemCount: currentPlayingList.value.length,
            itemBuilder:(context, index){
              Music music = currentPlayingList.value[index];
              return Column(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      width: width*(2.7/4),
                      height: heigth*(1.5/4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)
                        ),
                        image: DecorationImage(
                            image: AssetImage(music.artwork!=null?music.artwork:"assets/equilizer.jpeg"),
                            fit: BoxFit.cover
                        ),
                      ),
                      margin: EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: album_grad,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 60,
                                left: 10,
                                child: new Container(child: Text(
                                 music.artistName
                                ),)),
                            Positioned(
                                bottom: 55,
                                left: 10,
                                child: new Container(height: 1,width: width*(1/3.3),color: Colors.black,)),
                            Positioned(
                                top: heigth*(1.25/4),
                                left: 10,
                                child: new Container(
                                  width: width*(1.5/4),
                                  //height: heigth*(1.5/4),
                                  child: Text(
                                    music.musicTitle,
                                  maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                ),)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            // pagination: new SwiperPagination(
            //     margin: EdgeInsets.all(5),
            //     builder: new DotSwiperPaginationBuilder(
            //         color: Colors.orange,
            //         activeColor: Colors.red,
            //         size: 10,
            //         activeSize: 13
            //     )
            // )
        ),
      ),
    );
  }
}
