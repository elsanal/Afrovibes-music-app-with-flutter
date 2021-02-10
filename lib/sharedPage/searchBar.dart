import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class TextFieldForm extends StatefulWidget {
  final Function searchToggle;
  TextFieldForm({this.searchToggle});
  @override
  _TextFieldFormState createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          new SizedBox(width: 10,),
          Expanded(
            child: Container(
              child: new TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search",
                  alignLabelWithHint: false,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(ScreenUtil().setHeight(30)),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          GestureDetector(
              onTap: widget.searchToggle,
              child: Container(child: Icon(Icons.search),)),
          new SizedBox(width: 10,)
        ],
      ),
    );
  }
}




