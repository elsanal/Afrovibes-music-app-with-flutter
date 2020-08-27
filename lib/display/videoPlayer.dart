import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFromWeb extends StatefulWidget {
  String videoFile;
  double width;
  double height;
  VideoFromWeb({this.videoFile, this.width, this.height});
  @override
  _VideoFromWebState createState() => _VideoFromWebState();
}

class _VideoFromWebState extends State<VideoFromWeb> {

  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    _videoPlayerController = VideoPlayerController.network(this.widget.videoFile)..initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.height!=null?(widget.height!=null?widget.height/widget.width:3/2):3/2,
        autoPlay: false,
        looping: false,
        autoInitialize: true,
        allowMuting: true,
        allowedScreenSleep: true,
        allowFullScreen: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
            playedColor: Colors.red,
            backgroundColor: Colors.black,
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
//      margin: EdgeInsets.only(
//        left: 5,
//        right: 5,
//        top: 5,
//      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width*(2/3),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
