import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInWithGoogle() async{
   try{
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

     print(googleUser);
     if(googleUser!=null){
       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
       print(googleAuth);

       final OAuthCredential credential = GoogleAuthProvider.credential(
         idToken: googleAuth.idToken,
         accessToken: googleAuth.accessToken,
       );
       print(credential);
       User? user = (await _auth.signInWithCredential(credential)).user;
       print(user!.providerData);
     }
   }catch(e){
     print(e);
   }
  }


}