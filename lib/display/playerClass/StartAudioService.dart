
import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';

final _queue = <MediaItem>[];

startAudioPlayerBtn() async{
  List<dynamic> list = List();
  currentPlayingList.value.forEach((element){
    MediaItem value = MediaItem(
        id: element.file,
        album: element.albumName,
        title: element.musicTitle,
        artist: element.artistName,
        artUri: element.artwork,
        duration: Duration(milliseconds: element.duration)
    );
    _queue.add(value);
  });
  for (int i = 0; i < _queue.length; i++) {
    var m = _queue[i].toJson();
    list.add(m);
  }
  var params = {"data": list};
  await AudioService.start(
    backgroundTaskEntrypoint: _audioPlayerTaskEntryPoint,
    androidNotificationChannelName: 'Audio Player',
    androidNotificationColor: 0xFFFF004,
    androidNotificationIcon: 'mipmap/ic_launcher',
    params: params,
  );
}

void _audioPlayerTaskEntryPoint() async {
  await  AudioServiceBackground.run(() => AudioPlayerTask());
}