import 'package:afromuse/services/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenficationService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /////////// create User object from FirebaseUser

  User _firebaseUser(FirebaseUser user){
    return user !=null ? User(uid: user.uid):null;
  }

///// Check  the changement of state

  Stream<User> get user{
    return _auth.onAuthStateChanged
                .map(_firebaseUser);
  }


///////// Sign anonymously

  Future signAnonym()async{
    try{
      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _firebaseUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }
}