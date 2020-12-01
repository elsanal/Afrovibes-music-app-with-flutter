import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget topMenu(String title, int index,int selectedIndex, BuildContext context){
  final width = MediaQuery.of(context).size.width;
  final tle_cont_w = width*(1/3)-4;
  return index == selectedIndex? new Container(
    width:tle_cont_w,
    color: Colors.black,
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(2),
    child: Text(title,style: GoogleFonts.raleway(textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      color: Colors.white
    )),
      textAlign: TextAlign.center,
    ),): new Container(
        width:tle_cont_w,
         color: Colors.white,
         padding: EdgeInsets.all(10),
       margin: EdgeInsets.all(2),
     child: Text(title,style: GoogleFonts.roboto(textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600
         )),
         textAlign: TextAlign.center,
      ),);
}