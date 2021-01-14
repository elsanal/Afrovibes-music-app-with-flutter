import 'package:afromuse/services/models.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

// Player management
ValueNotifier<bool> isTapedToPlay  = ValueNotifier(false);
ValueNotifier<bool> isPlaying = ValueNotifier(false);
ValueNotifier<bool> playerToggleNotifier = ValueNotifier(false);
ValueNotifier<List<SongInfo>> allInternalSongs = ValueNotifier([]);
ValueNotifier<List<SongInfo>> myFavorite = ValueNotifier([]);
ValueNotifier<List<SongInfo>> myRecentPlayed = ValueNotifier([]);
ValueNotifier<List<SongInfo>> currentPlayingList = ValueNotifier<List<SongInfo>>([]);
ValueNotifier<int> currentSongIndex = ValueNotifier(0) ;

// page management

ValueNotifier<int> pageCurrentIndex = ValueNotifier(0) ;
ValueNotifier<int> libraryCurrentPage = ValueNotifier(0);
ValueNotifier<String> appBArTitle = ValueNotifier('Home');


// Lists position
ValueNotifier<int> libraryAllSongsPositionValue = ValueNotifier(0) ;
ValueNotifier<int> librarySongsFromAlbumPositionValue = ValueNotifier(0) ;
ValueNotifier<int> favoriteSongsPositionValue = ValueNotifier(0) ;
ValueNotifier<int> recentPlayedSongsPositionValue = ValueNotifier(0) ;

//// ////// Recent Played List
//
List<Music> recentPlayedMusic = [];

