import 'package:afromuse/display/playerClass/playerToggle.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RecentPlayed extends StatefulWidget {
  @override
  _RecentPlayedState createState() => _RecentPlayedState();
}

List myfavSong = [
  {
    'artist' : 'Davido',
    'song_name': 'Chioma',
    'category':'Kora',
    'duration' : '4:00',
    'album_name' : 'Philo',
    'rate' : 4.5,
    'num_part' :153,
    'num_view' : 756,
    'num_dld' : 32,
    'image' : 'davido.jpeg'
  },
  {
    'artist' : 'Maitre gims',
    'song_name': 'Tout donner',
    'category':'Hip-Hop',
    'duration' : '3:00',
    'album_name' : 'Subliminal',
    'rate' : 1.0,
    'num_part' :86,
    'num_view' : 12,
    'num_dld' : 25,
    'image' : 'maitregims.jpeg'
  },
  {
    'artist' : 'Black M',
    'song_name': 'Sur ma route',
    'category':'Rap',
    'duration' : '3:30',
    'album_name' : 'La route',
    'rate' : 2.5,
    'num_part' :125,
    'num_view' : 354,
    'num_dld' : 75,
    'image' : 'blackm.jpeg'
  },
  {
    'artist' : 'Smarty',
    'song_name': 'Chapeau du chef',
    'category':'Rap',
    'duration' : '4:10',
    'album_name' : 'Single',
    'rate' : 5.0,
    'num_part' :43,
    'num_view' : 953,
    'num_dld' : 3204,
    'image' : 'smarty.jpeg'
  },
  {
    'artist' : 'Fleur',
    'song_name': 'Posement',
    'category':'Kora',
    'duration' : '4:00',
    'album_name' : 'Philo',
    'rate' : 4.5,
    'num_part' :153,
    'num_view' : 756,
    'num_dld' : 32,
    'image' : 'fleur.jpeg'
  },
  {
    'artist' : 'Imilo Lechanceux',
    'song_name': 'Au village',
    'category':'Hip-Hop',
    'duration' : '3:00',
    'album_name' : 'Subliminal',
    'rate' : 1.0,
    'num_part' :86,
    'num_view' : 12,
    'num_dld' : 25,
    'image' : 'imilo.jpeg'
  },
  {
    'artist' : 'SANA Bob',
    'song_name': 'Mon pays',
    'category':'Rap',
    'duration' : '3:30',
    'album_name' : 'La route',
    'rate' : 2.5,
    'num_part' :125,
    'num_view' : 354,
    'num_dld' : 75,
    'image' : 'sanabob.jpeg'
  },
  {
    'artist' : 'Angelique Kidjo',
    'song_name': 'Sekere',
    'category':'Rap',
    'duration' : '4:10',
    'album_name' : 'Single',
    'rate' : 5.0,
    'num_part' :43,
    'num_view' : 953,
    'num_dld' : 3204,
    'image' : 'angeliquekidjo.jpeg'
  },
];

class _RecentPlayedState extends State<RecentPlayed> {

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    int position = _itemPositionsListener
        .itemPositions.value.first.index;
    Preferences().saveScrollPosition('allSongPos', position);
    print(position);
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
        padding: EdgeInsets.only(
          bottom: 100,
        ),
        color: Colors.white,
        child: FutureBuilder(
          future: Sqlite(dataBaseName: RECENT_PLAYED_DB,
              tableName: RECENT_PLAYED_TABLE).retrieveMusic(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container(child: Text("Waiting..."),);
            }else{
              print(myRecentPlayed.value.length);
              return Container(
                  height: height,
                  margin: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child:ScrollablePositionedList.builder(
                    initialScrollIndex:0,
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Music music = snapshot.data[index];
                      if (myRecentPlayed.value.isEmpty) {

                        return Container(child: Center(child: Text("No music founded"),),);
                      } else {
                        print("Has data1111");
                        return InkWell(
                          onTap: ()async{
                            currentPlayingList.value = snapshot.data;
                            playerToggleNotifier.value = false;
                            bool toggle = await getToggle();
                            setState(() {
                              currentSongIndex.value = index;
                              isTapedToPlay.value = true;
                              isPlaying.value = true;
                              playerToggleNotifier.value = toggle;
                            });
                            List<Music> musicList = [];
                            bool isMatched = false;
                            for(int i = 0; i<myRecentPlayed.value.length; i++){
                              if(music.file == myRecentPlayed.value[index].file){
                                setState(() {
                                  isMatched = true;
                                });
                              }
                              if((i == myRecentPlayed.value.length-1)&(isMatched == false)){
                                myRecentPlayed.value.add(music);
                                musicList.add(music);

                              }
                            }
                            // Sqlite(dataBaseName: RECENT_PLAYED_DB,
                            //     tableName: RECENT_PLAYED_TABLE).saveSqliteDB(musicList);
                            // myRecentPlayed.value.add(music);
                            // print(myRecentPlayed.value);
                            // print("Added to recent list");
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
                                        child: Marques(music.musicTitle, Colors.black),)
                                  ),
                                  Positioned(
                                      right: 15,
                                      bottom: 5,
                                      child: Container(
                                        child: Text(
                                            music.duration!=null?music.duration.toString():"-- : --"),
                                      )
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      left: 35,
                                      child: Container(child: Text(music.albumName),)
                                  ),

                                  Positioned(
                                      top: 0,
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
          },
        )
    );
  }
}




// Card(
// child: Container(
// child: Stack(
// children: [
// Positioned(
// top: 0,
// left: 90,
// child: Container(
// height: 40,
// width: 250,
// child: Marques(music.artistName +
// ' - ' + music.musicTitle, Colors.black),)),
// Positioned(
// top: 25,
// left: 120,
// child: Container(child: Text(music.genre)),),
// Positioned(
// bottom: 5,
// right: 5,
// child: Container(child: Text("--:--"),)),
// Positioned(
// bottom: 5,
// left: 100,
// child: Container(
// width: width-150,
//
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Row(
// children: [
// Container(child: RatingBar.builder(
// initialRating: music.rate + 0.0,
// minRating: 1,
// direction: Axis.horizontal,
// allowHalfRating: true,
// itemCount: 5,
// itemSize: 13,
// itemBuilder: (context,_)=>Icon(
// Icons.star,
// color: Colors.amber,
// size: 10,
// ),
// onRatingUpdate: (rating){
// print(rating);
// })
// ,),
// SizedBox(width: 2,),
// Container(child: Text(music.rate.toString()),)
// ],
// ),
// Row(
// children: [
// Container(child: Icon(
// Icons.hearing_outlined,
// color: Colors.amber,
// ),),
// SizedBox(width: 2,),
// Text(music.NListened.toString()),
// ],
// ),
// Row(
// children: [
// Container(child: Icon(
// Icons.download_outlined,
// color: Colors.red,
// ),),
// Text(music.Ndownload.toString()),
// ],
// ),
//
// ],
// ),)),
// Positioned(
// top: 3,
// right: 5,
// child: Container(
// child: Icon(Icons.favorite_rounded,color: Colors.redAccent,),)),
// Positioned(
// child: Container(
// child: Container(
// height: 90,
// width: 90,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage( index<myfavSong.length?
// 'assets/artists/'+myfavSong[index]['image']
//     :'assets/artists/'+myfavSong[0]['image']
// ),
// fit: BoxFit.cover
// )
// ),
// ),)),
// ],
// ),
// ),
// );
