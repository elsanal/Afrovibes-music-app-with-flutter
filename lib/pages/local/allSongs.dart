import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/constant.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getSongs_data(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                //print(snapshot.data.length);
                return Container(color: Colors.grey,child: Center(child: Text("Loading..."),),);
              } else {
               List<SongInfo> songs = snapshot.data;
                return Container(
                    child:ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        //print(snapshot.data.length);
                        if (songs.isEmpty) {
                          return Container(child: Center(child: Text("No music founded"),),);
                        } else {
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedSong = songs[index];
                                isTapedToPlay = true;
                              });
                              MusicPlayerClass(
                                file: songs[index].filePath,
                                isLocal: true,
                              ).playMusic();
                            },
                            child: Card(
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
                                          child: Marques(songs[index].artist + ' - '+ songs[index].artist),)
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



