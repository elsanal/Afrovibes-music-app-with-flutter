import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    ScreenUtil.init(width: 1080, height: 1920);
    return Container(
      margin: EdgeInsets.only(
         left: ScreenUtil().setWidth(40),
         right: ScreenUtil().setWidth(40),
      ),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      width: Width,
      height: ScreenUtil().setHeight(120),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.redAccent
        ),
        borderRadius: BorderRadius.circular(
          ScreenUtil().setHeight(200)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new SizedBox(width: 10,),
          Expanded(
            child: Container(
              child: new TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  alignLabelWithHint: false,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: Icon(Icons.search,color: Colors.black,),
                  contentPadding: EdgeInsets.all(ScreenUtil().setHeight(30)),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          new SizedBox(width: 10,)
        ],
      ),
    );
  }
}
