import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

// Player management
ValueNotifier<bool> isTapedToPlay  = ValueNotifier(false);
ValueNotifier<bool> isPlaying = ValueNotifier(false) ;
ValueNotifier<List<SongInfo>> allInternalSongs = ValueNotifier([]);
ValueNotifier<List> myFavorite = ValueNotifier([]);
ValueNotifier<int> currentSongIndex = ValueNotifier(0) ;
ValueNotifier<String> appBArTitle = ValueNotifier('Home');
ValueNotifier<AudioManager> audio = ValueNotifier(AudioManager.instance);
// page management
//AudioManager audioManager = AudioManager.instance;
ValueNotifier<int> pageCurrentIndex = ValueNotifier(0) ;
ValueNotifier<int> libraryCurrentPage = ValueNotifier(0);

// Lists position

ValueNotifier<int> libAllSongPos = ValueNotifier(0) ;
ValueNotifier<int> libSongFromAlbumPos = ValueNotifier(0) ;
ValueNotifier<int> favListPos = ValueNotifier(0) ;
ValueNotifier<int> recentListPos = ValueNotifier(0) ;



