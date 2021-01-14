import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

var decorationSearchBar = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 2.0,
      color: Colors.redAccent
    ),
    borderRadius: BorderRadius.circular(100)
  ),
);

var decorationUpload = InputDecoration(
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1.0,
          color: Colors.black
      ),
      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8))
  ),
  enabled: true,
  fillColor: Colors.white,
  filled: true,
  alignLabelWithHint: true,
  focusColor: Colors.redAccent,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.redAccent
    )
  ),
  contentPadding: EdgeInsets.all(ScreenUtil().setHeight(15)),
);