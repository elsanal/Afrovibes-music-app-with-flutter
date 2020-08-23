import 'package:afromuse/pages/Homebody/homeContent.dart';
import 'package:afromuse/pages/Homebody/homeHeader.dart';
import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Homepagebody extends StatefulWidget {
  @override
  _HomepagebodyState createState() => _HomepagebodyState();
}

class _HomepagebodyState extends State<Homepagebody> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final mediaquery = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: gradient
            ),
            child: Column(
              children: <Widget>[
                new SizedBox(height: ScreenUtil().setWidth(70),),
                new HomeHeader(),
                Expanded(child: Center(child: new HomeContent()))
              ],
            ),
          )
      ),
    );
  }
}






















