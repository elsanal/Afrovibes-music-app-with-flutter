import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MusicPlayerClass{
  DocumentSnapshot document;
  AudioPlayer audioPlayer ;
  MusicPlayerClass({this.document, this.audioPlayer});


  void playMusic(){
    print("play called");
    audioPlayer.play(document['contentUrl'], isLocal: false);
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