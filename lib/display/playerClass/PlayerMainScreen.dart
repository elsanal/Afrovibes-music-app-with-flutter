import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PlayerMainScreen extends StatefulWidget {
  @override
  _PlayerMainScreenState createState() => _PlayerMainScreenState();
}
List<MediaItem> queue = <MediaItem>[];
class _PlayerMainScreenState extends State<PlayerMainScreen> {


  final _queue = <MediaItem>[];

  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: StreamBuilder<AudioState>(
          stream: _audioStateStream,
          builder: (context, snapshot) {
            final audioState = snapshot.data;
            final queue = audioState?.queue;
            final mediaItem = audioState?.mediaItem;
            final playbackState = audioState?.playbackState;
            final processingState =
                playbackState?.processingState ?? AudioProcessingState.none;
            final playing = playbackState?.playing ?? false;
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (processingState == AudioProcessingState.none) ...[
                    _startAudioPlayerBtn(),
                  ] else
                    ...[
                      //positionIndicator(mediaItem, playbackState),
                      SizedBox(height: 20),
                      if (mediaItem?.title != null) Text(mediaItem.title),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          !playing
                              ? IconButton(
                            icon: Icon(Icons.play_arrow),
                            iconSize: 64.0,
                            onPressed: AudioService.play,
                          )
                              : IconButton(
                            icon: Icon(Icons.pause),
                            iconSize: 64.0,
                            onPressed: AudioService.pause,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.skip_previous),
                                iconSize: 64,
                                onPressed: () {
                                  if (mediaItem == queue.first) {
                                    return;
                                  }
                                  AudioService.skipToPrevious();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.skip_next),
                                iconSize: 64,
                                onPressed: () {
                                  if (mediaItem == queue.last) {
                                    return;
                                  }
                                  AudioService.skipToNext();
                                },
                              )
                            ],
                          ),
                        ],
                      )
                    ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _startAudioPlayerBtn() {
    List<dynamic> list = List();
    currentPlayingList.value.forEach((element){
      MediaItem value = MediaItem(
          id: element.file,
          album: element.albumName,
          title: element.musicTitle,
        artist: element.artistName,
        artUri: element.artwork,
        duration: Duration(minutes: 3)
      );
      _queue.add(value);
    });
    for (int i = 0; i < _queue.length; i++) {
      var m = _queue[i].toJson();
      list.add(m);
    }
    var params = {"data": list};
    return MaterialButton(
      child: Text(_loading ? "Loading..." : 'Start Audio Player'),
      onPressed: () async {
        setState(() {
          _loading = true;
        });
        await AudioService.start(
          backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
          androidNotificationChannelName: 'Audio Player',
          androidNotificationColor: 0xFFFF004,
          androidNotificationIcon: 'mipmap/ic_launcher',
          params: params,
        );
        setState(() {
          _loading = false;
        });
      },
    );
  }
}

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
        (queue, mediaItem, playbackState) => AudioState(
      queue,
      mediaItem,
      playbackState,
    ),
  );
}

void _audioPlayerTaskEntrypoint() async {
 await  AudioServiceBackground.run(() => AudioPlayerTask());
}


