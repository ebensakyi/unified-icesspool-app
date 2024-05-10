import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:icesspool/app/modules/reset-password/bindings/reset_password_binding.dart';
import 'package:icesspool/app/modules/reset-password/views/reset_password_view.dart';
import 'package:icesspool/constants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  var client = http.Client();

  var phoneNumberController = TextEditingController();

  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> forgotPassword(context) async {
    try {
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
      isLoading.value = true;

      var uri = Uri.parse(Constants.FORGET_PASSWORD_API_URL);
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

          showToast(
            backgroundColor: Colors.red.shade800,
            alignment: Alignment.topCenter,
            'A server timeout error occurred. Please try again later...',
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

        if (res == 0) {
          showToast(
            backgroundColor: Colors.red.shade800,
            alignment: Alignment.topCenter,
            'Wrong user account. Please try again',
            context: context,
            animation: StyledToastAnimation.fade,
            duration: Duration(seconds: 2),
            position: StyledToastPosition.top,
          );
          return;
        }
        // phoneNumberController.text = "";

        Get.off(() => ResetPasswordView(),
            binding: ResetPasswordBinding(),
            arguments: [phoneNumberController.text]);
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;

      showToast(
        backgroundColor: Colors.red.shade800,
        alignment: Alignment.topCenter,
        'Couldn\'t connect to the server. Please try again',
        context: context,
        animation: StyledToastAnimation.fade,
        duration: Duration(seconds: 2),
        position: StyledToastPosition.top,
      );
    }
  }
}
