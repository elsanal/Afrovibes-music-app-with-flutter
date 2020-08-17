import 'package:afromuse/sharedPage/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              padding: EdgeInsets.all(10),
              child: Text("Please wait, the file is uploading...",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
                ),),
            ),
            new SpinKitHourGlass(color: Colors.red,duration: Duration(seconds: 10),),
            Container(
                padding: EdgeInsets.all(10),
                child: new LinearProgressIndicator(
                  backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red,)
                )
            ),
          ],
        ),
      ),
    );
  }
}
