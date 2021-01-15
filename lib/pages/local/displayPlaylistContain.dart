import 'package:afromuse/pages/local/SongsFromAlbum.dart';
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
        child: Column(children: [
          new Container(
            padding: EdgeInsets.only(
                top: 5,
                bottom: 10
            ),
            height: 200,color: Colors.orange[800],
            child: Column(
              children: [
                new Center(child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/equilizer.jpeg'),
                ),),
                new SizedBox(height: 5,),
                new Center(child: Text("Playlist's name"),),
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
          Expanded(
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
    new Container(child: Text(title),)
  ],),);
}
