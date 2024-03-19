import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/bindings/otp_binding.dart';
import 'package:icesspool/contants.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/otp_page_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();

  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  var client = http.Client();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> openUrl() async {
    final url = Uri.parse(
        "https://esicapps-files.s3.eu-west-2.amazonaws.com/privacy-policy/sr-privacy.html");
    await launch(url.toString());
  }

  Future signup(context) async {
    try {
      isLoading.value = true;

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        isLoading.value = false;
        return Get.snackbar(
            "Internet Error", "Poor internet access. Please try again later...",
            snackPosition: SnackPosition.TOP,
            backgroundColor: MyColors.Red,
            colorText: Colors.white);
      }

      var uri = Uri.parse(Constants.SIGNUP_API_URL);
      inspect(uri);
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'phoneNumber': phoneNumberController.text,
          'password': passwordController.text.trim(),
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
        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Phone number used. Check your phone number and try again',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.center,
        );

        // Get.snackbar("Error",
        //     "User already exist. Check your phone number and try again",
        //     snackPosition: SnackPosition.TOP,
        //     backgroundColor: MyColors.Red,
        //     colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar("Error", "Couldnt connect to the server. Please try again",
      //     snackPosition: SnackPosition.TOP,
      //     backgroundColor: MyColors.Red,
      //     colorText: Colors.white);

      showToast(
        backgroundColor: Colors.yellow.shade800,
        alignment: Alignment.center,
        'Couldnt connect to the server. Please try again',
        // context: context,
        animation: StyledToastAnimation.scale,
        duration: Duration(seconds: 4),
        position: StyledToastPosition.center,
      );
    }
  }
}
