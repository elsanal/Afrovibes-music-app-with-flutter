import 'package:afromuse/staticValues/valueNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String _playlistName ;
ValueNotifier<bool> isError = ValueNotifier<bool>(false);
String _Error = "Please enter playlist name!!!";

ValueNotifier<bool> activeWhiteSpace = ValueNotifier<bool>(false);
 playlistCreation(BuildContext context){
   final _formKey = GlobalKey<FormState>();
   TextEditingController _textController = TextEditingController();

  return Alert(
    title: 'Create new playlist',
    context: context,
    closeFunction: (){
      _playlistName = null;
      Navigator.of(context).pop(true);
    },
    buttons: [
        DialogButton(
          color: Colors.black87,
            child: Text("Cancel", style: TextStyle(color: Colors.white),),
            onPressed:(){
              _playlistName = null;
              Navigator.of(context).pop(true);
            }),
        DialogButton(
            color: Colors.black87,
            child: Text("Confirm", style: TextStyle(color: Colors.white),),
            onPressed:(){
              if((_playlistName!=null)&_formKey.currentState.validate()){
                HomepageCurrentIndex.value = 6;
                return Navigator.of(context).pop(true);
              }
            })
    ],
    content: Container(
      width: 300,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Container(
                child: new TextFormField(
                  controller: _textController,
                     validator: (val) {
                       if(!(val.contains(RegExp(r'[a-zA-Z0-9]'),0))&(val.length>=1)
                           ||(val == null)|| (val.length<2)){
                         String text = '';
                         _textController.value = _textController.value.copyWith(
                             text: text,
                           composing: TextRange.empty,
                           selection: TextSelection(baseOffset: text.length, extentOffset: text.length),

                         );
                         return _Error;
                       }else{
                         return null;
                       }
                     },
                     decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter playlist name",
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    //contentPadding: EdgeInsets.all(10),
                  ),
                  //autovalidate: true,
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    _playlistName = value;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  )..show();
}

