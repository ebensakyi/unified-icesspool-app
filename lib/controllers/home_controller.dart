import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/core/location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:icesspool/services/data_services.dart';
import 'package:logger_plus/logger_plus.dart';
import 'package:package_info/package_info.dart';

import '../constants.dart';
import '../widgets/small-button.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';

class HomeController extends GetxController {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var logger = new Logger();
  var client = http.Client();

  final formKey = new GlobalKey<FormState>();
  final AppName = "".obs;
  final AppVersion = "".obs;
  final isLoading = false.obs;

  var emptyingServiceAvailable = false.obs;
  var waterServiceAvailable = false.obs;
  var biodigesterServiceAvailable = false.obs;

  final selectedImagePath = "".obs;
  final selectedImageSize = "".obs;
  final count = 0.obs;
  final userId = 0.obs;
  final serviceAreaId = 0.obs;

  final firstName = "".obs;
  final lastName = "".obs;

  final email = "".obs;
  final photoURL = "".obs;
  final phoneNumber = "".obs;
  final address = "".obs;
  // final community = "".obs;
  final descriptionController = TextEditingController();

  final longitude = 0.0.obs;
  final latitude = 0.0.obs;
  final accuracy = 0.0.obs;
  final inactiveColor = Colors.grey.obs;
  final currentIndex = 0.obs;

  late List<Placemark> placemarks = [];

  final currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;
  var db = FirebaseFirestore.instance;

  @override
  void onInit() async {
    final box = await GetStorage();

    changeTabIndex(0);

    await getCurrentLocation();
    await getUserServiceArea();

    final position = await LocationService.determinePosition();

    latitude.value = position!.latitude;
    longitude.value = position.longitude;
    accuracy.value = position.accuracy;

    userId.value = box.read('userId');
    phoneNumber.value = box.read('phoneNumber')!;
    firstName.value = box.read('firstName')!;
    lastName.value = box.read('lastName')!;

    email.value = box.read('email') ?? "";
    photoURL.value = box.read('photoURL') ?? "";

    // await getAddressFromCoords();

    await initPackageInfo();

    // placemarks =
    //     await placemarkFromCoordinates(latitude.value, longitude.value);

    // displayName.value = prefs.getString('displayName') ?? "";

    // await getAvailableServices();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) async {
      updateUserFCM(value);

      //box.write("fcmId", value.toString());
    });
    super.onInit();
  }

  Future<void> changeTabIndex(int index) async {
    try {
      currentIndex.value = index;
      // currentTitle.value = titlesList[index];

      await getUserServiceArea();

      if (index == 0) {
        // isLoading.value = true;
        // // reports.value = await DataServices.getReports(userId);
        // isLoading.value = false;
      } else if (index == 1) {
        await DataServices.getTransactionHistory(userId);
      }

      update();
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  void clearSharedPref() async {
    final box = await GetStorage();

    await box.remove('displayName');
    await box.remove('email');
    await box.remove('phoneNumber');

    await box.remove('photoURL');
  }

  getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  updateUserFCM(fcmId) async {
    try {
      logger.d(fcmId);
      var uri = Uri.parse(Constants.FCM_API_URL);

      var response = await client.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'fcmId': fcmId,
          'userId': userId.value.toString(),
        }),
      );

      logger.d(response);
    } catch (e) {
      inspect(e);
      logger.i(e);
    }
  }
  // showSubmissionReport() async {
  //   Get.dialog(
  //     AlertDialog(
  //       title: Row(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             //child: CircularProgressIndicator(),
  //           ),
  //           Text("Report submitted"),
  //         ],
  //       ),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //               "Report submitted successfully.\nYour MMDA would be notified so that the issue can be resolve.\n\nCheck on the status by clicking on the status tab.\n\n Thank you!"),
  //           SizedBox(
  //             height: 10.0,
  //           ),
  //           SmallButton(
  //             onPressed: () {
  //               Get.back();
  //             },
  //             showLoading: false,
  //             label: "OK",
  //           )
  //         ],
  //       ),
  //     ),
  //     barrierDismissible: false,
  //   );
  // }

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

  Future<void> getUserServiceArea() async {
    final String apiUrl = Constants.USER_SERVICE_AREA_API_URL;

    final Map<String, String> params = {
      'lat': latitude.value.toString(),
      'lng': longitude.value.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        final data = json.decode(response.body);
        serviceAreaId.value = data;

        await getAvailableServices(data);
      } else {
        // Handle error
        log('getUserArea Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      log('getUserArea Exception: $error');
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

  // returnValue(exp) {
  //   if (exp == "" || exp == "null" || exp == "") {
  //     return "null";
  //   } else {
  //     return exp;
  //   }
  // }

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

  Future<void> initPackageInfo() async {
    final _packageInfo = await PackageInfo.fromPlatform();

    AppName.value = _packageInfo.appName;
    AppVersion.value = _packageInfo.version;
  }

  // currentStepperType() {
  //   return stepperType == StepperType.vertical
  //       ? stepperType = StepperType.horizontal
  //       : stepperType = StepperType.vertical;
  // }

  // tapped(int step) {
  //   currentStep.value = step;
  // }

  // continued() {
  //   log(">>> $currentStep");

  //   if (currentStep < 2) {
  //     currentStep.value += 1;
  //   } else {
  //     //   _submitRequest();
  //     //  _formSubmitted = true;
  //   }
  //   if (currentStep == 3) {
  //     log("Make Payment");
  //   }
  // }

  // cancel() {
  //   currentStep.value > 0 ? currentStep.value -= 1 : null;
  // }

  Future<void> getAvailableServices(serviceAreaId) async {
    final String apiUrl = Constants.SERVICES_AVAILABLE_API_URL;
    final Map<String, String> params = {
      'serviceAreaId': '1' // serviceAreaId.toString()
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        List<dynamic> data = json.decode(response.body);
        emptyingServiceAvailable.value = data.contains(1);
        waterServiceAvailable.value = data.contains(2);
        biodigesterServiceAvailable.value = data.contains(3);
      } else {
        // Handle error
        log('getAvailableServices Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      log('getAvailableServices Exception: $error');
    }
  }

  // Future<void> logout() async {
  //   final box = await GetStorage();
  //   box.write("isLogin", false);
  //   Get.to(() => LoginView());
  // }
}
