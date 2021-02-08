import 'package:afromuse/sharedPage/bodyView.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CurrentPlayingQueue extends StatefulWidget {
  List<MediaItem> currentQueue;
  CurrentPlayingQueue({this.currentQueue});
  @override
  _CurrentPlayingQueueState createState() => _CurrentPlayingQueueState();
}

class _CurrentPlayingQueueState extends State<CurrentPlayingQueue> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  int _totalHour;
  int _totalMinute;
  int _totalSecond;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final List<MediaItem> queue = widget.currentQueue;
    return Container(
      width: width,
      height: height,
      child: ListView.builder(
        itemCount: queue.length,
        itemBuilder: (context, index) {
          if (queue.isEmpty) {
            return Container(child: Center(child: Text("No music founded"),),);
          } else {
            _totalHour = (queue[index].duration.inHours).toInt();
            _totalMinute = (queue[index].duration.inMinutes%60).toInt();
            _totalSecond = (queue[index].duration.inSeconds%60).toInt();
            return InkWell(
              onTap: ()async{
                   await AudioService.skipToQueueItem(queue[index].id);
                   await AudioService.play();
                   Navigator.of(context).pop(true);
              },
              child: Card(
                color: queue[index].id != AudioService.currentMediaItem.id?Colors.white:Colors.grey[300],
                child: Container(
                    width: width,
                    height: 40,
                    child: Stack(children: [
                      Positioned(
                          top: 3,
                          left: 5,
                          child: Container(
                            height: 20,
                            width: width*(3/5),
                            child: Text(queue[index].title, style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                      Positioned(
                          left: 15,
                          bottom: 3,
                          child: Container(
                            child: _totalMinute!=null?new Text(
                              ((_totalHour<=0?"":((_totalHour>0)&(_totalHour<10))?"0$_totalHour : ":"$_totalHour : ")  +
                                  (_totalMinute<10?"0$_totalMinute":"$_totalMinute" ) +
                                  ' : ' + (_totalSecond<10?"0$_totalSecond":"$_totalSecond")
                              ) ,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 14
                                  )
                              ),):Text("-- : --"),
                          )
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                              icon: Icon(Icons.more_vert),
                              iconSize: 20,
                              onPressed: (){})
                      ),
                    ],)
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
