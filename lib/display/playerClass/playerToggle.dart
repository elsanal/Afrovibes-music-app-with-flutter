
import 'package:afromuse/staticValues/valueNotifier.dart';

getToggle()async{

  bool show = await Future.delayed(Duration(microseconds: 1),()=>true);
  return show;
}