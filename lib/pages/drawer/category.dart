import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

List catList = [
  {
    'categorie' : 'Hip-Hop',
    'image': 'hip-hop.jpeg'
  },
  {
    'categorie' : 'Reggea',
    'image': 'reggea.jpeg'
  },
  {
    'categorie' : 'Jazz',
    'image': 'jazz.jpeg'
  },
  {
    'categorie' : 'Rock',
    'image': 'rock.jpeg'
  },
  {
    'categorie' : 'Cantic',
    'image': 'cantic.jpeg'
  },
  {
    'categorie' : 'Zouk',
    'image': 'zouk.jpeg'
  },
  {
    'categorie' : 'Coupé-decalé',
    'image': 'coupe-decale.jpeg'
  },
  {
    'categorie' : 'Slam',
    'image': 'slam.jpeg'
  },
  {
    'categorie' : 'Liwaga',
    'image': 'liwaga.jpeg'
  },
  {
    'categorie' : 'Kora',
    'image': 'kora.jpeg'
  },
  {
    'categorie' : 'Afro Trap',
    'image': 'afrotrap.jpeg'
  },
  {
    'categorie' : 'Afrobeat',
    'image': 'afrobeat.jpeg'
  },
  {
    'categorie' : 'Dance Hall',
    'image': 'dancehall.jpeg'
  }, {
    'categorie' : 'RnB',
    'image': 'rnb.jpeg'
  },
  {
    'categorie' : 'Techno',
    'image': 'techno.jpeg'
  },
  {
    'categorie' : 'Electro-house',
    'image': 'electro-house.jpeg'
  },
  {
    'categorie' : 'Classique',
    'image': 'classique.jpeg'
  },

];

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(width, height),
        allowFontScaling: true,
      builder: () {
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
                    itemCount: catList.length,
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
                              backgroundImage: AssetImage('assets/category/'+catList[index]['image']),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: new Text(catList[index]['categorie'],style: GoogleFonts.roboto(textStyle: TextStyle(
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

