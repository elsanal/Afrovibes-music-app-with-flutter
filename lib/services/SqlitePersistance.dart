import 'package:afromuse/services/models.dart';
import 'package:afromuse/staticPage/valueNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite{

 String  tableName;
 String dataBaseName ;
 Database db;


 Sqlite({this.dataBaseName, this.tableName});


 final delay = Duration(seconds: 2);
 init(int delay)async{
   db = await Future.delayed(Duration(seconds: delay), ()=>database());
   return db;
 }



////// create a table
 Future<Database> database()async{
   return openDatabase(
     join(await getDatabasesPath(),dataBaseName),
     onCreate: (Database dB, int version){
       print("created");
       return dB.execute("CREATE TABLE $tableName("
           "id INTEGER PRIMARY KEY,"
           "artistName TEXT,"
           "musicTitle TEXT,"
           "file TEXT,"
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
Future saveSqliteDB(List<Music> musicList)async{
   var req = await init(2);
   for(int i = 0; i< musicList.length; i++){
     req.insert('$tableName', musicList[i].toMap(),
       conflictAlgorithm: ConflictAlgorithm.replace,);
   }

   }

//// restore file from sqlite db

Future<List> retrieveMusic()async{
   var request  = await init(1);
   List songs = [];
   List<Music> musics = new List();
   List<Map<String, dynamic>> list = await request.query('$tableName');

   final myFavorite = list.toList();

    return myFavorite;
  }

/////////////// delete element
Future deleteMusic(int id)async{
  var req = await db;
   await req.delete("$tableName", where: "id = ?", whereArgs: [id]);
}

Future<int> maxId()async{
   var req = await init(1);
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
  var req = await init(1);
  final defaul = await getDatabasesPath();
 final result =   databaseFactory.databaseExists(defaul + '/' + path);
 var tab = req.rawQuery("SELECT name FROM sqlite_master WHERE name=$tableName");
 print(result);
  print(tab);
 return result;
}


}


