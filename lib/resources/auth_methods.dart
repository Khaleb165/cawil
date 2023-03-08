// ignore_for_file: unused_import

import 'package:cawil/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cawil/models/user.dart' as model;



class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // signUp user
  Future<String> signUpUser ({
    required String username,
    required String email,
    required String password,
    required Uint8List file,
})
  async{
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||file !=null){
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await  StorageMethods().uploadImageToStorage('profilePics', file, false);

        //add user to the database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'email': email,
          'uid': cred.user!.uid,
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } catch(error){
      res = error.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser({
    required String email,
    required String password,
}) async {
    String res = 'Some error occured';
    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      }else{
        res = 'Please fill all the fields';
      }
    } catch(error){
      res = error.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

