import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget bottomItems(IconData iconOutlined, double iconSize,Color color) {
  return Container(
    height: iconSize,
    width: iconSize,
    color: Colors.transparent,
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: GestureDetector(
            child: Center(
              child: Icon(iconOutlined,
                color: color,
                size: iconSize,
              ),
            )
        ),
      ),
    ),
  );
}