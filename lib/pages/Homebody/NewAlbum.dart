import 'package:flutter/material.dart';


class NewAlbum extends StatefulWidget {
  @override
  _NewAlbumState createState() => _NewAlbumState();
}

class _NewAlbumState extends State<NewAlbum> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 225,
      // color: Colors.yellow,
      child: Container(
        child: Column(
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Container(
                  padding: EdgeInsets.all(10),
                  child: Text('New Album',style: TextStyle(fontSize: 18),),),
                new Container(
                  padding: EdgeInsets.all(10),
                  child: Text('see All',style: TextStyle(fontSize: 18),),)
              ],),
            Container(
              width: width,
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder:(context, index){
                    return Container(
                      width: width*(1/3),
                      child: Card(
                        child: Stack(
                          children: [
                            Positioned(
                                top: 0,
                                child: Container(
                                  height: 100,
                                  width: width*(1/3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/profile.jpeg'),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                )
                            ),
                            Positioned(
                                bottom: 40,
                                left: 10,
                                child: new Container(child: Text('name'),)),
                            Positioned(
                                bottom: 15,
                                left: 10,
                                child: new Container(child: Text('Album'),)),
                            Positioned(
                                bottom: 30,
                                right: 10,
                                child: new Container(child:Text('No songs'),)),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
