import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Latest extends StatefulWidget {
  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
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
                    new Container(
                      width:tle_cont_w,
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      margin: EdgeInsets.all(2),
                      child: Text('New Songs',style: GoogleFonts.roboto(textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      )),
                        textAlign: TextAlign.center,
                      ),),
                    new Container(
                      width:tle_cont_w,
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Text('New Album',style: GoogleFonts.roboto(textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      )),
                        textAlign: TextAlign.center,
                      ),),
                    new Container(
                      width:tle_cont_w,
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(2),
                      child: Text('Most Played',style: GoogleFonts.roboto(textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      )),
                        textAlign: TextAlign.center,
                      ),),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
