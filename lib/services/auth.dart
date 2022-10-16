

import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_cure/services/database.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebaseUser
  AppUser? _userFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(user.uid) : null;
  }

  //auth change user stream
  Stream<AppUser?> get getUserStream {
    return _auth
        .authStateChanges()
        .map(_userFromFirebaseUser);
    // .map((User? user) => _userFromFirebaseUser(user));

  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if(user != null){
        await DatabaseService(user.uid).updateUserData("Usj3", 45);
      }
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}