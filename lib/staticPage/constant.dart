import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

// Player management

ValueNotifier<bool> isTapedToPlay  = ValueNotifier(false);
ValueNotifier<bool> isPlaying = ValueNotifier(false) ;
List<SongInfo> selectedSong = [];
ValueNotifier<int> SongLength = ValueNotifier(0) ;
ValueNotifier<int> songIndex = ValueNotifier(0) ;
ValueNotifier<String> currentArtist = ValueNotifier('');
ValueNotifier<String> currentSongTitle = ValueNotifier('');
ValueNotifier<String> currentSongFilePath = ValueNotifier('');

//AudioPlayer audioPlayer = AudioPlayer();

// page management

ValueNotifier<int> pageCurrentIndex = ValueNotifier(0) ;