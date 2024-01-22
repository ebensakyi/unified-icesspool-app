import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../bindings/home_binding.dart';
import '../contants.dart';
import '../views/home_view.dart';

class OtpController extends GetxController {
  var client = http.Client();

  final isLoading = false.obs;

  final surnameController = TextEditingController();
  final otherNamesController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyController = TextEditingController();

  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  final num3Controller = TextEditingController();
  final num4Controller = TextEditingController();

  var userId, phoneNumber, lastName, firstName = "";

  @override
  void onInit() {
    var arguments = Get.arguments;

    userId = arguments[0].toString();
    phoneNumber = arguments[1];

    inspect(arguments);

    super.onInit();
  }

  verifyOtp() async {
    try {
      var code = "${num1Controller.text}" +
          "${num2Controller.text}" +
          "${num3Controller.text}" +
          "${num4Controller.text}";

      var uri = Uri.parse(Constants.VALIDATE_ACCOUNT_API_URL);
      var response = await client
          .post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'code': code,
          'userId': userId.toString(),
          'phoneNumber': phoneNumber
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
              backgroundColor: Colors.red,
              colorText: Colors.white);
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        var json = await response.body;

        var user = jsonDecode(json);

        final prefs = await SharedPreferences.getInstance();

        var userId = user["id"];
        // var email = user["email"];
        var phoneNumber = user["phoneNumber"];
        var firstName = user["firstName"];
        var lastName = user["lastName"];

        prefs.setInt('userId', userId);
        prefs.setString('phoneNumber', phoneNumber);
        prefs.setString('firstName', firstName);
        prefs.setString('lastName', lastName);

        prefs.setBool('isLogin', true);
        Get.off(() => HomeView(),
            binding: HomeBinding(), arguments: [userId, phoneNumber]);
      }
    } catch (e) {
      inspect(e);
    }
  }
}
