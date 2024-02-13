import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icesspool/bindings/otp_binding.dart';
import 'package:icesspool/views/otp_page_view.dart';

import 'package:http/http.dart' as http;

import '../contants.dart';
import '../themes/colors.dart';

class SignupController extends GetxController {
  var isLoading = false.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();

  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  var client = http.Client();

  final loginFormKey = GlobalKey();

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() async {
    super.onInit();
    await GetStorage();
  }

  Future signup() async {
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

      var uri = Uri.parse(Constants.SIGNUP_API_URL);
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'phoneNumber': phoneNumberController.text,
          'password': passwordController.text,
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
      isLoading.value = false;

      inspect(response.statusCode);

      if (response.statusCode == 200) {
        var json = await response.body;

        var user = jsonDecode(json);

        final box = await GetStorage();

        var userId = user["id"];
        // var email = user["email"];
        var phoneNumber = user["phoneNumber"];
        var firstName = user["firstName"];
        var lastName = user["lastName"];

        box.write('userId', userId);
        box.write('phoneNumber', phoneNumber);
        box.write('firstName', firstName);
        box.write('lastName', lastName);

        // Get.off(() => HomeView(),
        //     binding: HomeBinding(), arguments: [userId, phoneNumber]);
        Get.off(() => OtpPageView(),
            binding: OtpBinding(), arguments: [userId, phoneNumber]);
      } else if (response.statusCode == 400) {
        Get.snackbar("Error", "Sign-up not successful. Please try again",
            snackPosition: SnackPosition.TOP,
            backgroundColor: MyColors.Red,
            colorText: Colors.white);
      } else if (response.statusCode == 401) {
        Get.snackbar("Error",
            "User already exist. Check your phone number and try again",
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
}
