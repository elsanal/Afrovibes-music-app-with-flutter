import 'package:afromuse/staticPage/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

// there are automatic setting
autoSaveTapedToPlay()async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isTapedToPlay', isTapedToPlay.value);
}

autoSaveIsPlaying()async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isPlaying', isPlaying.value);
}
autoSaveIndexCurrentSong(String currentArtist, String currentSongTitle, String currentSongFilePath)async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('songIndex', songIndex.value);
  prefs.setString('currentArtist', currentArtist);
  prefs.setString('currentSongTitle', currentSongTitle);
  prefs.setString('currentSongFilePath', currentSongFilePath);
}
autoSaveCurrentPage()async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('pageCurrentIndex', pageCurrentIndex.value);
}


//////// Read data from preference

readDataPrefs()async{
  final prefs = await SharedPreferences.getInstance();
  isTapedToPlay.value = prefs.getBool('isTapedToPlay')??false;
  isPlaying.value = prefs.getBool('isPlaying')??false;
  songIndex.value = prefs.getInt('songIndex')??0;
  currentArtist.value = prefs.getString('currentArtist')??'';
  currentSongTitle.value = prefs.getString('currentSongTitle')??'';
  currentSongFilePath.value = prefs.getString('currentSongFilePath')??'';

  pageCurrentIndex.value = prefs.getInt('pageCurrentIndex')??0;
}

