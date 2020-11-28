import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var gradient = new  LinearGradient(
                 begin: Alignment.topRight,
                 end : Alignment.bottomLeft,
                 colors: [Colors.redAccent, Colors.orange, Colors.indigo]);


var album_grad = new  LinearGradient(
    begin: Alignment.topCenter,
    end : Alignment.bottomCenter,
    colors: [
      Colors.redAccent.withOpacity(0.1),Colors.redAccent.withOpacity(0.1),
      Colors.redAccent.withOpacity(0.1),
      Colors.redAccent,Colors.redAccent,
    ]);