import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icesspool/app/modules/login/views/login_view.dart';
import 'package:icesspool/contants.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProfileController extends GetxController {
  var client = http.Client();
  final firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  var emailController = TextEditingController();
  var photoURL = "".obs;
  var phoneNumberController = TextEditingController();

  var isLoading = false.obs;

  final count = 0.obs;

  var passwordController = TextEditingController();

  var cpasswordController = TextEditingController();
  @override
  onInit() async {
    final box = await GetStorage();

    firstNameController.text = box.read("firstName");
    lastNameController.text = box.read("lastName");
    phoneNumberController.text = box.read("phoneNumber");
    emailController.text = box.read("email") ?? "";

    // log("firstName.value===> ${firstName.value}");
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

  void increment() => count.value++;

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
          position: StyledToastPosition.center,
        );
        return;
      }

      if (cpasswordController.text != passwordController.text) {
        isLoading.value = false;
        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Passwords do not match.',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.center,
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
          'password': passwordController.text,
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

        showToast(
          backgroundColor: Colors.green.shade800,
          alignment: Alignment.topCenter,
          'Your account is updated sucessfully',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.center,
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
}
