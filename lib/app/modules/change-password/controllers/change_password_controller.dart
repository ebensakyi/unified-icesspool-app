import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icesspool/app/modules/login/views/login_view.dart';
import 'package:icesspool/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger_plus/logger_plus.dart';

class ChangePasswordController extends GetxController {
  var logger = new Logger();

  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var isLoading = false.obs;
  var client = http.Client();
  final obscurePassword1 = true.obs;
  final obscurePassword2 = true.obs;
  final obscurePassword3 = true.obs;

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

  Future<void> changePassword(BuildContext context) async {
    try {
      if (cpasswordController.text != passwordController.text) {
        isLoading.value = false;
        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Passwords do not match.',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
        );
        return;
      }
      isLoading.value = true;

      var uri = Uri.parse(Constants.CHANGE_PASSWORD_API_URL);
      log(uri.toString());
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumberController.text,
          'oldPassword': oldPasswordController.text,
          'newPassword': passwordController.text,
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
        oldPasswordController.text = "";

        passwordController.text = "";
        cpasswordController.text = "";

        var json = await response.body;

        var user = jsonDecode(json);

        // final prefs = await SharedPreferences.getInstance();
        final box = await GetStorage();

        showToast(
          backgroundColor: Colors.green.shade800,
          alignment: Alignment.topCenter,
          'Your password is updated sucessfully',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 2),
          position: StyledToastPosition.top,
        );
        Get.deleteAll();
        Get.off(() => LoginView());
      } else {
        showToast(
          backgroundColor: Colors.red.shade800,
          alignment: Alignment.topCenter,
          'Couldnt update your password. Please check your phone number and current password',
          context: context,
          animation: StyledToastAnimation.fade,
          duration: Duration(seconds: 3),
          position: StyledToastPosition.top,
        );
      }
    } catch (e) {
      logger.i(e);
    }
  }

  togglePasswordVisibility1() {
    obscurePassword1.toggle();
  }

  togglePasswordVisibility2() {
    obscurePassword2.toggle();
  }

  togglePasswordVisibility3() {
    obscurePassword3.toggle();
  }
}
