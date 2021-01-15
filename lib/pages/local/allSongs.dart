import 'dart:async';

import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
import 'package:afromuse/display/playerClass/playerToggle.dart';
import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/services/SqlitePersistance.dart';
import 'package:afromuse/services/downlaodData.dart';
import 'package:afromuse/services/models.dart';
import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:afromuse/staticValues/constant.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:afromuse/services/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class LocalSongs extends StatefulWidget {
  int position;
  LocalSongs({this.position});
  @override
  _LocalSongsState createState() => _LocalSongsState();
}
class _LocalSongsState extends State<LocalSongs> {

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  int position;

   @override
  void initState(){
     setState(() {
       position = widget.position;
     });

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
          future: getInternalData().getAllInternalSongs(null),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Container();
            }else{
              return Container(
                  height: height,
                margin: EdgeInsets.only(
                  bottom: 40,
                ),
                  child:ScrollablePositionedList.builder(
                    initialScrollIndex:widget.position!=null?widget.position:0,
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionsListener,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Music music = snapshot.data[index];
                      if (music == null) {
                        return Container(child: Center(child: Text("No music founded"),),);
                      } else {
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

                            List<Music> musicList = new List();
                            musicList.add(music);

                            await Sqlite(dataBaseName: singleDatabase,
                                tableName: RECENT_PLAYED_TABLE)
                                 .saveSqliteDB(musicList);
                          },
                          child: Card(
                            color: Colors.white,
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



