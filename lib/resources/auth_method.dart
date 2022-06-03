import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethod{
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String>signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
})
  async{
    String res = 'caught an error';
    try{
      if(email.isNotEmpty|| password.isNotEmpty||username.isNotEmpty||  bio.isNotEmpty|| file != null);
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(cred.user!.uid);

      await _firestore.collection('user').doc(cred.user!.uid).set({
        'username':username,
        'uid':cred.user!.uid,
        'email':email,
        'bio':bio,
        'followers':[],
        'following':[]
      });
      return res='success';
    }

    catch(e){
      res= e.toString();
    }return res;
  }
}