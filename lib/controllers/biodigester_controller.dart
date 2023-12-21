import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:icesspool/core/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:package_info/package_info.dart';

import '../contants.dart';
import '../themes/colors.dart';
import '../widgets/small-button.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';

class BiodigesterController extends GetxController {
  final formKey = new GlobalKey<FormState>();

  final isLoading = false.obs;

  final selectedRegion = "".obs;
  final selectedDistrict = "".obs;
  final selectedDistrictId = "".obs;
  final communityController = TextEditingController();
  final selectedRequestType = "".obs;
  final selectedReportCategory = "".obs;
  final selectedVideoPath = "".obs;

  final selectedImagePath = "".obs;
  final selectedImageSize = "".obs;
  final count = 0.obs;
  final userId = 0.obs;

  final displayName = "".obs;
  final email = "".obs;
  final photoURL = "".obs;
  final phoneNumber = "".obs;
  final address = "".obs;
  final descriptionController = TextEditingController();

  final longitude = 0.0.obs;
  final latitude = 0.0.obs;
  final accuracy = 0.0.obs;
  final inactiveColor = Colors.grey.obs;
  var currentIndex = 0.obs;
  var currentTitle = "Report".obs;
  List<String> titlesList = ["Home", "Report Status", "About"];

  late List<Placemark> placemarks = [];

  final currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;

  @override
  void onInit() async {
    await getUserArea();
    final prefs = await SharedPreferences.getInstance();

    final position = await LocationService.determinePosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    accuracy.value = position.accuracy;

    userId.value = prefs.getInt('userId') ?? 0;

    await getAddressFromCoords();

    // placemarks =
    //     await placemarkFromCoordinates(latitude.value, longitude.value);

    displayName.value = prefs.getString('displayName') ?? "";
    email.value = prefs.getString('email') ?? "";
    photoURL.value = prefs.getString('photoURL') ?? "";
    phoneNumber.value = prefs.getString('phoneNumber') ?? "";

    super.onInit();
  }

  Future<void> changeTabIndex(int index) async {
    try {
      currentIndex.value = index;
      currentTitle.value = titlesList[index];

      await getUserArea();

      if (index == 1) {
        isLoading.value = true;
        // reports.value = await DataServices.getReports(userId);
        isLoading.value = false;
      }

      update();
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  // void getImage(ImageSource source) async {
  //   final XFile? pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //     maxWidth: double.infinity,
  //     maxHeight: double.infinity,
  //   );

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

  void clearSharedPref() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('displayName');
    await prefs.remove('email');
    await prefs.remove('phoneNumber');

    await prefs.remove('photoURL');
  }

  // void getDistricts() async {
  //   try {
  //     districts.value = await DataServices.getDistricts();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future sendReport() async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        isLoading.value = false;
        return Get.snackbar(
            "Internet Error", "Poor internet access. Please try again later...",
            snackPosition: SnackPosition.TOP,
            backgroundColor: MyColors.Red,
            colorText: Colors.white);
      }

      // final isValid = formKey.currentState!.validate();
      // if (!isValid) {
      //   return;
      // }
      if (selectedImagePath == "") {
        Get.snackbar("Error", "No image was picked",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      // formKey.currentState!.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getInt('userId');

      var uri = Uri.parse(Constants.BASE_URL + Constants.SANITATION_API_URL);

      var request = http.MultipartRequest('POST', uri);
      // request.fields['fullName'] = displayName.value.toString();
      // request.fields['email'] = email.value.toString();
      request.fields["userId"] = userId.toString();
      request.fields['districtId'] = selectedDistrictId.value.toString();
      request.fields['description'] =
          descriptionController.text.toString() == ""
              ? " "
              : descriptionController.text.toString();
      request.fields['reportType'] = selectedRequestType.value.toString();
      request.fields['reportCategoryId'] =
          selectedReportCategory.value.toString();

      request.fields['latitude'] = latitude.value.toString();
      request.fields['longitude'] = longitude.value.toString();
      request.fields['communityLandmark'] = communityController.text;
      request.fields['address'] = address.value;
      request.fields['accuracy'] = accuracy.value.toString();

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'nuisancePicture', File(selectedImagePath.value.toString()).path);
      request.files.add(multipartFile);

      var res = await request.send();
      isLoading.value = true;

      if (res.statusCode == 200) {
        isLoading.value = false;
        selectedImagePath.value = "";
        selectedDistrict.value = "";
        selectedRequestType.value = "";
        descriptionController.text = "";
        communityController.text = "";

        showSubmissionReport();
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "A error occurred. Please try again.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
      Get.snackbar("Connection Error",
          "Connection to server refused. Please try again later...",
          snackPosition: SnackPosition.TOP,
          backgroundColor: MyColors.Red,
          colorText: Colors.white);
    }
  }

  showSubmissionReport() async {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              //child: CircularProgressIndicator(),
            ),
            Text("Report submitted"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                "Report submitted successfully.\nYour MMDA would be notified so that the issue can be resolve.\n\nCheck on the status by clicking on the status tab.\n\n Thank you!"),
            SizedBox(
              height: 10.0,
            ),
            SmallButton(
              onPressed: () {
                Get.back();
              },
              showLoading: false,
              label: "OK",
            )
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  getAddressFromCoords() async {
    placemarks =
        await placemarkFromCoordinates(latitude.value, longitude.value);
    var region = placemarks[0].administrativeArea;
    var locality = placemarks[0].locality;
    var subAdministrativeArea = placemarks[0].subAdministrativeArea;
    var street = "${placemarks[0].street}, ${placemarks[1].street}, ";

    address.value =
        "${street}, ${subAdministrativeArea}, ${locality}, ${region}";

    return address.value;
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

  Future<void> getUserArea() async {
    final String apiUrl = Constants.USER_AREA_API_URL;
    final Map<String, String> params = {
      'lat': '5.6778',
      'lng': '0.1645678',
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        final data = json.decode(response.body);
        print('Response Data: $data');
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception: $error');
    }
  }

  void shareApplication() async {
    Share.text(
        'iCesspool',
        'Check out this app. https://play.google.com/store/apps/details?id=com.icesspool.unified',
        'text/plain');

    // Share.share(
    //     'Check out this app for sanitation reporting. https://play.google.com/store/apps/details?id=com.icesspool.unified');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  returnValue(exp) {
    if (exp == "" || exp == "null" || exp == "") {
      return "null";
    } else {
      return exp;
    }
  }

  // getItemId(value) {
  //   try {
  //     var id;
  //     for (var i = 0; i < districts.length; i++) {
  //       if (districts[i].name.trim() == value.trim()) {
  //         id = districts[i].id.toString();
  //       }
  //     }
  //     return id;
  //   } catch (e) {}
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

  currentStepperType() {
    return stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical;
  }

  tapped(int step) {
    inspect(step);
    currentStep.value = step;
  }

  continued() {
    log(">>> $currentStep");

    if (currentStep < 2) {
      currentStep.value += 1;
    } else {
      //   _submitRequest();
      //  _formSubmitted = true;
    }
    if (currentStep == 3) {
      log("Make Payment");
    }
  }

  cancel() {
    currentStep.value > 0 ? currentStep.value -= 1 : null;
  }
}