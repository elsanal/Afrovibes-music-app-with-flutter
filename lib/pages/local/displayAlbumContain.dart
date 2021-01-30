import 'package:afromuse/pages/local/SongsFromAlbum.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';


class DisplayAlbumContain extends StatefulWidget {
  @override
  _DisplayAlbumContainState createState() => _DisplayAlbumContainState();
}

class _DisplayAlbumContainState extends State<DisplayAlbumContain> {
  @override
  Widget build(BuildContext context) {
    final length = currentAlbum.value.length;
    return Container(
      color: Colors.orange[800],
      child: Container(
          child: Stack(children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: new Container(
                padding: EdgeInsets.only(
                    //top: 5,
                    bottom: 10
                ),
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.orange[800],
                    image: DecorationImage(
                        image: AssetImage('assets/techno.jpeg'),
                        fit: BoxFit.fitWidth
                    )
                ),
                child: Container(
                  color: Colors.orange[800].withOpacity(0.8),
                  child: Column(
                    children: [
                      new SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new SizedBox(width: 5,),
                          new Center(
                            child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/equilizer.jpeg'),
                          ),),
                          new SizedBox(width: 15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new SizedBox(height: 20,),
                              new Center(child: Text("Playlist's name",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),),),
                              new SizedBox(height: 20,),
                              new Center(child: Text('$length songs',)
                              ),
                            ],
                          ),
                        ],
                      ),
                      new SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ServiceRow(Icons.play_circle_outline, "Play all"),
                          _ServiceRow(Icons.delete, "Delete"),
                          _ServiceRow(Icons.share, "Share"),
                        ],),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
              bottom: 0,
              child: new Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 3,
                  right: 3,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(35,),
                      topRight: new Radius.circular(35,),
                    )
                ),
                child: SongsFromAlbum(),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: RaisedButton(
                onPressed: (){
                  libraryCurrentPage.value = 1;
                  HomepageCurrentIndex.value = 4;
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text('Back'),
                    Icon(Icons.arrow_forward, size: 15,),

                  ],),
              ),
            ),
          ],)
      ),
    );
  }
}

Widget _ServiceRow(IconData icon, String title){
  return new Center(child: Column(children: [
    new Container(child: IconButton(
      icon:Icon(icon),
      onPressed: (){},
    ),),
    new Container(child: Text(title,style: TextStyle(
      fontWeight: FontWeight.w600
    ),),)
  ],),);
}
