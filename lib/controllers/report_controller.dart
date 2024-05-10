import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/core/location_service.dart';
import 'package:icesspool/model/district.dart';
import 'package:geocoding/geocoding.dart';

import '../constants.dart';
import '../services/data_services.dart';

class ReportController extends GetxController {
  final formKey = new GlobalKey<FormState>();

  final isLoading = false.obs;

  final regions = [].obs;
  final districts = <District>[].obs;

  final reportTypes = [].obs;

  final selectedRegion = "".obs;
  final selectedDistrict = "".obs;
  final communityController = TextEditingController();
  final selectedReportType = "".obs;
  final selectedVideoPath = "".obs;

  final selectedImagePath = "".obs;
  final selectedImageSize = "".obs;
  final count = 0.obs;
  final userId = 0.obs;

  final displayName = "".obs;
  final email = "".obs;
  final photoURL = "".obs;
  final phoneNumber = "".obs;
  final descriptionController = TextEditingController();

  final longitude = 0.0.obs;
  final latitude = 0.0.obs;
  final inactiveColor = Colors.grey.obs;
  var tabIndex = 0;
  late List<Placemark> placemarks = [];

  // void getImage(ImageSource source) async {
  //   final XFile? pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //     maxWidth: double.infinity,
  //     maxHeight: double.infinity,
  //   );
  //
  //   if (pickedFile == null) {
  //     Get.snackbar("Error", "No image was picked",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   } else {
  //     selectedImagePath.value = pickedFile.path;
  //     selectedImageSize.value =
  //         ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
  //                 .toStringAsFixed(2) +
  //             " mb";
  //   }
  // }

  // void getVideo(ImageSource source) async {
  //   final XFile? pickedFile = await ImagePicker().pickVideo(
  //     source: source,
  //   );

  //   if (pickedFile == null) {
  //     Get.snackbar("Error", "No video was reccorded",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   } else {
  //     selectedVideoPath.value = pickedFile.path;
  //     selectedImageSize.value =
  //         ((File(selectedVideoPath.value)).lengthSync() / 1024 / 1024)
  //                 .toStringAsFixed(2) +
  //             " mb";
  //   }
  // }

  // pickVideoFromCamera(ImageSource source) async {
  //   XFile? video = await ImagePicker().pickVideo(
  //     source: source,
  //   );
  //   _cameraVideo = video.toString();

  //   _cameraVideoPlayerController =
  //       VideoPlayerController.file(File(_cameraVideo))
  //         ..initialize().then((_) {
  //           _cameraVideoPlayerController.play();
  //         });
  // }

  @override
  void onInit() async {
    final position = await LocationService.determinePosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;

    final box = await GetStorage();

    userId.value = box.read('userId') ?? 0;

    // var data = Get.arguments;
    // userId.value = data["0"];

    placemarks =
        await placemarkFromCoordinates(latitude.value, longitude.value);

    districts.value = await DataServices.getDistricts();

    displayName.value = box.read('displayName') ?? "";
    email.value = box.read('email') ?? "";
    photoURL.value = box.read('photoURL') ?? "";
    phoneNumber.value = box.read('phoneNumber') ?? "";

    super.onInit();
  }

  void clearSharedPref() async {
    final box = await GetStorage();

    await box.remove('displayName');
    await box.remove('email');
    await box.remove('phoneNumber');

    await box.remove('photoURL');
  }

  void getDistricts() async {
    districts.value = await DataServices.getDistricts();
  }

  void sendReport() async {
    try {
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      if (selectedImagePath == "") {
        Get.snackbar("Error", "No image was picked",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      if (selectedReportType.value == "1" && latitude.value == "") {
        Get.snackbar(
            "Error", "Location is not available. Please turn on your location",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
      formKey.currentState!.save();

      final box = await GetStorage();
      var fcmId = box.read('fcmId');
      var userId = box.read('userId');

      var uri = Uri.parse(Constants.BASE_URL + Constants.SANITATION_API_URL);
      isLoading.value = true;

      var request = http.MultipartRequest('POST', uri);
      request.fields['fcmId'] = fcmId.toString();
      // request.fields['fullName'] = displayName.value.toString();
      // request.fields['email'] = email.value.toString();
      request.fields["userId"] = userId.toString();
      request.fields['districtId'] = selectedDistrict.value.toString();
      request.fields['description'] =
          descriptionController.text.toString() == ""
              ? " "
              : descriptionController.text.toString();
      request.fields['reportType'] = selectedReportType.value.toString();
      request.fields['phoneNumber'] = phoneNumber.value.toString() == ""
          ? " "
          : phoneNumber.value.toString();
      request.fields['latitude'] = latitude.value.toString();
      request.fields['longitude'] = longitude.value.toString();
      request.fields['communityLandmark'] = communityController.text;
      request.fields['placeMark'] = placemarks.toString();

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'nuisancePicture', File(selectedImagePath.value.toString()).path);
      request.files.add(multipartFile);

      var res = await request.send();

      if (res.statusCode == 200) {
        isLoading.value = false;
        selectedImagePath.value = "";
        // selectedDistrict.value = "";
        // selectedReportType.value = "";
        descriptionController.text = "";

        Get.snackbar("Success",
            "Report submitted successfully. Your MMDA would be notified. Thank you!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.shade800,
            duration: Duration(seconds: 10),
            colorText: Colors.white);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "A error occurred. Please try again.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            colorText: Colors.white);
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
    }
  }

  // void sendReport1() async {
  //   try {
  //     // var client = http.Client();
  //     var uri = Uri.parse(Constants.BASE_URL + Constants.SANITATION_API_URL);

  //     var request = http.MultipartRequest('POST', uri);
  //     request.fields['fullName'] = displayName.value.toString();
  //     request.fields['email'] = email.value.toString();
  //     request.fields['district'] = selectedDistrict.value.toString();
  //     request.fields['description'] = descriptionController.text.toString();
  //     request.fields['reportType'] = selectedReportType.value.toString();
  //     request.fields['phoneNumber'] = phoneNumber.value.toString();
  //     request.fields['latitude'] = latitude.value.toString();
  //     request.fields['longitude'] = longitude.value.toString();

  //     request.files.add(http.MultipartFile.fromBytes(
  //         'picture', File(selectedImagePath.toString()).readAsBytesSync(),
  //         filename: "file!.path"));

  //     var res = await request.send();

  //     // var response = await client.post(
  //     //   uri,
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     //   body: jsonEncode(<String, String>{
  //     //     'fullName': displayName.value,
  //     //     'email': email.value.toString(),
  //     //     'district': selectedDistrict.value.toString(),
  //     //     'description': description.value.toString(),
  //     //     'reportType': selectedReportType.value.toString(),
  //     //     'phoneNumber': phoneNumber.value.toString(),
  //     //     'latitude': latitude.value.toString(),
  //     //     'longitude': longitude.value.toString(),
  //     //   }),
  //     // );

  //     // if (response.statusCode == 200) {}
  //   } catch (e) {}
  // }

  // void shareApplication() async {
  //   Share.share(
  //       'Check out this app for sanitation reporting. https://play.google.com/store/apps/details?id=com.icesspool.unified');
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  returnValue(exp) {
    if (exp == "" || exp == "null") {
      return "null";
    } else {
      return exp;
    }
  }
}
