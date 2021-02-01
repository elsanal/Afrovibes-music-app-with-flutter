// import 'package:afromuse/display/playerClass/MusicPlayer.dart';
// import 'package:afromuse/display/playerClass/musicPlayerClass.dart';
// import 'package:afromuse/sharedPage/bodyView.dart';
// import 'package:afromuse/staticValues/valueNotifier.dart';
// import 'package:afromuse/services/preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';
// import 'package:path/path.dart';
//
//
// class Dragger extends StatefulWidget {
//   double height;
//   double width;
//   Dragger({this.height,this.width,});
//   @override
//   _DraggerState createState() => _DraggerState();
// }
//
// class _DraggerState extends State<Dragger> {
//   double top =0;
//   double left = 0;
//   @override
//   void initState() {
//     top = widget.height-93.5;
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Container(
//       child: Draggable(
//         child: Container(
//             padding: EdgeInsets.only(
//               top: top,
//               left: left,
//             ),
//             child: ValueListenableBuilder(
//               valueListenable: playerToggleNotifier,
//               builder: (context, value, widget){
//                 if(value == true){
//                   return MusicPlayer();
//                 }else{
//                   return Container();
//                 }
//               },
//             ),
//         ),
//         feedback: Container(
//           padding: EdgeInsets.only(
//             top: top,
//             left: left,
//           ),
//           child:  ValueListenableBuilder(
//             valueListenable: playerToggleNotifier,
//             builder: (context, value, widget){
//               if(value == true){
//                 return MusicPlayer();
//               }else{
//                 return Container();
//               }
//             },
//           ),
//         ),
//         childWhenDragging:  Container(
//           padding: EdgeInsets.only(
//             top: top,
//             left: left,
//           ),
//           child:  ValueListenableBuilder(
//             valueListenable: playerToggleNotifier,
//             builder: (context, value, widget){
//               if(value == true){
//                 return MusicPlayer();
//               }else{
//                 return Container();
//               }
//             },
//           ),
//         ),
//         onDragStarted: (){
//           setState(() {
//             isDragging.value = true;
//             print(isDragging.value);
//           });
//         },
//         onDragCompleted: (){
//           setState(() {
//             isDragging.value = false;
//             print(isDragging.value);
//           });
//         },
//         onDragEnd: (drag){
//           drag.velocity.pixelsPerSecond.dy.ceilToDouble();
//           setState(() {
//             if((top + drag.offset.dy) < 0.0){
//               isTapedToPlay.value = false;
//             }else if((top + drag.offset.dy) < (height - 250)){
//               top = top + drag.offset.dy;
//             }else if((top + drag.offset.dy) > (height - 50)){
//               isTapedToPlay.value = false;
//             }else {
//               top = top ;
//             }
//             if(( drag.offset.dx) > (widget.width - widget.width*(1/3))){
//               isTapedToPlay.value = false;
//             }else if((drag.offset.dx) < - widget.width*(0.7)){
//               isTapedToPlay.value = false;
//             }else if((drag.offset.dx)< 0.0){
//               left = 0;
//             }else if((drag.offset.dx + left) > widget.width*(1/6)){
//               left = widget.width*(1/6);
//             }
//             else{
//               left = left + drag.offset.dx;
//             }
//           });
//         },
//       ),
//     );
//   }
// }
//


























