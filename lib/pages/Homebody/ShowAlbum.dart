import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class AlbumRow extends StatefulWidget {
  @override
  _AlbumRowState createState() => _AlbumRowState();
}

class _AlbumRowState extends State<AlbumRow> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 240,
      child: Container(
        child: new Swiper(
            scrollDirection: Axis.horizontal,
            itemHeight: 200,
            itemWidth: width*(3/4),
            viewportFraction: 0.8,
            scale: 0.9,
            autoplay: true,
            loop: true,
            autoplayDisableOnInteraction: true,
            duration: 500,
            itemCount: 4,
            itemBuilder:(context, index){
              return Column(
                children: [
                  Container(
                    width: width*(3/4),
                    height: 200,
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
