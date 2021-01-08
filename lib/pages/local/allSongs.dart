import 'dart:async';

import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/constant.dart';
import 'package:afromuse/staticPage/preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  getSongs_data()async{
  List<SongInfo> songs = await audioQuery.getSongs(sortType: SongSortType.DEFAULT);
  if(songs.isEmpty){
      print("Empty");
      print(songs.length);
  }
  return songs;
}


class LocalSongs extends StatefulWidget {
  @override
  _LocalSongsState createState() => _LocalSongsState();
}
class _LocalSongsState extends State<LocalSongs> {

    AudioPlayer _audioPlayer = AudioPlayer();
    @override
  void dispose() {
      _audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
        bottom: 73,
      ),
        color: Colors.white,
        child: FutureBuilder(
            future: getSongs_data(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                //print(snapshot.data.length);
                return Container(color: Colors.white,child: Center(
                  child: SpinKitFadingCircle(color: Colors.black,),),);
              } else {
               List<SongInfo> songs = snapshot.data;
                return Container(
                  height: height,
                    child:ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        //print(snapshot.data.length);
                        if (songs.isEmpty) {
                          return Container(child: Center(child: Text("No music founded"),),);
                        } else {
                          selectedSong = songs;
                          return InkWell(
                            onTap: (){
                              setState(() {
                                songIndex.value = index;
                                isTapedToPlay.value = true;
                                isPlaying.value = true;
                                SongLength.value = selectedSong.length;
                              });
                              autoSaveIsPlaying();
                              autoSaveTapedToPlay();
                              autoSaveIndexCurrentSong(
                                songs[index].artist.toString(),
                                songs[index].title.toString(),
                                songs[index].filePath.toString()
                              );
                              // MusicPlayerClass(
                              //   file: songs[songIndex.value].filePath.toString(),
                              //   isLocal: true,
                              //   audioPlayer: _audioPlayer
                              // ).playMusic();
                            },
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width*(1/5),
                                  child: Stack(children: [
                                    Positioned(
                                        top: 3,
                                        left: 20,
                                        child: Container(
                                          height: 40,
                                          width: 250,
                                          child: Marques(songs[index].artist + ' - '+ songs[index].artist, Colors.black),)
                                    ),
                                    Positioned(
                                        right: 5,
                                        bottom: 5,
                                        child: Container(child: Text(songs[index].duration),)
                                    ),
                                    Positioned(
                                        top: 30,
                                        left: 20,
                                        child: Container(child: Text(songs[index].album),)
                                    ),

                                    Positioned(
                                        top: 3,
                                        right: 5,
                                        child: Container(child: IconButton(
                                            icon: Icon(Icons.more_vert),
                                            onPressed: (){}),)
                                    ),

                                  ],)
                              ),
                            ),
                          );
                        }
                      },
                    )
                );
              }
            }
        )
    );
  }
}



