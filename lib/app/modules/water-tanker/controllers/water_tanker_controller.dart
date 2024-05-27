import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/constants.dart';
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/controllers/request_controller.dart';
import 'package:icesspool/core/random.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WaterTankerController extends GetxController {
  final controller = Get.put(HomeController());
  final requestController = Get.put(RequestController());
  TextEditingController googlePlacesController = TextEditingController();

  var currentIndex = 0.obs;
  var selectedLocation = Prediction().obs;
  late List<Placemark> placemarks = [];
  final isLoading = false.obs;

  final currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;

  var waterTypes = <WaterType>[].obs;
  var selectedWaterTypeIndex = (-1).obs;
  var selectedWaterTypeId = ''.obs;

  var waterVolumes = <WaterVolume>[].obs;
  var selectedWaterVolumeIndex = (-1).obs;
  var selectedWaterVolumeId = ''.obs;

  void selectWaterType(int index) {
    selectedWaterTypeIndex.value = index;
    selectedWaterTypeId.value = waterTypes[index].id.toString();
    print("Selected ID: ${selectedWaterTypeId.value}");
  }

  void selectWaterVolume(int index) {
    selectedWaterVolumeIndex.value = index;
    selectedWaterVolumeId.value = waterVolumes[index].id.toString();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await getWaterTypes();
    await getWaterVolume();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  currentStepperType() {
    return stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical;
  }

  tapped(int step) {
    currentStep.value = step;
  }

  continued() {
    if (currentStep < 4) {
      currentStep.value += 1;
    } else {
      //   _submitRequest();
      //  _formSubmitted = true;
    }
    if (currentStep == 3) {}
  }

  cancel() {
    currentStep.value > 0 ? currentStep.value -= 1 : null;
  }

  Future sendRequest(context) async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) {
        isLoading.value = false;
        return Get.snackbar(
            "Internet Error", "Poor internet access. Please try again later...",
            snackPosition: SnackPosition.TOP,
            backgroundColor: MyColors.Red,
            colorText: Colors.white);
      }
      isLoading.value = true;

      var uri = Uri.parse(Constants.BIODIGESTER_TRANSACTION_API_URL);

      var transactionId = controller.serviceAreaId.value.toString() +
          "2" +
          generateTransactionCode();

      // var address = await getAddressFromLatLng(
      //     controller.longitude.value, controller.longitude.value);

      final Map<String, dynamic> data = {
        'transactionId': transactionId,
        // 'requestDetails': selectedServices,
        // 'userId': controller.userId.value,
        // 'customerLng': controller.longitude.value,
        // 'customerLat': controller.latitude.value,
        // 'address': selectedLocation.value.description,
        // 'placeLat': selectedLocation.value.lat,
        // 'placeLng': selectedLocation.value.lng,
        // 'placeId': selectedLocation.value.placeId,
        // 'accuracy': controller.accuracy.value,
        // 'totalCost': calculateTotalCost(selectedServices),
        // 'serviceAreaId': controller.serviceAreaId.value,
        // 'scheduledDate': selectedDate.value.toIso8601String(),
        // 'timeFrame': selectedTimeRangeId.value
      };

      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      var json = await response.body;

      if (response.statusCode == 200) {
        print('Post request successful! Response: ${json}');
        isLoading.value = false;
        requestController.isPendingTrxnAvailable.value = true;

        requestController.transactionStatus.value = 1;
        requestController.transactionId.value = transactionId;
        var response = jsonDecode(json);

        var totalCost = double.tryParse(response["totalCost"]);
        requestController.totalCost.value = totalCost.toString();

        Get.back();
      } else {
        isLoading.value = false;
        print(
            'Failed to send POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
      return showToast(
        backgroundColor: Colors.red.shade800,
        alignment: Alignment.center,
        'Connection to server refused. Please try again later.',
        context: context,
        animation: StyledToastAnimation.scale,
        duration: Duration(seconds: 4),
        position: StyledToastPosition.top,
      );
    }
  }

  Future getWaterVolume() async {
    final String apiUrl = Constants.WATER_TANKER_AVAILABLE_API_URL;
    final Map<String, String> params = {
      'serviceId': '2',
      'serviceAreaId': controller.serviceAreaId.value.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        inspect(data);
        waterVolumes.value =
            List<WaterVolume>.from(data.map((x) => WaterVolume.fromJson(x)));
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception>>: $error');
    }
  }

  Future getWaterTypes() async {
    final String apiUrl = Constants.WATER_TYPES_API_URL;
    final Map<String, String> params = {
      'platform': '2',
      'serviceAreaId': controller.serviceAreaId.value.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        waterTypes.value =
            List<WaterType>.from(data.map((x) => WaterType.fromJson(x)));
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception>>: $error');
    }
  }
}

class WaterType {
  int id;
  String name;

  WaterType({required this.id, required this.name});

  factory WaterType.fromJson(Map<String, dynamic> json) {
    return WaterType(
      id: json['id'],
      name: json['name'],
    );
  }
}

class WaterVolume {
  int id;
  String name;
  String tankCapacity;
  WaterVolume(
      {required this.id, required this.name, required this.tankCapacity});

  factory WaterVolume.fromJson(Map<String, dynamic> json) {
    return WaterVolume(
      id: json['id'],
      name: json['name'],
      tankCapacity: json['tankCapacity'],
    );
  }
}
