import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

// Player management

ValueNotifier<bool> isTapedToPlay = ValueNotifier(false);

ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
List<SongInfo> selectedSong ;
ValueNotifier<int> songIndex = ValueNotifier<int>(0);

AudioPlayer audioPlayer = AudioPlayer();

// page management

ValueNotifier<int> pageCurrentIndex = ValueNotifier<int>(0);