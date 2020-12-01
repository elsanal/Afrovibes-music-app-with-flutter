import 'package:afromuse/sharedPage/TopMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Latest extends StatefulWidget {
  @override
  _LatestState createState() => _LatestState();
}

int selectedIndex = 0;

class _LatestState extends State<Latest> {
  @override
  Widget build(BuildContext context) {
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
                      child: topMenu('New Songs',0,selectedIndex, context)
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: topMenu('New Albums',1,selectedIndex, context)
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                        child: topMenu('Most Played',2,selectedIndex, context)
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
