import 'package:afromuse/sharedPage/alertDialog.dart';
import 'package:flutter/material.dart';

class FloatingAddButton extends StatefulWidget {
  @override
  _FloatingAddButtonState createState() => _FloatingAddButtonState();
}

class _FloatingAddButtonState extends State<FloatingAddButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: (){
          uploadFileAlert(context);
        },
        backgroundColor: Colors.black,
        focusColor: Colors.redAccent,
        child: Icon(Icons.add_to_photos, size: 50,)
      ),
    );
  }
}
