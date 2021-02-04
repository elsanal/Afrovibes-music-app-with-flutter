import 'package:flutter/material.dart';

Widget PlayerService(IconData icon, Function function, double size){
  return InkWell(
    onTap: (){},
    child: Container(
        height: size,
        width: size,
        //color: Colors.amber,
        child: new Icon(
          icon,
          size: size,
          color: Colors.white,)
    ),
  );
}