import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
  final int countdownDuration = 60; // Duration in seconds
  RxInt countdown = 60.obs;
  Timer? _timer;
  final hideTimer = false.obs;
  RxDouble progress = 1.0.obs;

  @override
  void onInit() {
    startCountdown();
    var arguments = Get.arguments;

    userId = arguments[0].toString();
    phoneNumber = arguments[1];

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

        box.write('isLogin', true);
        Get.off(() => HomeView(),
            binding: HomeBinding(), arguments: [userId, phoneNumber]);
      }
    } catch (e) {
      inspect(e);
    }
  }

  Future<void> resendOtp() async {
    startCountdown();
    countdown.value = 60;
    hideTimer.value = false;
    final String apiUrl = Constants.RESEND_OTP_API_URL;

    final Uri uri = Uri.parse(apiUrl);

    try {
      var response = await client.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
        }),
      );
      if (response.statusCode == 200) {
        // Successful response
        final data = json.decode(response.body);
        inspect(data);

        // biodigesterServicesAvailable.value = data;
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception getAvailableBiodigesterPricing: $error');
    }
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      countdown.value -= 1;
      progress.value -= 0.01;

      if (countdown.value <= 0) {
        _timer?.cancel();
        hideTimer.value = true;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
}
