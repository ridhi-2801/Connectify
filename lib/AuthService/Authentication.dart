import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseAuth auth = FirebaseAuth.instance;

 Future<bool> register(String email,String password)async{

   try {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password
     ).then((user) => {
       FirebaseFirestore.instance.collection('Users').doc(user.user!.uid).set({
         'email' :  email,
         'role' : 'user',
       }).then((value) => {print('User Created!')})
     });
     return true;
   } on FirebaseAuthException catch (e) {
     Fluttertoast.showToast(
         msg: "$e",
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
     return false;
   } catch (e) {
     print(e.toString());
     return false;
   }
 }

Future<bool> signIn(String email,String password)async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return true;
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return false;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return false;
    }
  }
  return false;
}
