import 'package:afromuse/services/models.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

// Player management
ValueNotifier<bool> isTapedToPlay  = ValueNotifier(false);
ValueNotifier<bool> isPlaying = ValueNotifier(false);
ValueNotifier<bool> playerToggleNotifier = ValueNotifier(false);
ValueNotifier<int> currentSongIndex = ValueNotifier(0) ;
ValueNotifier<bool> releasePlayer = ValueNotifier(false);
ValueNotifier<bool> isDragging = ValueNotifier(false);
ValueNotifier<bool> isLooping = ValueNotifier(false);
ValueNotifier<bool> isShuffle = ValueNotifier(false);

// page management

ValueNotifier<int> HomepageCurrentIndex = ValueNotifier(0) ;
ValueNotifier<int> libraryCurrentPage = ValueNotifier(0);
ValueNotifier<String> appBArTitle = ValueNotifier('Home');
ValueNotifier<bool> isFull = ValueNotifier(false);

// Lists position
ValueNotifier<int> libraryAllSongsPositionValue = ValueNotifier(0) ;
ValueNotifier<int> librarySongsFromAlbumPositionValue = ValueNotifier(0) ;
ValueNotifier<int> favoriteSongsPositionValue = ValueNotifier(0) ;
ValueNotifier<int> recentPlayedSongsPositionValue = ValueNotifier(0) ;

//// ////// Music List
//

ValueNotifier<List<Music>> allInternalSongs = ValueNotifier<List<Music>>([]);
ValueNotifier<List<Music>> myFavorite = ValueNotifier<List<Music>>([]);
ValueNotifier<List<Music>> myRecentPlayed = ValueNotifier<List<Music>>([]);
ValueNotifier<List<Music>> myPlaylist = ValueNotifier<List<Music>>([]);
ValueNotifier<List<Music>> currentPlayingList = ValueNotifier<List<Music>>([]);
ValueNotifier<List<Music>> currentAlbum = ValueNotifier<List<Music>>([]);