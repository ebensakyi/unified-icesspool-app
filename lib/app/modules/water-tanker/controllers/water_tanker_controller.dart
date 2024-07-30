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
import 'package:icesspool/model/time_range.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger_plus/logger_plus.dart';

class WaterTankerController extends GetxController {
  var logger = new Logger();
  final controller = Get.put(HomeController());
  final requestController = Get.put(RequestController());
  TextEditingController googlePlacesController = TextEditingController();
  final selectedTimeRangeId = 0.obs;
  final selectedStartTime = "".obs;

  var currentIndex = 0.obs;
  var selectedLocation = Prediction().obs;
  late List<Placemark> placemarks = [];
  final isLoading = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  final currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;
  final List<TimeRange> timeRanges = <TimeRange>[].obs;

  final serviceProviders = <ServiceProvider>[].obs;

  var waterTypes = <WaterType>[].obs;
  var selectedWaterTypeIndex = (-1).obs;
  var selectedWaterTypeId = ''.obs;

  var waterVolumes = <WaterVolume>[].obs;
  var selectedWaterVolumeIndex = (-1).obs;
  var selectedWaterVolumeId = ''.obs;
  var selectedWaterVolumeName = ''.obs;
  var selectedWaterVolumeCapacity = ''.obs;
  var serviceProviderName = ''.obs;
  var serviceProviderId = ''.obs;
  var spPicture = ''.obs;
  var spPhoneNumber = ''.obs;
  var selectedWaterTypeName = ''.obs;

  var companyName = ''.obs;

  var showCancelButton = false.obs;

  void selectWaterType(int index) {
    selectedWaterTypeIndex.value = index;
    selectedWaterTypeId.value = waterTypes[index].id.toString();
    selectedWaterTypeName.value = waterTypes[index].name.toString();

    print("Selected ID: ${selectedWaterTypeId.value}");
  }

  void selectWaterVolume(int index) {
    selectedWaterVolumeIndex.value = index;
    selectedWaterVolumeId.value = waterVolumes[index].id.toString();
    selectedWaterVolumeName.value = waterVolumes[index].name.toString();
    selectedWaterVolumeCapacity.value =
        waterVolumes[index].tankCapacity.toString();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getTimeRanges();

    await getWaterTypes();
    await getWaterVolume();
    await getServiceProviders();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getTimeRanges() async {
    final String apiUrl = Constants.TIME_SCHEDULE_API_URL;

    final Uri uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // List data = json.decode(response.body);

        // List<Map<String, dynamic>> typedData =
        //     List<Map<String, dynamic>>.from(data);

        // // Successful response
        // final data = json.decode(response.body);
        // var timeSchedules = jsonDecode(data);

        final List<dynamic> data = jsonDecode(response.body);

        timeRanges.add(TimeRange(
          id: 0,
          time_schedule: "Select time frame",
          start_time: '',
          end_time: '',
        ));
        // timeRanges.assignAll(data.map((item) {
        //   return TimeRange(
        //     id: item['id'],
        //     time_schedule: item['time_schedule'],
        //     start_time: item['start_time'],
        //     end_time: item['end_time'],
        //   );
        // }).toList());
        data.forEach((item) {
          timeRanges.add(TimeRange(
            id: item['id'],
            time_schedule: item['time_schedule'],
            start_time: item['start_time'],
            end_time: item['end_time'],
          ));
        });

        // biodigesterServicesAvailable.value = data;
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception getTimeSchedules: $error');
    }
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
    if (currentStep < 5) {
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

  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now()
          .add(Duration(days: 7)), // Set lastDate to 5 days from current date
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
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

      var uri = Uri.parse(Constants.WATER_TRANSACTION_API_URL);

      var transactionId = generateTransactionCode() +
          controller.serviceAreaId.value.toString() +
          "2";

      // var address = await getAddressFromLatLng(
      //     controller.longitude.value, controller.longitude.value);

      final Map<String, dynamic> data = {
        'transactionId': transactionId,
        'userId': controller.userId.value,
        'customerLng': controller.longitude.value,
        'customerLat': controller.latitude.value,
        'address': selectedLocation.value.description,
        'placeLat': selectedLocation.value.lat,
        'placeLng': selectedLocation.value.lng,
        'placeId': selectedLocation.value.placeId,
        'accuracy': controller.accuracy.value,
        'serviceAreaId': controller.serviceAreaId.value,
        'scheduledDate': selectedDate.value.toIso8601String(),
        'timeFrame': selectedTimeRangeId.value,
        ////////////////////////////////////////////
        'spName': serviceProviderName.value,
        'spCompany': companyName.value,
        'spPhoneNumber': spPhoneNumber.value,
        'spImageUrl': spPicture.value,
        'spId': serviceProviderId.value,
        'requestType': serviceProviderId.value != "" ? "DIRECT" : "BROADCAST"
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
        isLoading.value = false;
        requestController.isPendingTrxnAvailable.value = true;

        requestController.transactionStatus.value = 1;
        requestController.transactionId.value = transactionId;
        var response = jsonDecode(json);

        //var totalCost = double.tryParse(response["totalCost"]);
        // requestController.totalCost.value = totalCost.toString();

        Get.back();
      } else {
        isLoading.value = false;
        print(
            'Failed to send POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      logger.e(e);
      isLoading.value = false;
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
      'device': Constants.DEVICE
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

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

  Future getServiceProviders() async {
    final String apiUrl = Constants.WATER_TANKER_SP_API_URL;

    final Map<String, String> params = {
      'serviceId': '2',
      'serviceAreaId': controller.serviceAreaId.value.toString(),
      'device': Constants.DEVICE
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        logger.i(data[0]);
        // inspect(data);

        serviceProviders.value = List<ServiceProvider>.from(
            data.map((x) => ServiceProvider.fromJson(x)));
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

  getServiceProviderId(value) {
    try {
      var id;
      for (var i = 0; i < serviceProviders.length; i++) {
        // log(primaryDataController.communities[i].name);

        if (serviceProviders[i].spName.trim() == value.trim()) {
          id = serviceProviders[i].id.toString();
        }
      }
      return id;
    } catch (e) {}
  }

  String getServiceProviderCompany(String value) {
    try {
      for (var i = 0; i < serviceProviders.length; i++) {
        // log(primaryDataController.communities[i].name);

        if (serviceProviders[i].spName.trim() == value.trim()) {
          companyName.value = serviceProviders[i].companyName.toString();
        }
      }
      return companyName.value;
    } catch (e) {
      return '';
    }
  }

  getServiceProviderPhoneNumber(String value) {
    try {
      for (var i = 0; i < serviceProviders.length; i++) {
        // log(primaryDataController.communities[i].name);

        if (serviceProviders[i].spName.trim() == value.trim()) {
          spPhoneNumber.value = serviceProviders[i].spPhoneNumber.toString();
        }
      }
      return spPhoneNumber.value;
    } catch (e) {}
  }

  getServiceProviderPicture(String value) {
    try {
      for (var i = 0; i < serviceProviders.length; i++) {
        // log(primaryDataController.communities[i].name);

        if (serviceProviders[i].spName.trim() == value.trim()) {
          spPicture.value = serviceProviders[i].avatar.toString();
        }
      }
      return spPicture.value;
    } catch (e) {}
  }
}

class ServiceProvider {
  int id;
  int serviceId;
  String spName;
  String companyName;
  String avatar;
  String spPhoneNumber;

  ServiceProvider(
      {required this.id,
      required this.serviceId,
      required this.spName,
      required this.companyName,
      required this.spPhoneNumber,
      required this.avatar});

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
        id: json['id'],
        spPhoneNumber: json['spPhoneNumber'],
        serviceId: json['serviceId'],
        spName: json['spName'],
        companyName: json['companyName'],
        avatar: json['avatar']);
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
  String description;
  String tankCapacity;
  WaterVolume(
      {required this.id,
      required this.name,
      required this.tankCapacity,
      required this.description});

  factory WaterVolume.fromJson(Map<String, dynamic> json) {
    return WaterVolume(
      id: json['id'],
      name: json['name'],
      tankCapacity: json['tankCapacity'],
      description: json['description'],
    );
  }
}
