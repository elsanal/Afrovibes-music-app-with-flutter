import 'package:afromuse/pages/myInfo/FloatingAddButton.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingAddButton(),
        body: Container(
          child: ListView(
            children: <Widget>[
              new Card(
                child: Text(
                  "First Post",
                  style: TextStyle(
                      fontSize: 25
                  ),
                ),
              ),
              new Card(
                child: Text(
                  "First Post",
                  style: TextStyle(
                      fontSize: 25
                  ),
                ),
              ),
              new Card(
                child: Text(
                  "First Post",
                  style: TextStyle(
                      fontSize: 25
                  ),
                ),
              ),
              new Card(
                child: Text(
                  "First Post",
                  style: TextStyle(
                      fontSize: 25
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
