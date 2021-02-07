import 'package:afromuse/pages/local/library.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class NearByUsers extends StatefulWidget {
  @override
  _NearByUsersState createState() => _NearByUsersState();
}

class _NearByUsersState extends State<NearByUsers> {
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
                  child: Text('Nearby people',style: GoogleFonts.roboto(textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  )),),),
                new Container(
                  padding: EdgeInsets.all(10),
                  child: Text('see All',style: GoogleFonts.roboto(textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  )),),)
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
                                child: new Container(child: Text('title'),)),
                            Positioned(
                                bottom: 15,
                                right: 10,
                                child: new Container(child:IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: (){

                                  },
                                    ),)),
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
