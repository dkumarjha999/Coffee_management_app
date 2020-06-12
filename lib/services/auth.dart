import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;   // firebase auth obj for firebase prop use

  // create user obj based on firebaseUser
  User _userFormFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid: user.uid):null;
  }

  // auth change user stream using path dynamic
  Stream<User>get user{          //sign in or sign of type user
    return _auth.onAuthStateChanged
       // .map((FirebaseUser user)=>_userFormFirebaseUser(user));  other method
    .map(_userFormFirebaseUser);
  }

  // sign in anonymous it will be async
   Future signInAnon() async{
     try{
     AuthResult result= await _auth.signInAnonymously();   // this method was enabled
     FirebaseUser user=result.user;
     return _userFormFirebaseUser(user);
     }
     catch(e){
        print(e.toString());
        return null;
       }
   }

  // sign in with mail and pass

  Future regwithEmailAndPass(String email,String password )async{
    try{
      AuthResult result =await _auth.createUserWithEmailAndPassword(email: email, password: password);        // creating new user this is builtin firebase method
      FirebaseUser user=result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid:user.uid).updateUserData('0', 'new member', 100);
      return _userFormFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email and pass

  Future signInwithEmailAndPass(String email,String password )async{
    try{
      AuthResult result =await _auth.signInWithEmailAndPassword(email: email, password: password);        // creating new user this is builtin firebase method
      FirebaseUser user=result.user;

      return _userFormFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  //sign out
 Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
 }

}