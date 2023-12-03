import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/controllers/home_controller.dart';

import '../contants.dart';

class SingleReportController extends GetxController {
  final controller = Get.put(HomeController());

  final id = 0.obs;
  final community = "".obs;
  final description = "".obs;
  final image = "".obs;
  final longitude = "".obs;
  final latitude = "".obs;
  final statusMessage = "".obs;
  final createdAt = "".obs;
  final status = 0.obs;
  final reportCategoryId = 0.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    id.value = Get.arguments['id'];
    community.value = Get.arguments['community'];
    description.value = Get.arguments['description'];
    image.value = Get.arguments['image'];
    longitude.value = Get.arguments['longitude'];
    latitude.value = Get.arguments['latitude'];
    statusMessage.value = Get.arguments['statusMessage'];
    createdAt.value = Get.arguments['createdAt'];
    status.value = Get.arguments['status'];
    reportCategoryId.value = Get.arguments['reportCategoryId'];

    super.onInit();
  }

  Future<Object> deleteReport(var id) async {
    try {
      var uri =
          Uri.parse(Constants.BASE_URL + Constants.SANITATION_API_URL + "/$id");
      isLoading.value = true;

      final request = http.Request("DELETE", uri);
      request.headers.addAll(<String, String>{
        "Accept": "application/json",
      });
      // request.body = jsonEncode({});
      final response = await request.send();
      inspect(response.statusCode);
      if (response.statusCode == 200) {
        Get.back();
        controller.changeTabIndex(0);
        Get.snackbar("Success", "Report deleted successfully. ",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade800,
            duration: Duration(seconds: 5),
            colorText: Colors.white);

        return 1;
      }

      return Future.error("error: status code ${response.statusCode}");
    } catch (e) {
      inspect(e);
      return 0;
    }
  }
}
