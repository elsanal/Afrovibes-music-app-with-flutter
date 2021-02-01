import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/sharedPage/createPlaylist.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

final FlutterAudioQuery audioQuery = FlutterAudioQuery();

List<AlbumInfo> playlists = [];
List<AlbumInfo> newList = [];

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final orientation = MediaQuery
        .of(context)
        .orientation;
    return Container(
        height: height,
        width: width,
        child: FutureBuilder(
            future: getInternalData().getAllInternalAlbum(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(color: Colors.white, child: Center(
                  child: SpinKitFadingCircle(color: Colors.black,),),);
              } else {
                List<AlbumInfo> album = snapshot.data;
                return Container(
                  height: height,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: ScreenUtil().setSp(10),
                          childAspectRatio: 0.9,
                          crossAxisCount: (orientation ==
                              Orientation.portrait) ? 2 : 3),
                      itemCount: album.length + 1 ,
                      itemBuilder: (context, index) {
                        if (album.isEmpty) {
                          return Card(
                            child: GestureDetector(
                              onTap: (){
                                return playlistCreation(context);
                              },
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Icon(Icons.add_circle_outline, size: width/3,),
                                    new Text('Create new Playlist')
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if(index< album.length){
                          return GestureDetector(
                            onTap: () async {
                              List<SongInfo> songs = [];
                              songs = await audioQuery.getSongsFromAlbum(
                                  albumId: album[index].id);
                              currentAlbum.value =
                              await getInternalData().getAllInternalSongs(
                                  songs);
                              setState(() {
                                HomepageCurrentIndex.value = 6;
                              });
                            },
                            child: Card(
                              child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  // height: 20,
                                  child: Stack(children: [
                                    Positioned(
                                        top: 1,
                                        left: 1,
                                        right: 1,
                                        child: Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 2,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .width * (4 / 10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/equilizer.jpeg"),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        )
                                    ),
                                    Positioned(
                                        bottom: 25,
                                        left: 3,
                                        right: 3,
                                        child: Container(
                                          // height: 40,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 2,
                                          child: Text(album[index].title,
                                            style: GoogleFonts.lexendExa(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        )
                                    ),
                                    Positioned(
                                        bottom: 5,
                                        left: 5,
                                        child: Container(child: Text(
                                            album[index].numberOfSongs +
                                                ' songs'),)
                                    ),
                                  ],)
                              ),
                            ),
                          );
                        }else{
                          return Card(
                            child: GestureDetector(
                              onTap: (){
                                return playlistCreation(context);
                              },
                              child: Container(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   new Icon(Icons.add_circle_outline, size: width/3,),
                                   new Text('Create new Playlist')
                                 ],
                               ),
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






