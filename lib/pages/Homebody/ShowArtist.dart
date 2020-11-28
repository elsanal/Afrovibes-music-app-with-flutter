import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Artist extends StatefulWidget {
  @override
  _ArtistState createState() => _ArtistState();
}

class _ArtistState extends State<Artist> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 225,
      // color: Colors.red,
      child: Container(
        child: Column(
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              new Container(
                padding: EdgeInsets.all(10),
                child: Text('Artists',style: GoogleFonts.roboto(textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                )),),),
              new Container(
                padding: EdgeInsets.all(10),
                child: Text('see All',style: GoogleFonts.roboto(textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                )),),),

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
                            bottom:60,
                            left: 10,
                            child: new CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/profile.jpeg'),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                              left: 10,
                              child: new Container(child: Text('name'),))
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
