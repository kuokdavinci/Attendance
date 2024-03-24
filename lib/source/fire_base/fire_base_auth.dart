import 'package:firebase_auth/firebase_auth.dart';


class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 Future <User?> signUpWithEmailAndPassword(String email,String pass) async{

   try{
     UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
     return credential.user;
   }catch(e){
     print('Email is aleady exists');
   }
   return null;
 }
  Future <User?> signInWithEmailAndPassword(String email,String pass,bool onSuccess) async{

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return credential.user;
    }catch(e){
      onSuccess =false;
      print('Email or Password is incorrect');
    }
    return null;
  }
}