import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:icesspool/bindings/home_binding.dart';
import 'package:icesspool/views/home_view.dart';
import 'package:icesspool/views/request_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../bindings/report_binding.dart';
import '../contants.dart';
import '../themes/colors.dart';
import '../widgets/small-button.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  var client = http.Client();

  final loginFormKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();

    var disclosureViewed = prefs.getInt("disclosureViewed");

    if (disclosureViewed != 1) {
      await showPermissionDisclosure();
    }
    log("disclosureViewed $disclosureViewed");
  }

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      var displayName = user!.displayName ?? "";
      var email = user.email ?? "";
      var photoURL = user.photoURL ?? "";
      var phoneNumber = user.phoneNumber ?? "";

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('displayName', displayName);
      await prefs.setString('email', email);
      await prefs.setString('photoURL', photoURL);
      await prefs.setString('phoneNumber', phoneNumber);

      // inspect(displayName);
      // inspect(email);
      // inspect(photoURL);

      // inspect(user);
      // // assert(user!.isAnonymous);
      // // assert(await user!.getIdToken() != null);
      // final User? currentUser = _auth.currentUser;
      // inspect(currentUser);
      // assert(user!.uid == currentUser!.uid);
      Get.off(() => RequestView()); // navigate to your wanted page
      return;
    } catch (e) {
      throw (e);
    }
  }

  // Future<UserCredential> loginWithFacebook() async {
  //   //inspect("here");
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   // Once signed in, return the UserCredential

  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  // loginWithFacebook1() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         final AuthCredential facebookCredential =
  //             FacebookAuthProvider.credential(result.accessToken!.token);
  //         final userCredential =
  //             await _auth.signInWithCredential(facebookCredential);
  //         return;
  //       // Resource(status: Status.Success);
  //       case LoginStatus.cancelled:
  //         return;
  //       // Resource(status: Status.Cancelled);
  //       case LoginStatus.failed:
  //         return;
  //       //Resource(status: Status.Error);
  //       default:
  //         return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw e;
  //   }
  // }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }

  Future signUpLogin() async {
    try {
      // bool result = await InternetConnectionChecker().hasConnection;
      // if (result == false) {
      //   isLoading.value = false;
      //   return Get.snackbar(
      //       "Internet Error", "Poor internet access. Please try again later...",
      //       snackPosition: SnackPosition.TOP,
      //       backgroundColor: MyColors.Red,
      //       colorText: MyColors.White);
      // }

      var uri = Uri.parse(Constants.BASE_URL + Constants.LOGIN_API_URL);
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumberController.text,
        }),
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          isLoading.value = false;
          Get.snackbar("Server Error",
              "A server timeout error occured. Please try again later...",
              snackPosition: SnackPosition.TOP,
              backgroundColor: MyColors.Red,
              colorText: Colors.white);
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );
      inspect(response);
      isLoading.value = false;

      if (response.statusCode == 200) {
        var json = await response.body;

        var user = jsonDecode(json);

        final prefs = await SharedPreferences.getInstance();

        var userId = user["id"];
        // var email = user["email"];
        var phoneNumber = user["phoneNumber"];

        prefs.setInt('userId', userId);
        prefs.setString('phoneNumber', phoneNumber);

        Get.off(() => HomeView(),
            binding: HomeBinding(), arguments: [userId, phoneNumber]);
      } else if (response.statusCode == 400) {
        Get.snackbar(
            "Error", "Wrong phone number or password. Please try again",
            snackPosition: SnackPosition.TOP,
            backgroundColor: MyColors.Red,
            colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
      Get.snackbar("Error", "Couldnt connect to the server. Please try again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: MyColors.Red,
          colorText: Colors.white);
    }
  }

  showPermissionDisclosure() async {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              //child: CircularProgressIndicator(),
            ),
            Text("Permissions Required"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                '''iCesspool collects location data when the app is open.\nThe reporting feature uses the location of the user.
                \nThis enable us know where you are submitting your reported from.\n\nAd permissions are used to provide analytics to improve user experience. App also requires camera and file permissions to be able to take picture or pick picture from phone gallery'''),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('disclosureViewed', 1);
                    Get.back();
                  },
                  showLoading: false,
                  label: "Accept",
                ),
                SmallButton(
                  backgroundColor: MyColors.Red,
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  showLoading: false,
                  label: "Deny",
                )
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
