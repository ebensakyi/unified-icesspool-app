import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:icesspool/app/modules/water-tanker/controllers/water_tanker_controller.dart';
import 'package:icesspool/constants.dart';
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/controllers/request_controller.dart';
import 'package:icesspool/core/random.dart';
import 'package:icesspool/model/time_range.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ToiletTruckController extends GetxController {
  final controller = Get.put(HomeController());
  final requestController = Get.put(RequestController());
  var initialLocation = LatLng(0.0, 0.0);
  TextEditingController googlePlacesController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  final isLoading = false.obs;
  final isVisble = true.obs;

  final transactionId = "".obs;

  final selectedRequestType = "".obs;
  final selectedImagePath = "".obs;
  final selectedImageSize = "".obs;
  final userId = 0.obs;

  final displayName = "".obs;
  final email = "".obs;
  final photoURL = "".obs;
  final phoneNumber = "".obs;
  final address = "".obs;

  final longitude = 0.0.obs;
  final latitude = 0.0.obs;
  final accuracy = 0.0.obs;

  var truckTypes = <TruckType>[].obs;

  final isSelectedList = [].obs;

  final serviceProviders = <ServiceProvider>[].obs;
  // final biodigesterServicesAvailable = [].obs;
  // final RxList<BiodigesterPricing> biodigesterPricings =
  //     <BiodigesterPricing>[].obs;
  final List<TimeRange> timeRanges = <TimeRange>[].obs;
  final selectedTimeRangeId = 0.obs;
  // final selectedTimeRange = "".obs;
  final selectedStartTime = "".obs;

  var currentIndex = 0.obs;
  var currentTitle = "Report".obs;

  late List<Placemark> placemarks = [];

  final currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  var selectedLocation = Prediction().obs;

  var nameController = TextEditingController();

  var phoneNumberController = TextEditingController();
  BuildContext? context = Get.context;

  var selectedPrice = {}.obs;
  var serviceProviderName = ''.obs;
  var serviceProviderId = ''.obs;
  var spPicture = ''.obs;
  var spPhoneNumber = ''.obs;

  var companyName = ''.obs;

  var showCancelButton = false.obs;
  var truckVolumes = <TruckType>[].obs;

  var selectedTruckTypeIndex = (-1).obs;
  var selectedTruckTypeId = ''.obs;
  var selectedTruckTypeName = ''.obs;
  var selectedTruckVolume = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getTruckTypes();
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

  void selectTruckType(int index) {
    selectedTruckTypeIndex.value = index;
    selectedTruckTypeId.value = truckTypes[index].id.toString();
    selectedTruckTypeName.value = truckTypes[index].name.toString();
    selectedTruckVolume.value = truckTypes[index].tankVolume.toString();
  }

  Future getServiceProviders() async {
    final String apiUrl = Constants.SP_API_URL;

    final Map<String, String> params = {
      'serviceId': '1',
      'serviceAreaId': controller.serviceAreaId.value.toString(),
      'device': Constants.DEVICE
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
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

  currentStepperType() {
    return stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical;
  }

  tapped(int step) {
    currentStep.value = step;
  }

  continued() {
    log(currentStep.toString());
    if (currentStep < 6) {
      currentStep.value += 1;
    } else {}
  }

  cancel() {
    currentStep.value > 0 ? currentStep.value -= 1 : null;
  }

  TimeOfDay convertToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  int calculateHoursDifference() {
    var givenDateString = selectedDate.value.toString().split(" ")[0] +
        " " +
        formatTime(convertToTimeOfDay(selectedStartTime.value));

    // Splitting the given date string into date and time parts
    List<String> parts = givenDateString.split(" ");
    String datePart = parts[0];
    String timePart = parts[1];
    String period = parts[2];

    // Extracting year, month, and day
    List<String> dateParts = datePart.split("-");
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    // Extracting hour and minute
    List<String> timeParts = timePart.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Converting hour to 24-hour format if necessary
    if (period == 'PM' && hour < 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    // Create the DateTime object
    DateTime givenDateTime = DateTime(year, month, day, hour, minute);

    // Current datetime
    DateTime currentDateTime = DateTime.now();

    // Calculate the difference in hours
    int hoursDifference = currentDateTime.difference(givenDateTime).inHours;

    return hoursDifference.abs();
  }

  String formatTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  Future sendRequest(BuildContext context) async {
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

      var uri = Uri.parse(Constants.TOILET_TRUCK_TRANSACTION_API_URL);

      var transactionId = controller.serviceAreaId.value.toString() +
          "1" +
          generateTransactionCode();

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
        'totalCost': "calculateTotalCost(selectedServices)",
        'serviceAreaId': controller.serviceAreaId.value,
        'scheduledDate': selectedDate.value.toIso8601String(),
        'timeFrame': selectedTimeRangeId.value
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

  Future<void> getTruckTypes() async {
    final String apiUrl = Constants.TOILET_TRUCK_AVAILABLE_API_URL;

    final Map<String, String> params = {
      'serviceId': '2',
      'serviceAreaId': controller.serviceAreaId.value.toString(),
      'device': Constants.DEVICE,
      'userLatitude': controller.latitude.value.toString(),
      'userLongitude': controller.longitude.value.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);
    // try {
    final response = await http.get(uri);
    inspect(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      truckTypes.value =
          List<TruckType>.from(data.map((x) => TruckType.fromJson(x)));

      inspect(response);
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
    // } catch (error) {
    //   // Handle exception
    //   print('Exception>>: $error');
    // }
  }

  void updateSelectedIndex(int index) {
    isSelectedList.value = List.generate(truckTypes.length, (i) => i == index);
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

class TruckType {
  int id;
  String name;
  String price;
  String tankVolume;
  TruckType(
      {required this.id,
      required this.name,
      required this.tankVolume,
      required this.price});

  factory TruckType.fromJson(Map<String, dynamic> json) {
    return TruckType(
      id: json['id'],
      name: json['name'],
      tankVolume: json['tankVolume'],
      price: json['price'],
    );
  }
}
