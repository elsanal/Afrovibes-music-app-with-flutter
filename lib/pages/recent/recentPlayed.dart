import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticPage/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        body: Container(
          child: ListView.builder(
              itemCount: myfavSong.length,
              itemBuilder:(context,index){
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
                              child: Marques(myfavSong[index]['artist'] +
                                  ' - ' + myfavSong[index]['song_name'], Colors.black),)),
                        Positioned(
                          top: 25,
                          left: 120,
                          child: Container(child: Text(myfavSong[index]['category'])),),
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(child: Text(myfavSong[index]['duration']),)),
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
                                          initialRating: myfavSong[index]['rate'],
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
                                      Container(child: Text(myfavSong[index]['num_part'].toString()),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(child: Icon(
                                        Icons.hearing_outlined,
                                        color: Colors.amber,
                                      ),),
                                      SizedBox(width: 2,),
                                      Text(myfavSong[index]['num_view'].toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(child: Icon(
                                        Icons.download_outlined,
                                        color: Colors.red,
                                      ),),
                                      Text(myfavSong[index]['num_dld'].toString()),
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
                                        image: AssetImage('assets/artists/'+myfavSong[index]['image']),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),)),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
