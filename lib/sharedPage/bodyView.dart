import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';







Widget articleHead(DocumentSnapshot document){
  return new Container(
    margin: EdgeInsets.only(
      left: ScreenUtil().setWidth(25),
    ),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(document['time'],style: GoogleFonts.roboto(textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),),
            new SizedBox(height: ScreenUtil().setWidth(25),),
            new Text(document['date'],style: GoogleFonts.roboto(textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),),
          ],
        ),
        new IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){})
      ],
    ),
  );
}




Widget articleBottom(DocumentSnapshot document, double width){
  return Container(
    child: Column(children: [
       Container(
         height: ScreenUtil().setWidth(100),
           child: Marques(document['title'])),
      new Container(color: Colors.black,height: 1,width: width,),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Container(child: new Row(children: [
            new Container(child: IconButton(
                icon: Icon(Icons.thumb_up), onPressed: (){})),
            new Container(child: Text("Like",style: GoogleFonts.roboto(textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),)),
          ],),),
          new Container(child: new Row(children: [
            new Container(child: IconButton(
                icon: Icon(Icons.add_comment), onPressed: (){})),
            new Container(child: Text("Comment",style: GoogleFonts.roboto(textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),)),
          ],),),
          new Container(child: new Row(children: [
            new Container(child: IconButton(
                icon: Icon(Icons.share), onPressed: (){})),
            new Container(child: Text("Share",style: GoogleFonts.roboto(textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),)),
            new SizedBox(width: ScreenUtil().setWidth(15),)
          ],),),
        ],)
    ],
    ),
  );
}

Widget Marques(String filename){
  final fileLegth = filename.length;
  return fileLegth >=23? new Container(
    padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
    child: Marquee(
      text: filename!=null?filename:'',
      style: GoogleFonts.lexendExa(
          textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black
          )
      ),
      blankSpace: 10,
      velocity: 18,
      pauseAfterRound: Duration(seconds: 1),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      startPadding: 10.0,
      accelerationCurve: Curves.linear,
      accelerationDuration: Duration(seconds: 1),
      decelerationDuration: Duration(milliseconds: 500),
      decelerationCurve: Curves.bounceInOut,
    ),
  ):Container(
    margin: EdgeInsets.only(
      left: 10
    ),
    child: Text(filename,style: GoogleFonts.lexendExa(
        textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.black
          ),
        ),

    ),
  );
}
