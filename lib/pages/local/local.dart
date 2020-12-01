import 'package:afromuse/sharedPage/TopMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Local extends StatefulWidget {
  @override
  _LocalState createState() => _LocalState();
}
int selectedIndex = 0;

class _LocalState extends State<Local> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final tle_cont_w = width*(1/3)-4;
    return Container(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.black,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: topMenu('All Songs',0,selectedIndex, context)
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: topMenu('Folders',1,selectedIndex, context)
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 3;
                          });
                        },
                        child: topMenu('Playlists',3,selectedIndex, context)
                    ),
                  ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
