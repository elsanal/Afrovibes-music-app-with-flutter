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
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('My Posts'),
          actions: [
            Icon(Icons.add_circle_outline),
            Icon(Icons.live_tv),
            Icon(Icons.settings)
          ],
        ),
        floatingActionButton: FloatingAddButton(),
        body: Container(
          child: ListView(
            children: <Widget>[
            
            ],
          ),
        ),
      ),
    );
  }
}
