import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/valueNotifier.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

List playlist = [
  {
    'title' : 'Hip-Hop',
    'image': 'hip-hop.jpeg'
  },
  {
    'title' : 'Reggea',
    'image': 'reggea.jpeg'
  },
  {
    'title' : 'Jazz',
    'image': 'jazz.jpeg'
  },

];

List<AlbumInfo> playlists = [];
List<AlbumInfo> newList = [];
getAlbum_data()async{
  playlists = await audioQuery.getAlbums();
}


class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}
AudioPlayer _audioPlayer = new AudioPlayer();
class _PlaylistState extends State<Playlist> {
  @override
  void initState() {
    getAlbum_data();
    // TODO: implement initState
    super.initState();
  }
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(4),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text("Your Playlist"),
              new IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.black87),
                  onPressed: (){
                    if(_count <= playlists.length-1){
                      setState(() {
                        newList.add(playlists[_count]);
                        _count++;
                      });
                    }
                   print(playlists);
                  }

              )
            ],
          ),
          content: Card(
            color: Colors.grey[200],
            child: Container(
                height: height*(2.3/5),
                width: width*(7.35/12),
                padding: EdgeInsets.all(4),
                child:ListView.builder(
                  itemCount: newList.length,
                  itemBuilder: (context, index) {
                    //print(snapshot.data.length);
                    if (playlists.isEmpty) {
                      return Container(color: Colors.white,child: Center(
                        child: SpinKitFadingCircle(color: Colors.black,),),);
                    } else {
                      Color color = Colors.red;
                      bool isPressed = false;
                      return GestureDetector(
                        onTap: ()async{
                          allInternalSongs.value = await audioQuery.getSongsFromAlbum(
                              albumId: newList[index].id);
                          setState(() {
                          libraryCurrentPage.value = 3;
                          });
                          print('pressed');
                        },
                        child: Card(
                          color: isPressed?color:Colors.white,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              color: isPressed?color:Colors.white,
                              child: Stack(children: [
                                Positioned(
                                    bottom: 5,
                                    left: 5,
                                    top: 5,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.asset('assets/category/afrobeat.jpeg'),)
                                ),
                                Positioned(
                                    top: 3,
                                    left: 60,
                                    child: Container(
                                      // height: 40,
                                      width: 150,
                                      child: Marques(newList[index].title, Colors.black),)
                                ),
                                Positioned(
                                    bottom: 5,
                                    left: 70,
                                    child: Container(child: Text(newList[index].numberOfSongs + " songs"),)
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
            ),
          ),
        ),
      ),
    );
  }
}



