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

  StreamSubscription<AudioPlaybackState> _playerStateSubscription;
  StreamSubscription<AudioPlaybackEvent> _eventSubscription;

  @override
  Future<void> onStart(Map<String, dynamic> params)async{
    _queue.clear();
    List mediaItems = params['data'];
    for (int i = 0; i < mediaItems.length; i++) {
      MediaItem mediaItem = MediaItem.fromJson(mediaItems[i]);
      _queue.add(mediaItem);
    }
    _playerStateSubscription = _audioPlayer.playbackStateStream.where(
            (state) => state == AudioPlaybackState.completed).listen((state) {
              _handlePlayBackComplete();
    });
    _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
      final  bufferingState = event.buffering?AudioProcessingState.buffering:null;
      switch(event.state){
        case AudioPlaybackState.paused:
          _setState(
            processingState: bufferingState?? AudioProcessingState.ready,
            position: event.position,
          );
          break;
        case AudioPlaybackState.playing:
          _setState(
            processingState: bufferingState?? AudioProcessingState.ready,
            position: event.position,
          );
          break;
        case AudioPlaybackState.connecting:
          _setState(
            processingState: bufferingState?? AudioProcessingState.connecting,
            position: event.position,
          );
          break;
        default:
      }
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
      _isPlaying = true;
    }else if(_isPlaying){
      _isPlaying = false;
      await _audioPlayer.stop();
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
      _setState(processingState: AudioProcessingState.ready);
    }
  }


  @override
  Future<void> onFastForward()async{
    await _seekRelative(rewindInterval);
  }

  @override
  Future<void> onRewind()async{
    await _seekRelative(rewindInterval);
  }

  Future<void> _seekRelative(Duration offset)async{
    var newPosition = _audioPlayer.playbackEvent.position + offset;
    if(newPosition < Duration.zero){
      newPosition = Duration.zero;
    }
    if(newPosition > mediaItem.duration){
      newPosition = mediaItem.duration;
    }
    await _audioPlayer.seek(_audioPlayer.playbackEvent.position + offset);
  }


  @override
  Future<void> onSeekTo(Duration position) {
    _audioPlayer.seek(position);
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
    await _audioPlayer.dispose();
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

  Future<void> _setState({
    AudioProcessingState processingState,
    Duration position,
    Duration bufferedPosition,
  })async{
      if(position == null){
        position = _audioPlayer.playbackEvent.position;
      }
      await AudioServiceBackground.setState(
          controls: getControls(),
          systemActions: [MediaAction.seekTo, MediaAction.skipToPrevious, MediaAction.skipToNext],
          processingState: processingState??AudioServiceBackground.state.processingState,
          playing: _isPlaying,
          position: position,
        bufferedPosition: bufferedPosition,
        speed: _audioPlayer.speed

      );
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
  AudioState(this.queue, this.mediaItem, this.playbackState);
}



