import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowFavorite extends StatefulWidget {
  @override
  _ShowFavoriteState createState() => _ShowFavoriteState();
}

List myfavSong = [

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
    'artist' : 'Awa Boussim',
    'song_name': 'Koregore',
    'category':'Kora',
    'duration' : '4:00',
    'album_name' : 'Philo',
    'rate' : 4.5,
    'num_part' :153,
    'num_view' : 756,
    'num_dld' : 32,
    'image' : 'awaboussim.jpeg'
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
    'artist' : 'Debordo Leekunfa',
    'song_name': 'Aperitif',
    'category':'Hip-Hop',
    'duration' : '3:00',
    'album_name' : 'Subliminal',
    'rate' : 1.0,
    'num_part' :86,
    'num_view' : 12,
    'num_dld' : 25,
    'image' : 'debordoleekunfa.jpeg'
  },
  {
    'artist' : 'Dez Altino',
    'song_name': 'Kabogde',
    'category':'Rap',
    'duration' : '3:30',
    'album_name' : 'La route',
    'rate' : 2.5,
    'num_part' :125,
    'num_view' : 354,
    'num_dld' : 75,
    'image' : 'dezaltino.jpeg'
  },
  {
    'artist' : 'Salif Keita',
    'song_name': 'Tekere',
    'category':'Rap',
    'duration' : '4:10',
    'album_name' : 'Single',
    'rate' : 5.0,
    'num_part' :43,
    'num_view' : 953,
    'num_dld' : 3204,
    'image' : 'salifkeita.jpeg'
  },
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
];


class _ShowFavoriteState extends State<ShowFavorite> {

  Future <ValueNotifier> recentPlayed ;
  final String recentTable = "RECENT_PLAY";
  final String recent_favDB = "recent_fav.db";
  List<Music> list = [];
  @override
  void initState() {
    //print(recentPlayed);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        body: Container(
          child: FutureBuilder(
            future: Sqlite(
                dataBaseName: recent_favDB, tableName: recentTable
            ).retrieveMusic(),
            builder: (context, snap){
              if(!snap.hasData){
                return Container(child: Center(
                  child: SpinKitFadingCircle(color: Colors.black,),),);
              }else{
                print("okokokok0");
                return ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder:(context,index){
                      final myFav = snap.data[index];
                      print("okokokok");
                      return Card(
                        child: Container(
                          width: 200,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  left: 90,
                                  child: Container(
                                    height: 40,
                                    width: 250,
                                    child: Marques(myFav['artistName'] +
                                        ' - ' + myFav['musicTitle'], Colors.black),)),
                              Positioned(
                                top: 25,
                                left: 120,
                                child: Container(child: Text(myFav['genre'])),),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Container(child: Text("--:--"),)),
                              Positioned(
                                  bottom: 5,
                                  left: 100,
                                  child: Container(
                                    width: width-150,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Container(child: RatingBar.builder(
                                                initialRating: myFav['rate'] + 0.0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 13,
                                                itemBuilder: (context,_)=>Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 10,
                                                ),
                                                onRatingUpdate: (rating){
                                                  print(rating);
                                                })
                                              ,),
                                            SizedBox(width: 2,),
                                            Container(child: Text(myFav['liked'].toString()),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(child: Icon(
                                              Icons.hearing_outlined,
                                              color: Colors.amber,
                                            ),),
                                            SizedBox(width: 2,),
                                            Text(myFav['NListened'].toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(child: Icon(
                                              Icons.download_outlined,
                                              color: Colors.red,
                                            ),),
                                            Text(myFav['Ndownload'].toString()),
                                          ],
                                        ),

                                      ],
                                    ),)),
                              Positioned(
                                  top: 3,
                                  right: 5,
                                  child: Container(
                                    child: Icon(Icons.favorite_rounded,color: Colors.redAccent,),)),
                              Positioned(
                                  child: Container(
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage( index<myfavSong.length?
                                                  'assets/artists/'+myfavSong[index]['image']
                                                  :'assets/artists/'+myfavSong[0]['image']
                                              ),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),)),
                            ],
                          ),
                        ),
                      );
                    }
                );
              }
            },
          )
        ),
      ),
    );
  }
}
