
/////// Music model

class Music{
  String title;
  Duration displayName;
  String albumArtwork;
  String album;
  String duration;
  String filepath;
  String artist;
  String albumId;
  String artistId;
  String composer;
  String year;
  String id;
  bool isLocal;
  String liked,download,listened;
  String genre;
  String rating;

  Music({
    this.title, this.displayName, this.albumArtwork, this.duration,
    this.id, this.album, this.artist, this.liked, this.rating, this.genre,
    this.albumId, this.artistId, this.composer, this.download, this.year,
    this.filepath, this.listened,this.isLocal
});

  factory  Music.fromJson(Map<String, dynamic> map)=> new Music(
    title : map['title'],
    displayName : map['displayName'],
    albumArtwork : map['albumArtwork'],
    album : map['album'],
    duration : map['duration'],
    filepath : map['filepath'],
    artist : map['artist'],
    albumId : map['albumId'],
    artistId : map['artistId'],
    composer : map['composer'],
    year : map['year'],
    id : map['id'],
    isLocal : map['isLocal'],
    liked : map['liked'],
    download : map['download'],
    listened : map['listened'],
    genre : map['genre'],
    rating : map['rating'],
  );

  Map<String, dynamic>toMap()=>{
   "title" : title,
   "displayName" : displayName,
   "albumArtwork" : albumArtwork,
   "album" : album,
   "duration" : duration,
   "filepath" : filepath,
   "artist" : artist,
   "albumId" : albumId,
   "artistId" : artistId,
   "composer" : composer,
   "year" : year,
   "id" : id,
   "isLocal" : isLocal,
   "liked" : liked,
   "download" : download,
   "listened" : listened,
   "genre" : genre,
  "rating" : rating,
  };
}

////////////////////////// Album model /////////////////

class Album{
  String id;
  String title;
  String artist;
  String numberOfSongs;
  String albumArt;
  String lastYear;
  String firstYear;
  String download;
  bool isLocal;
  String listened;

  Album({
    this.isLocal, this.title, this.listened, this.download, this.artist,
    this.id, this.numberOfSongs, this.albumArt, this.lastYear, this.firstYear
});

  factory Album.fromJson(Map<String, dynamic> map)=> new Album(

    id: map['id'],
    title: map['title'],
    artist: map['artist'],
    numberOfSongs: map['numberOfSongs'],
    albumArt: map['albumArt'],
    lastYear: map['lastYear'],
    firstYear: map['firstYear'],
    download: map['download'],
    isLocal: map['isLocal'],
    listened: map['listened']

  );

  Map<String, dynamic>toMap()=>{
    'id': id,
    'title': title,
    'artist': artist,
    'numberOfSongs': numberOfSongs,
    'albumArt': albumArt,
    'lastYear': lastYear,
    'firstYear': firstYear,
    'download': download,
    'isLocal': isLocal,
    'listened': listened,
  };
}

/////////////////////////playlist model ///////////////////
class Playlist{
  String id;
  String title;
  String owner;
  String numberOfSongs;
  String albumArt;
  String date;
  String isLocal;


  Playlist({
    this.isLocal, this.title, this.owner,
    this.id, this.numberOfSongs, this.albumArt, this.date
  });

  factory Playlist.fromJson(Map<String, dynamic> map)=> new Playlist(

      id: map['id'],
      title: map['title'],
      owner: map['owner'],
      numberOfSongs: map['numberOfSongs'],
      albumArt: map['albumArt'],
      date: map['date'],
      isLocal: map['isLocal'],
  );

  Map<String, dynamic>toMap()=>{
    'id': id,
    'title': title,
    'owner': owner,
    'numberOfSongs': numberOfSongs,
    'albumArt': albumArt,
    'date': date,
    'isLocal': isLocal,
  };
}

////////////////////////user model ///////////////////////

class User{
  String id;
  String name;
  String email;
  String password;
  String uid;
  String telephone;
  String profile;
  String country;
  bool isVIP;
  bool isArtist;
  String musicStyle;
  String age;
  String sex;

  User({
    this.id, this.country,this.age, this.email, this.isArtist, this.isVIP,
    this.musicStyle, this.name, this.sex, this.telephone,this.profile,
    this.password, this.uid
  });

  factory User.fromJson(Map<String, dynamic> map)=> new User(

    id: map['id'],
    name: map['name'],
    email: map['email'],
    password: map['password'],
    uid: map['uid'],
    telephone: map['telephone'],
    musicStyle: map['musicStyle'],
    age: map['age'],
    isVIP: map['isVIP'],
    country: map['country'],
    isArtist: map['isArtist'],
    sex: map['sex'],
    profile: map['profile'],
  );

  Map<String, dynamic>toMap()=>{
    'id': id,
    'name': name,
    'email': email,
    'uid': uid,
    'password': password,
    'telephone': telephone,
    'musicStyle': musicStyle,
    'age': age,
    'isVIP': isVIP,
    'country': country,
    'isArtist': isArtist,
    'sex': sex,
    'profile': profile,
  };
}


