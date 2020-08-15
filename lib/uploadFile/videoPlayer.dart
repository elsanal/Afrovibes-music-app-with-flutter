import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFromPhone extends StatefulWidget {
  File videoFile;
  VideoFromPhone({this.videoFile});
  @override
  _VideoFromPhoneState createState() => _VideoFromPhoneState();
}

class _VideoFromPhoneState extends State<VideoFromPhone> {

   ChewieController _chewieController;
   VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.file(this.widget.videoFile);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 3/2,
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
    final boxSize = MediaQuery.of(context).size.width;
    return Container(
      height: boxSize*(2/3),
      width: boxSize,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}
