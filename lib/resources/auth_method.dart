import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as model;


class AuthMethod{
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<model.User?>getUserDetails()async{
   try{
   User currentUser = _auth.currentUser!;

   DocumentSnapshot snap = await _firestore.collection('user').doc(currentUser.uid).get();
   return model.User.fromSnap(snap);}
   catch(e){
     print('error:$e');
   }


 }

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
      if(email.isNotEmpty|| password.isNotEmpty||username.isNotEmpty||  bio.isNotEmpty|| file!= null) {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(cred.user!.uid);

      String photoUrl = await StorageMethod().uploadImageToStorage('profilePics', file, false);

      model.User user = model.User (
        username:username,
        uid:cred.user!.uid,
        email:email,
        bio:bio,
        followers:[],
        following:[],
        photoUrl:photoUrl
      );

      await _firestore.collection('user').doc(cred.user!.uid).set(user.toJson());
      return res='success';
    }}

    catch(e){
      res= e.toString();
    }return res;
  }
  Future<String>loginUser({
  required String email,
    required String password})
  async {
    String res = 'some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else{
        res = 'Enter all the provided fileds';
      }
    }
    catch(e){
      res = e.toString();
    }return res;
  }
}

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String>uploadImageToStorage(
      String childName, Uint8List file, bool isPost)
  async {
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask =  ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

