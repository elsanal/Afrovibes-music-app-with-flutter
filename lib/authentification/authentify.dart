import 'package:afromuse/pages/Homebody/Homepage.dart';
import 'package:afromuse/services/auth.dart';
import 'package:afromuse/services/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authentify extends StatelessWidget {
  final AuthenficationService _authenficationService = AuthenficationService();
  @override
  Widget build(BuildContext context) {

    final user  = Provider.of<User>(context);
    if(user == null){
      _authenficationService.signAnonym();

    }
    return Homepage();

  }
}
