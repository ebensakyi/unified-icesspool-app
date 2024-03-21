import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:icesspool/app/modules/login/bindings/login_binding.dart';
import 'package:icesspool/app/modules/login/views/login_view.dart';
import 'package:icesspool/contants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController {
  var client = http.Client();

  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();
  var resetCodeController = TextEditingController();
  var phoneNumber = "";
  var isLoading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    inspect(Get.arguments);

    phoneNumber = Get.arguments[0];
    phoneNumberController.text = phoneNumber;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> resetPassword(context) async {
    try {
      isLoading.value = true;

      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        isLoading.value = false;

        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Poor internet access. Please try again later...',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
        );
        return;
      }

      var uri = Uri.parse(Constants.RESET_PASSWORD_API_URL);
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumber,
          'password': passwordController.text,
          'resetCode': resetCodeController.text,
        }),
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          isLoading.value = false;

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
        var json = await response.body;

        var res = jsonDecode(json);

        // final box = await GetStorage();

        showToast(
          backgroundColor: Colors.green.shade800,
          alignment: Alignment.topCenter,
          'Password reset successfuly',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
        );

        // phoneNumberController.text = "";

        Get.off(() => LoginView(),
            binding: LoginBinding(), arguments: [phoneNumberController.text]);
      }

      if (response.statusCode == 201) {
        var json = await response.body;

        var res = jsonDecode(json);

        // final box = await GetStorage();

        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Wrong user account or reset code. Please try again',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
        );
        return;
      }
      // phoneNumberController.text = "";
    } catch (e) {
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
}
