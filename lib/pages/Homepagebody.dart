import 'package:afromuse/sharedPage/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepagebody extends StatefulWidget {
  @override
  _HomepagebodyState createState() => _HomepagebodyState();
}

class _HomepagebodyState extends State<Homepagebody> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 1080, height: 1920);
    final mediaquery = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              height: mediaquery*(1/3),
              color: Colors.green[900],
              child: Column(
                children: <Widget>[
                  new SearchBar(),
                ],
              ),
            ),

          ],
        )
      ),
    );
  }
}
