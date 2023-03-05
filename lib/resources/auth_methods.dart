// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // signUp user
  Future<String> signUpUser ({
    required String username,
    required String email,
    required String password,
    //required Uint8List file,
})
  async{
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty){
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        //add user to the database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'email': email,
          'uid': cred.user!.uid,
        });
      }
    }catch(error){
      res = error.toString();
    }
    return res;
  }
}