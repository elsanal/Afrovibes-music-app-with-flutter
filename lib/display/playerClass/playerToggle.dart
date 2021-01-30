
import 'package:afromuse/staticValues/valueNotifier.dart';

getToggle()async{

  bool show = await Future.delayed(Duration(milliseconds: 100),()=>true);
  return show;
}