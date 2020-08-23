import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';

var containerDeco = BoxDecoration(
    color: Colors.white,
//    border: Border.all(
//        width: 1,
//        color: Colors.black
//    ),
    borderRadius: BorderRadius.only(
      bottomLeft: new Radius.circular(ScreenUtil().setHeight(20),),
      bottomRight: new Radius.circular(ScreenUtil().setHeight(20),),
      topLeft: new Radius.circular(ScreenUtil().setHeight(20),),
      topRight: new Radius.circular(ScreenUtil().setHeight(20),),
    )
);