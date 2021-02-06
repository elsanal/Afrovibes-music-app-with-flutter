import 'package:afromuse/services/models.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite{

 String  tableName;
 String dataBaseName ;
 Database db;


 Sqlite({this.dataBaseName, this.tableName});



 init(int delay)async{
   db = await Future.delayed(Duration(milliseconds: delay), ()=>database());
   return db;
 }



////// create a table
 Future<Database> database()async{
   return openDatabase(
     join(await getDatabasesPath(),dataBaseName),
     onCreate: (Database dB, int version){
       print("created");
       return dB.execute("CREATE TABLE $tableName("
           "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
           "artistName TEXT,"
           "musicTitle TEXT,"
           "file TEXT,"
           "duration INTEGER,"
           "artwork TEXT,"
           "albumName TEXT,"
           "liked INTEGER,"
           "Ndownload INTEGER,"
           "NListened INTEGER,"
           "genre TEXT,"
           "rate INTEGER"
           ")");
     },
     version: 1,
   );

 }

 ////// Save  music  list file
Future saveSqliteDB(List<MediaItem> musics)async{
   var req = await init(1000);
   musics.forEach((song) {
     req.insert('$tableName', song.toJson(),
       conflictAlgorithm: ConflictAlgorithm.replace,);
   });
   print("Saved on $tableName");
    return true;
   }

//// restore file from sqlite db

Future<List<MediaItem>> retrieveMusic()async{
   var request  = await init(500);
   List<MediaItem> musics = new List();
   List<Map<String, dynamic>> list = await request.query('$tableName');
   list.forEach((song) {
     MediaItem music = MediaItem.fromJson(song);
     musics.add(music);
   });
    return musics;
  }

/////////////// delete element
Future deleteMusic(int id)async{
  var req = await db;
   await req.delete("$tableName", where: "id = ?", whereArgs: [id]);
}

Future<int> maxId()async{
   var req = await init(500);
   var maxIdRes = await req.rawQuery("SELECT MAX(id) as last_inserted_id FROM $tableName");
   var id = maxIdRes.first["last_inserted_id"];
   if(id == null){
      id = 0;
   }else{
     id = id+1;
   }
   return id;
}

Future<bool> checkdB(String path)async{
  var req = await init(500);
  final defaul = await getDatabasesPath();
 final result =   databaseFactory.databaseExists(defaul + '/' + path);
 var tab = req.rawQuery("SELECT name FROM sqlite_master WHERE name=$tableName");
 print(result);
  print(tab);
 return result;
}


}


