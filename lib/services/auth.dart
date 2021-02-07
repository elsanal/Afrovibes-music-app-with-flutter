import 'package:afromuse/services/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenficationService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///////// create User object from FirebaseUser
  User _firebaseUser(User user){

    return user !=null ? user:null;
  }

///// Check  the changement of state
  Stream<User> get user{
    return _auth.authStateChanges()
        .map(_firebaseUser);
  }


///////// Sign anonymously
  Future signAnonym()async{
    try{
      UserCredential userCredential =  await _auth.signInAnonymously();
      User user = userCredential.user;
      return _firebaseUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }
}