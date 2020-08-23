import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFromPhone extends StatefulWidget {
  File videoFile;
  final videoHigh;
  final videoWidth;
  VideoFromPhone({this.videoFile, this.videoHigh, this.videoWidth});
  @override
  _VideoFromPhoneState createState() => _VideoFromPhoneState();
}

class _VideoFromPhoneState extends State<VideoFromPhone> {

   ChewieController _chewieController;
   VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.file(this.widget.videoFile)..initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.videoHigh/widget.videoWidth,
        autoPlay: false,
        looping: false,
        autoInitialize: true,
        allowMuting: true,
        allowedScreenSleep: true,
        allowFullScreen: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
            playedColor: Colors.red,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.lightGreen,
            handleColor: Colors.blue
        )
    );
   _chewieController.pause();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  _chewieController.dispose();
  _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        top: 5,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width*(2/3),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
