import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icesspool/app/modules/login/views/login_view.dart';
import 'package:icesspool/constants.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger_plus/logger_plus.dart';

class ProfileController extends GetxController {
  var logger = new Logger();

  var client = http.Client();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();

  var firstName = "";
  var lastName = "";
  var phoneNumber = "";
  var email = "";

  var photoURL = "";

  var isLoading = false.obs;

  var userId = "";
  @override
  onInit() async {
    try {
      firstNameController.text = "firstName";

      final box = await GetStorage();
      userId = box.read("userId").toString();
      // logger.i(box.read("userId"));
      // log("PROFILE CONTROLLER - ");

      // logger.d(box.read("firstName"));
      // logger.d(box.read("lastName"));
      // logger.d(box.read("phoneNumber"));
      // logger.d(box.read("email"));

      // firstName = box.read("firstName");
      // lastName = box.read("lastName");
      // phoneNumber = box.read("phoneNumber");
      // email = box.read("email") ?? "";

      firstNameController.text = box.read("firstName");

      lastNameController.text = box.read("lastName");
      phoneNumberController.text = box.read("phoneNumber");
      emailController.text = box.read("email") ?? "";
    } catch (e) {
      logger.e(e);
    }

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // final box = await GetStorage();
    // firstName.value = box.read("firstName");
    // lastName.value = box.read("lastName");
    // phoneNumber.value = box.read("phoneNumber");
    // email.value = box.read("email");

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> logout() async {
    Get.deleteAll();
    final box = await GetStorage();
    box.write("isLogin", false);
    Get.to(() => LoginView());
  }

  Future<void> updateProfile(context) async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) {
        isLoading.value = false;
        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Poor internet access. Please try again later.',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
        );
        return;
      }

      isLoading.value = true;

      var uri = Uri.parse(Constants.PROFILE_API_URL);
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumberController.text,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
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
            position: StyledToastPosition.top,
          );
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        phoneNumberController.text = "";

        var json = await response.body;

        var user = jsonDecode(json);

        // final prefs = await SharedPreferences.getInstance();
        final box = await GetStorage();

        showToast(
          backgroundColor: Colors.green.shade800,
          alignment: Alignment.topCenter,
          'Your account is updated sucessfully',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
        );
        box.write("email", emailController.text);
        Get.deleteAll();
        Get.off(() => LoginView());
      } else {
        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Couldnt update your account. Please try again',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
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
        position: StyledToastPosition.top,
      );
    }
  }

  Future deleteAccount() async {
    var uri = Uri.parse(Constants.PROFILE_API_URL);
    var response = await client.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );
  }
}
