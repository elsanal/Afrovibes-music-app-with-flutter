import 'package:afromuse/display/playerClass/AudioPlayer.dart';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PlayerMainScreen extends StatefulWidget {
  @override
  _PlayerMainScreenState createState() => _PlayerMainScreenState();
}

class _PlayerMainScreenState extends State<PlayerMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              child: StreamBuilder<AudioState>(
                stream: _audioStateStream,
                builder: (context, snapshot){
                  final audioState = snapshot.data;
                  final queue = audioState?.queue;
                  final mediaItem = audioState?.mediaItem;
                  final playbackState = audioState?.playbackState;
                  final processingState = playbackState?.processingState??AudioProcessingState.none;
                  final isPlaying = playbackState?.playing??false;

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if(processingState == AudioProcessingState.none)...[
                          _startAudioPlayBtn(),
                          ]else ...[
                          new SizedBox(height: 20,),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.skip_previous),
                                  onPressed: (){
                                    if(mediaItem == queue.first){
                                      return;
                                    }
                                    AudioService.skipToPrevious();
                                  }
                              ),
                              !isPlaying?
                                  IconButton(
                                      icon: Icon(Icons.play_circle_outline_rounded),
                                      onPressed:AudioService.play,
                                  ):IconButton(
                                  icon: Icon(Icons.pause),
                                  onPressed: AudioService.pause
                              ),
                              IconButton(
                                  icon: Icon(Icons.skip_next),
                                  onPressed: (){
                                    if(mediaItem == queue.last){
                                      return;
                                    }
                                    AudioService.skipToNext();
                                  }
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
          ],
        ),
    );
  }

  _startAudioPlayBtn(){
    //await _audioPlayer.setFilePath(currentPlayingList.value.first.file);
    return MaterialButton(
      child: Text("Start play"),
      onPressed: ()async{
        //await _audioPlayer.play();
        await AudioService.start(backgroundTaskEntrypoint: _audioTaskEntryPoint,
        androidNotificationChannelName: "Background player",
        androidNotificationColor: 0xF2222f5,
          androidNotificationIcon: "mipmap/ic_launcher"
        );
      },
    );
  }
}

void _audioTaskEntryPoint()async{
  AudioServiceBackground.run(() => AudioPlayerTask());
}


Stream<AudioState> get _audioStateStream{
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, AudioState>(
      AudioService.queueStream,AudioService.currentMediaItemStream,AudioService.playbackStateStream,
          (queue,mediaItem,playbackState) => AudioState(queue, mediaItem, playbackState));
}
