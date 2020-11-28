import 'package:flutter/material.dart';

class ShowFavorite extends StatefulWidget {
  @override
  _ShowFavoriteState createState() => _ShowFavoriteState();
}

List myfavSong = [
  {
    'artist' : 'Malu',
    'song_name': 'respect',
    'category':'Kora',
    'duration' : '4:00',
    'album_name' : 'Philo',
    'image' : 'kora.jpeg'
  },
  {
    'artist' : 'Maitre gims',
    'song_name': 'Tout donner',
    'category':'Hip-Hop',
    'duration' : '3:00',
    'album_name' : 'Subliminal',
    'image' : 'kora.jpeg'
  },
  {
    'artist' : 'Black M',
    'song_name': 'Sur ma route',
    'category':'Rap',
    'duration' : '3:30',
    'album_name' : 'La route',
    'image' : 'kora.jpeg'
  },
  {
    'artist' : 'Smarty',
    'song_name': 'Chapeau du chef',
    'category':'Rap',
    'duration' : '4:10',
    'album_name' : 'Single',
    'image' : 'kora.jpeg'
  },

];

class _ShowFavoriteState extends State<ShowFavorite> {
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
                          bottom: 5,
                          left: 70,
                          child: Container(child: Text(myfavSong[index]['artist']),)),
                      Positioned(
                          top: 3,
                          left: 70,
                          child: Container(child: Text(myfavSong[index]['song_name']),)),
                      Positioned(
                        bottom: 5,
                          right: 5,
                          child: Container(child: Text(myfavSong[index]['duration']),)),
                      Positioned(
                        top: 3,
                          right: 5,
                          child: Container(
                            child: Icon(Icons.favorite_rounded,color: Colors.redAccent,),)),
                      Positioned(
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/category/'+myfavSong[index]['image']),
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
