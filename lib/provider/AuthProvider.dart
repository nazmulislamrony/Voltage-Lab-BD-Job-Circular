import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/UserModels.dart';


class AuthProvider extends ChangeNotifier{
  UserModels _usersModel = UserModels();

  UserModels get usersModel => _usersModel;


  set usersModel(UserModels value) {
    _usersModel = value;
    notifyListeners();
  }



  Future<void> createAccount(String email, String password) async {
    print('Firebase account created');
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    print('Firebase account created');
  }

  Future<void> signIn(String email, String password) async {
    // Sign in with Firebase
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password);
    print('Firebase signed in');
  }

  // void CreateAccount(String? Email,String? password,context) async {
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email:Email! ,
  //         password: password!,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //             'The password provided is too weak.',
  //           )));
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //             'The account already exists for that email.',
  //           )));
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // void SignIn(String? Email,String? password)async{
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: Email!,
  //         password: password!
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }
//  void OtpSend()async{
//    FirebaseAuth auth = FirebaseAuth.instance;
//
// //Get actionCode from the dynamicLink
// //    final Uri deepLink = dynamicLink.link;
//    var actionCode = deepLink.queryParameters['oobCode'];
//
//    try {
//      await auth.checkActionCode(actionCode!);
//      await auth.applyActionCode(actionCode);
//
//      // If successful, reload the user:
//      auth.currentUser?.reload();
//    } on FirebaseAuthException catch (e) {
//      if (e.code == 'invalid-action-code') {
//        print('The code is invalid.');
//      }
//    }
//  }


void SendMail()async{
  User? user = FirebaseAuth.instance.currentUser;
  if (user!= null && !user.emailVerified) {
    await user.sendEmailVerification();
  }
}


void VerificationMail()async{

}


}