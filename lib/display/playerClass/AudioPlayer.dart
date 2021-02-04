import 'dart:async';
import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

MediaControl playControl = MediaControl(
    androidIcon: "drawable/play_arrow",
    label: "Play",
    action: MediaAction.play,
);

MediaControl pauseControl = MediaControl(
    androidIcon: "drawable/pause",
    label: "Pause",
    action: MediaAction.pause,
);

MediaControl stopControl = MediaControl(
    androidIcon: "drawable/stop",
    label: "Stop",
    action: MediaAction.stop,
);

MediaControl nextControl = MediaControl(
    androidIcon: "drawable/skip_next",
    label: "Skip next",
    action: MediaAction.skipToNext,
);

MediaControl previousControl = MediaControl(
    androidIcon: "drawable/skip_previous",
    label: "Skip previous",
    action: MediaAction.skipToPrevious,
);

MediaControl fastForwardControl = MediaControl(
    androidIcon: "drawable/fast_forward",
    label: "Fast forward",
    action: MediaAction.fastForward,
);

MediaControl rewindControl = MediaControl(
    androidIcon: "drawable/fast_rewind",
    label: "Rewind",
    action: MediaAction.rewind,
);

class AudioPlayerTask extends BackgroundAudioTask{

  var _queue = <MediaItem>[];


  int _queueIndex = -1;
  AudioPlayer _audioPlayer = new AudioPlayer();
  AudioProcessingState _audioProcessingState;
  bool _isPlaying;

  bool get hasNext => _queueIndex + 1 < _queue.length;
  bool get hasPrevious => _queueIndex > 0;

  MediaItem get mediaItem => _queue[_queueIndex];

  StreamSubscription<PlayerState> _playerStateSubscription;
  StreamSubscription<PlaybackEvent>  _eventSubscription;

  @override
  Future<void> onStart(Map<String, dynamic> params)async{
    _queue.clear();
    List mediaItems = params['data'];
    for (int i = 0; i < mediaItems.length; i++) {
      MediaItem mediaItem = MediaItem.fromJson(mediaItems[i]);
      _queue.add(mediaItem);
    }

    _playerStateSubscription = _audioPlayer.playerStateStream.listen((event) {
      switch(event.processingState){
        case ProcessingState.completed:
          _handlePlayBackComplete();
          break;
        case ProcessingState.idle:
          onStop();
          break;
        default:
      }
    });

    _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
      _broadcastState();
    });
    AudioServiceBackground.setQueue(_queue);
    onSkipToNext();
  }

  @override
  Future<void> onPlay() {
    if(_audioProcessingState == null){
      _isPlaying = true;
      _audioPlayer.play();
    }
  }

  @override
  Future<void> onPause() {
    _isPlaying = false;
    _audioPlayer.pause();
  }

  @override
  Future<void> onSkipToNext() {
      skip(1);
  }

  @override
  Future<void> onSkipToPrevious() {
    skip(-1);
  }

  void skip(int offset)async{
    int newIndex = _queueIndex + offset;
    if(!(newIndex >= 0 && newIndex < _queue.length)){
      return;
    }
    if( _isPlaying == null){
      _isPlaying = false;
    }
    _queueIndex = newIndex;
    _audioProcessingState = offset > 0?
    AudioProcessingState.skippingToNext:AudioProcessingState.skippingToPrevious;
    AudioServiceBackground.setMediaItem(mediaItem);
    await _audioPlayer.setUrl("${mediaItem.id}");
    _audioProcessingState = null;
    if(_isPlaying == true){
      onPlay();
    }else{
      _broadcastState();
    }
  }


  @override
  Future<void> onFastForward()async{
    await _seekRelative(fastForwardInterval);
  }

  @override
  Future<void> onRewind()async{
    await _seekRelative(rewindInterval);
  }

  Future<void> _seekRelative(Duration offset)async{
    var newPosition = _audioPlayer.position + offset;
    if(newPosition < Duration.zero){
      newPosition = Duration.zero;
    }
    if(newPosition > mediaItem.duration){
      newPosition = mediaItem.duration;
    }
    await _audioPlayer.seek(_audioPlayer.position + offset);
  }


  @override
  Future<void> onSeekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async{
    if(_audioPlayer.playing){
      _audioPlayer.stop();
    }
    _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
      _broadcastState();
    });
    _queue.forEach((element) async{
      if(element.id == mediaId){
        await AudioServiceBackground.setMediaItem(element);
        await _audioPlayer.setUrl(mediaId);
        _audioProcessingState = null;
        onPlay();
      }
    });
  }

  @override
  Future<void> onClick(MediaButton button) {
    _playPause();
  }

  _playPause(){
    if(AudioServiceBackground.state.playing){
      onPause();
    }else{
      onPlay();
    }
  }

  @override
  Future<void> onStop() async{
    await _audioPlayer.stop();
    _eventSubscription.cancel();
    _playerStateSubscription.cancel();
    return await super.onStop();
  }


  _handlePlayBackComplete(){
    if(hasNext){
      onSkipToNext();
    }else{
      onStop();
    }
  }

  Future<void> _broadcastState()async{
      await AudioServiceBackground.setState(
          controls: getControls(),
          systemActions: [MediaAction.seekTo, MediaAction.skipToPrevious, MediaAction.skipToNext],
          processingState: _getProcessingState(),
          playing: _audioPlayer.playing,
          position: _audioPlayer.position,
          bufferedPosition: _audioPlayer.bufferedPosition,
          speed: _audioPlayer.speed,
          androidCompactActions: [0, 1, 3],
        
      );

  }

  AudioProcessingState _getProcessingState(){
    // if(_audioProcessingState!=null) return _audioProcessingState;
    switch(_audioPlayer.processingState){
      case ProcessingState.completed:
        return AudioProcessingState.completed;
        break;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
        break;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
        break;
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
        break;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
        break;
      default:
        throw Exception("Invalid State ${_audioPlayer.processingState}");
    }

  }

  List<MediaControl> getControls(){
    if(_isPlaying){
      return [
        previousControl,
        pauseControl,
        stopControl,
        nextControl,
      ];
    }else{
      return [
        previousControl,
        playControl,
        stopControl,
        nextControl,
      ];
    }
  }
}


class AudioState{
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;
  final Duration position;
  AudioState(this.queue, this.mediaItem, this.playbackState,this.position);
}

class FullAudioPlayerState{
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;
  final Duration position;
  FullAudioPlayerState(this.queue, this.mediaItem, this.playbackState, this.position);
}

class PlayerPosition {
  final Duration position;
  PlayerPosition( this.position);
}



