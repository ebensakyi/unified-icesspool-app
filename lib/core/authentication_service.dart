import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  // Future<String?> signUp(
  //     {required String email, required String password}) async {
  //   log("message");
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     return "Signed up";
  //   } on FirebaseException catch (e) {
  //     return e.message;
  //   }
  // }

  Future signUp({required String email, required String password}) async {
    log("message");
    try {} catch (e) {}
  }

  // Future<Object?> signUpWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } on FirebaseException catch (e) {
  //     return e.message;
  //   }
  // }

  // Future<Object?> signUpWithFacebook() async {
  //   try {
  //     final LoginResult? result = await FacebookAuth.instance.login();

  //     // Create a credential from the access token
  //     final FacebookAuthCredential? facebookAuthCredential =
  //         FacebookAuthProvider.credential(result!.accessToken!.token)
  //             as FacebookAuthCredential?;

  //     // Once signed in, return the UserCredential
  //     return await FirebaseAuth.instance
  //         .signInWithCredential(facebookAuthCredential!);
  //   } on FirebaseException catch (e) {
  //     return e.message;
  //   }
  // }
}
