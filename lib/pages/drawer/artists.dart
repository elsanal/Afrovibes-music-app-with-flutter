import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';


class Artists extends StatefulWidget {
  @override
  _ArtistsState createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {

  List artist = [

    {
      'artist' : 'Maitre gims',
      'image' : 'maitregims.jpeg'
    },
    {
      'artist' : 'Awa Boussim',
      'image' : 'awaboussim.jpeg'
    },
    {
      'artist' : 'Smarty',
      'image' : 'smarty.jpeg'
    },
    {
      'artist' : 'Black M',
      'image' : 'blackm.jpeg'
    },
    {
      'artist' : 'Debordo Leekunfa',
      'image' : 'debordoleekunfa.jpeg'
    },
    {
      'artist' : 'Dez Altino',
      'image' : 'dezaltino.jpeg'
    },
    {
      'artist' : 'Salif Keita',
      'image' : 'salifkeita.jpeg'
    },
    {
      'artist' : 'Davido',
      'image' : 'davido.jpeg'
    },
  ];

  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(width, height),
      allowFontScaling: true,
      builder: (){
        return Container(
            height: height,
            width: width,
            padding: EdgeInsets.only(
                bottom: 50
            ),
            child: Scaffold(
              body: Card(
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.grey[270]
                  ),
                  margin:EdgeInsets.only(
                      top: 3
                  ),
                  child: GridView.builder(
                      itemCount: artist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: ScreenUtil().setSp(10),
                          childAspectRatio: 0.7,
                          crossAxisCount:(orientation == Orientation.portrait)?3:4),
                      itemBuilder:(context, index){
                        return Container(
                          child: Column(
                            children: [
                              new CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.green,
                                backgroundImage: AssetImage('assets/category/'+artist[index]['image']),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child: new Text(artist[index]['categorie'],style: GoogleFonts.roboto(textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  )),))
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ),
            )
        );
      }
    );
  }
}
