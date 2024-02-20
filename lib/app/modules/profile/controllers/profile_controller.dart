import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/views/login_view.dart';

class ProfileController extends GetxController {
  // final homeController = Get.put(() => HomeController());
  final firstName = TextEditingController();
  var lastName = TextEditingController();

  var email = TextEditingController();
  var photoURL = "".obs;
  var phoneNumber = TextEditingController();

  var isLoading = false.obs;

  final count = 0.obs;
  @override
  onInit() async {
    final box = await GetStorage();

    firstName.text = box.read("firstName");
    lastName.text = box.read("lastName");
    phoneNumber.text = box.read("phoneNumber");
    email.text = box.read("email") ?? "";
    inspect(box.read("phoneNumber"));

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
}
