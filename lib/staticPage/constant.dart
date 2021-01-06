import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';


bool isTapedToPlay = false;
bool isPlaying;
List <SongInfo> selectedSong;
int songIndex;

AudioPlayer audioPlayer = AudioPlayer();