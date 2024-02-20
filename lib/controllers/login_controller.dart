// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:icesspool/bindings/home_binding.dart';
import 'package:icesspool/views/home_view.dart';
import 'package:icesspool/views/request_view.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

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

  final showPassword = false.obs;

  @override
  void onInit() async {
    super.onInit();

    await requestPermissions();
    final box = await GetStorage();

    var disclosureViewed = box.read("disclosureViewed");

    if (!disclosureViewed) {
      await showPermissionDisclosure();
    }
  }

  requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.notification,
    ].request();

    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }
    if (await Permission.notification.isPermanentlyDenied) {
      openAppSettings();
    }
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

      final box = await GetStorage();

      await box.write('displayName', displayName);
      await box.write('email', email);
      await box.write('photoURL', photoURL);
      await box.write('phoneNumber', phoneNumber);

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

  Future login(context) async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        isLoading.value = false;
        return Get.snackbar(
            "Internet Error", "Poor internet access. Please try again later...",
            snackPosition: SnackPosition.TOP,
            backgroundColor: MyColors.Red,
            colorText: Colors.white);
      }
      isLoading.value = true;

      var uri = Uri.parse(Constants.LOGIN_API_URL);
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumberController.text,
          'password': passwordController.text,
        }),
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          isLoading.value = false;
          // Get.snackbar("Server Error",
          //     "A server timeout error occured. Please try again later...",
          //     snackPosition: SnackPosition.TOP,
          //     backgroundColor: MyColors.Red,
          //     colorText: Colors.white);

          showToast(
            backgroundColor: Colors.red.shade800,
            alignment: Alignment.topCenter,
            'A server timeout error occured. Please try again later...',
            context: context,
            animation: StyledToastAnimation.fade,
            duration: Duration(seconds: 2),
            position: StyledToastPosition.center,
          );
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        passwordController.text = "";
        phoneNumberController.text = "";

        var json = await response.body;

        var user = jsonDecode(json);

        // final prefs = await SharedPreferences.getInstance();
        final box = await GetStorage();

        if (user["userTypeId"] != 4) {
          return Get.snackbar(
              "Error", "Your account doesn't allow you to access client app",
              snackPosition: SnackPosition.TOP,
              backgroundColor: MyColors.Red,
              colorText: Colors.white);
        }

        var userId = user["id"];
        var email = user["email"];
        var phoneNumber = user["phoneNumber"];
        var firstName = user["firstName"];
        var lastName = user["lastName"];

        inspect(user);

        box.write('userId', userId);
        box.write('phoneNumber', phoneNumber);
        box.write('firstName', firstName);
        box.write('lastName', lastName);
        box.write('email', email);

        box.write('isLogin', true);
        Get.off(() => HomeView(),
            binding: HomeBinding(), arguments: [userId, phoneNumber]);
      } else if (response.statusCode == 400) {
        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Wrong phone number or password. Please try again',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.center,
        );
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;

      showToast(
        backgroundColor: Colors.red.shade800,
        alignment: Alignment.topCenter,
        'Couldnt connect to the server. Please try again',
        context: context,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 2),
        position: StyledToastPosition.center,
      );
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
                    final box = await GetStorage();
                    box.write('disclosureViewed', true);
                    Get.back();
                  },
                  showLoading: false,
                  label: Text("Accept"),
                  textColor: MyColors.primary,
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
                  label: Text("Deny"),
                  textColor: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  togglePasswordVisibility() {
    showPassword.toggle();
  }
}
