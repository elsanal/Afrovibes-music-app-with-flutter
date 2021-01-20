import 'package:afromuse/sharedPage/gradients.dart';
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
            viewportFraction: 0.8,
            scale: 0.9,
            loop: true,
            autoplayDisableOnInteraction: true,
            duration: 500,
            itemCount: 4,
            itemBuilder:(context, index){
              return Column(
                children: [
                  Container(
                    width: width*(3/4),
                    height: heigth*(2/4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/profile.jpeg'),
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
                              child: new Container(child: Text('Album'),)),
                          Positioned(
                              bottom: 55,
                              left: 10,
                              child: new Container(height: 1,width: width*(1/3),color: Colors.black,)),
                          Positioned(
                              bottom: 30,
                              left: 60,
                              child: new Container(child: Text('artist'),)),
                          Positioned(
                              bottom: 10,
                              left: 60,
                              child: new Container(child: Text('No songs'),)),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: new Container(
                                child: Icon(
                                  Icons.play_circle_fill_outlined,
                                  size: 40,
                                ),)),
                          Positioned(
                              bottom: 15,
                              right: 15,
                              child: new Container(child: Icon(Icons.arrow_forward_ios),)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            pagination: new SwiperPagination(
                margin: EdgeInsets.all(5),
                builder: new DotSwiperPaginationBuilder(
                    color: Colors.orange,
                    activeColor: Colors.red,
                    size: 10,
                    activeSize: 13
                )
            )
        ),
      ),
    );
  }
}
