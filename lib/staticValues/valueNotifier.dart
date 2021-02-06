import 'package:afromuse/services/models.dart';
import 'package:audio_service/audio_service.dart';
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
ValueNotifier<bool> isFull = ValueNotifier(true);

// Lists position
ValueNotifier<int> libraryAllSongsPositionValue = ValueNotifier(0) ;
ValueNotifier<int> librarySongsFromAlbumPositionValue = ValueNotifier(0) ;
ValueNotifier<int> favoriteSongsPositionValue = ValueNotifier(0) ;
ValueNotifier<int> recentPlayedSongsPositionValue = ValueNotifier(0) ;

//// ////// Music List
//

ValueNotifier<List<Music>> allInternalSongs = ValueNotifier<List<Music>>([]);
ValueNotifier<List<MediaItem>> myFavorite = ValueNotifier<List<MediaItem>>([]);
ValueNotifier<List<MediaItem>> myRecentPlayed = ValueNotifier<List<MediaItem>>([]);
ValueNotifier<List<MediaItem>> myPlaylist = ValueNotifier<List<MediaItem>>([]);
ValueNotifier<List<MediaItem>> currentPlayingList = ValueNotifier<List<MediaItem>>([]);
ValueNotifier<List<MediaItem>> currentAlbum = ValueNotifier<List<MediaItem>>([]);