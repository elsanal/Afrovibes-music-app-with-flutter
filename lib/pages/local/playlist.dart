import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  {
    'title' : 'Rock',
    'image': 'rock.jpeg'
  },
  {
    'title' : 'Cantic',
    'image': 'cantic.jpeg'
  },
  {
    'title' : 'Zouk',
    'image': 'zouk.jpeg'
  },
  {
    'title' : 'Coupé-decalé',
    'image': 'coupe-decale.jpeg'
  },
  {
    'title' : 'Slam',
    'image': 'slam.jpeg'
  },
  {
    'title' : 'Liwaga',
    'image': 'liwaga.jpeg'
  },
  {
    'title' : 'Kora',
    'image': 'kora.jpeg'
  },
  {
    'title' : 'Afro Trap',
    'image': 'afrotrap.jpeg'
  },
  {
    'title' : 'Afrobeat',
    'image': 'afrobeat.jpeg'
  },
  {
    'title' : 'Dance Hall',
    'image': 'dancehall.jpeg'
  }, {
    'title' : 'RnB',
    'image': 'rnb.jpeg'
  },
  {
    'title' : 'Techno',
    'image': 'techno.jpeg'
  },
  {
    'title' : 'Electro-house',
    'image': 'electro-house.jpeg'
  },
  {
    'title' : 'Classique',
    'image': 'classique.jpeg'
  },

];








class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}
AudioPlayer _audioPlayer = new AudioPlayer();
class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    final orientation =  MediaQuery.of(context).orientation;
    ScreenUtil.init(context);
    return Container(
        child: Container(
            child:ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                //print(snapshot.data.length);
                if (playlist.isEmpty) {
                  return Container(child: Center(child: Text("No album founded"),),);
                } else {
                  return GestureDetector(
                    child: Card(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                           height: 50,
                          child: Stack(children: [
                            Positioned(
                                bottom: 5,
                                left: 5,
                                top: 5,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset('assets/category/'+playlist[index]['image']),)
                            ),
                            Positioned(
                                top: 3,
                                left: 60,
                                child: Container(
                                  // height: 40,
                                  width: 150,
                                  child: Marques(playlist[index]['title']),)
                            ),
                            Positioned(
                                bottom: 5,
                                left: 70,
                                child: Container(child: Text('34 songs'),)
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
        )
    );
  }
}



