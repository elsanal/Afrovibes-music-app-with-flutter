import 'dart:io';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MusicPlayerClass{
  List<DocumentSnapshot> document;
  AudioPlayer audioPlayer ;
  int index;
  bool isLocal;
  String file;
  MusicPlayerClass({this.document,this.file,this.audioPlayer, this.index, this.isLocal});


  void playMusic(){
    print("play called");
    isLocal==true?audioPlayer.play(file, isLocal: true):
    audioPlayer.play(document[index]['contentUrl'], isLocal: false);
  }
  void stopMusic(){
    print("stop called");
    audioPlayer.stop();
  }
  void pauseMusic(){
      print("pause called");
      audioPlayer.pause();
  }
  forwardMusic(final audioPosition){
    Duration jump = new Duration(seconds: 10);
    audioPlayer.seek(audioPosition + jump);
  }
  reverseMusic(final audioPosition){
    Duration jump = new Duration(seconds: 10);
    audioPlayer.seek(audioPosition - jump);
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

}