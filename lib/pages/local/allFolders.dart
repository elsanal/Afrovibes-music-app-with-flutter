import 'package:afromuse/pages/local/SongsFromAlbum.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
final FlutterAudioQuery audioQuery = FlutterAudioQuery();


class LocalAlbums extends StatefulWidget {
  @override
  _LocalAlbumsState createState() => _LocalAlbumsState();
}

class _LocalAlbumsState extends State<LocalAlbums> {
  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    ScreenUtil.init(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
    height: height,
        width: width,
        child: FutureBuilder(
            future: getData().getAllInternalAlbum(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                //print(snapshot.data.length);
                return Container(color: Colors.white,child: Center(
                  child: SpinKitFadingCircle(color: Colors.black,),),);
              } else {
                List<AlbumInfo> album = snapshot.data;
                return Container(
                    child:GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: ScreenUtil().setSp(10),
                          childAspectRatio: 0.9,
                          crossAxisCount:(orientation == Orientation.portrait)?2:3),
                      itemCount: album.length,
                      itemBuilder: (context, index) {
                        //print(snapshot.data.length);
                        if (album.isEmpty) {
                          return Container(color: Colors.white,child: Center(
                            child: Text('No album founded'),),);
                        } else {
                          return GestureDetector(
                            onTap: ()async{
                              allInternalSongs.value = await audioQuery.getSongsFromAlbum(albumId: album[index].id);
                              libraryCurrentPage.value = 3;

                            },
                            child: Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 20,
                                  child: Stack(children: [
                                    Positioned(
                                        top: 3,
                                        left: 20,
                                        child: Container(
                                          // height: 40,
                                          width: 150,
                                          child: Marques(album[index].artist + ' - '+ album[index].title, Colors.black),)
                                    ),
                                    Positioned(
                                        right: 5,
                                        bottom: 5,
                                        child: Container(child: Text(album[index].id + " "),)
                                    ),
                                    Positioned(
                                        bottom: 5,
                                        left: 5,
                                        child: Container(child: Text(album[index].numberOfSongs + ' songs'),)
                                    ),

                                    Positioned(
                                        top: 3,
                                        right: 5,
                                        child: Container(child: IconButton(
                                            icon: Icon(Icons.more_vert),
                                            onPressed: (){

                                            }
                                            ),
                                        )
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
