import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/staticPage/valueNotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

// there are automatic setting
autoSavePlayerCurrentInfo()async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isTapedToPlay', isTapedToPlay.value);
  prefs.setBool('isPlaying', isPlaying.value);
  prefs.setInt('currentSongIndex', currentSongIndex.value);
  prefs.setInt('pageCurrentIndex', pageCurrentIndex.value);
}

//////// Read data from preference

readDataPrefs()async{
  final prefs = await SharedPreferences.getInstance();
  isTapedToPlay.value = prefs.getBool('isTapedToPlay')??false;
  isPlaying.value = prefs.getBool('isPlaying')??false;
  currentSongIndex.value = prefs.getInt('currentSongIndex')??0;
  pageCurrentIndex.value = prefs.getInt('pageCurrentIndex')??0;
  appBarTitleFunc(pageCurrentIndex.value);
  prefs.clear();
  prefs.remove('isTapedToPlay');
  prefs.remove('isPlaying');
  prefs.remove('currentSongIndex');
  prefs.remove('pageCurrentIndex');

}

