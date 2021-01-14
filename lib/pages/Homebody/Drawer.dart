import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/pages/drawer/category.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mainDrawer extends StatefulWidget {
  @override
  _mainDrawerState createState() => _mainDrawerState();
}
int clickedIndex = null;
class _mainDrawerState extends State<mainDrawer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
   final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width*(10/12),
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
              top: 25,
              child: Container(
                color: Colors.deepOrange,
                margin: EdgeInsets.only(
                  top: 2,
                  left: 12,
                  right: 15,
                ),
                padding: EdgeInsets.all(8),
                width: width*(9/12),
                height: height*(2.5/12),
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)
                        ),
                        //backgroundBlendMode: BlendMode.darken,
                        color: Colors.black87,
                      backgroundBlendMode: BlendMode.difference
                    ),
                    child: Card(
                      color: Colors.black87,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          new  CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/profile.jpeg'),
                          ),
                          new Container(child: Text('Username',style: GoogleFonts.raleway(textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            color: Colors.white
                          ))),)
                        ],
                      ),
                    )
                ),
              )
          ),
          Positioned(
            top: height*(3.5/12),
            child: Container(
                height: height*(8/12),
                width: width*(10/12),
                color: Colors.grey[550],
                margin: EdgeInsets.only(
                  bottom: 50,
                ),
                child:ListView(
                  children: [
                    InkWell(
                        onTap: (){

                          setState(() {
                            clickedIndex = 0;
                          });
                        },
                        child: _ListeTile(Icons.mic_external_on,'Artists',0,clickedIndex)),
                    InkWell(
                        onTap: (){
                         setState(() {
                           clickedIndex = 1;
                         });
                        },
                        child: _ListeTile(Icons.library_music_outlined,'Musics',1,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 2;
                          });
                        },
                        child: _ListeTile(Icons.album_outlined,'Albums',2,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 12;
                            pageCurrentIndex.value = 5;
                            appBArTitle.value = "Category";
                          });

                          Navigator.of(context).pop();
                        },
                        child: _ListeTile(Icons.category_outlined,'Categories',12,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 3;
                          });
                        },
                        child: _ListeTile(Icons.queue_music_outlined,'Playlist',3,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 4;
                            pageCurrentIndex.value = 2;
                            appBArTitle.value = "Favorite";
                          });

                          Navigator.of(context).pop(true);
                        },
                        child: _ListeTile(Icons.favorite_border_outlined,'Favorite',4,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 5;
                          });
                          Navigator.of(context).pop();
                        },
                        child: _ListeTile(Icons.music_note_outlined,'suggestion',5,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 6;
                          });
                        },
                        child: _ListeTile(Icons.download_outlined,'Download',6,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 7;
                            pageCurrentIndex.value = 4;
                          });

                        },
                        child: _ListeTile(Icons.folder_outlined,'Library',7,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 8;
                          });
                        },
                        child: _ListeTile(Icons.settings_outlined,'Settings',8,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 9;
                          });
                        },
                        child: _ListeTile(Icons.login_outlined,'Login',9,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 10;
                          });
                        },
                        child: _ListeTile(Icons.rule,'Terms and Conditions',10,clickedIndex)),
                    InkWell(
                        onTap: (){
                          setState(() {
                            clickedIndex = 11;
                          });
                        },
                        child: _ListeTile(Icons.home_work,'About',11,clickedIndex)),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}


Widget _ListeTile(IconData _icon, String title,int index, int clickedIndex){
  return Card(
    color: index == clickedIndex?Colors.redAccent:Colors.white,
    child: Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(_icon),
              SizedBox(width: 8,),
              Text(title,style: GoogleFonts.raleway(textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ))
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    ),);
}