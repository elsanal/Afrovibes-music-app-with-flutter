import 'package:afromuse/pages/local/SongsFromAlbum.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';

class DisplayPlaylistContain extends StatefulWidget {
  @override
  _DisplayPlaylistContainState createState() => _DisplayPlaylistContainState();
}

class _DisplayPlaylistContainState extends State<DisplayPlaylistContain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[800],
      child: Container(
        child: Stack(children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
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
                color: Colors.black.withOpacity(1),
                child: Column(
                  children: [
                    new SizedBox(height: 5,),
                    new Center(child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/equilizer.jpeg'),
                    ),),
                    new SizedBox(height: 5,),
                    new Center(child: Text("Playlist's name",style: TextStyle(
                      color: Colors.white
                    ),),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         _ServiceRow(Icons.edit, "Edit"),
                        _ServiceRow(Icons.add_circle, "Add"),
                        _ServiceRow(Icons.delete, "Delete"),
                        _ServiceRow(Icons.share, "Share"),
                    ],),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 200,
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
            left: 5,
            child: RaisedButton(
              onPressed: (){
                libraryCurrentPage.value = 2;
                HomepageCurrentIndex.value = 4;
              },

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Icon(Icons.arrow_back_sharp, size: 15,),
                new Text('Back')
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
      color: Colors.white,
      onPressed: (){},
    ),),
    new Container(child: Text(title, style: TextStyle(
      color: Colors.white
    ),),)
  ],),);
}
