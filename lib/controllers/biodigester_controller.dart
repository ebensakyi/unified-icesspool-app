import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/controllers/request_controller.dart';
import 'package:icesspool/model/time_range.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:icesspool/core/location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:logger_plus/logger_plus.dart';

import '../constants.dart';
import '../core/random.dart';
import '../model/biodigester_pricing.dart';
import '../themes/colors.dart';
import '../widgets/small-button.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';

class BiodigesterController extends GetxController {
  final controller = Get.put(HomeController());
  final requestController = Get.put(RequestController());
  var initialLocation = LatLng(0.0, 0.0);
  var logger = new Logger();
  TextEditingController googlePlacesController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  final isLoading = false.obs;
  final isVisible = true.obs;

  final transactionId = "".obs;

  final selectedBiodigesterRequestType = "".obs;
  final selectedImagePath = "".obs;
  final selectedImageSize = "".obs;
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

  final childrenNumber = TextEditingController();
  final adultsNumber = TextEditingController();
  final totalUsers = 0.obs;

  final digesterEmptyingAvailable = false.obs;
  final soakawayServicingAvailable = false.obs;
  final drainfieldServicingAvailable = false.obs;
  final biodigesterAvailable = false.obs;
  final biodigesterWithSeatAvailable = false.obs;
  final standaloneAvailable = false.obs;

  final isSelected1 = false.obs;
  final isSelected2 = false.obs;
  final isSelected3 = false.obs;
  final isSelected4 = false.obs;
  final isSelected5 = false.obs;
  final isSelected6 = false.obs;

  final selectedServices = <Map<String, dynamic>>[].obs;

  final biodigesterServicesAvailable = [].obs;
  final RxList<BiodigesterPricing> biodigesterPricings =
      <BiodigesterPricing>[].obs;
  final List<TimeRange> timeRanges = <TimeRange>[].obs;
  final selectedTimeRangeId = 0.obs;
  // final selectedTimeRange = "".obs;
  final selectedStartTime = "".obs;

  var currentIndex = 0.obs;

  late List<Placemark> placemarks = [];

  final currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  var selectedLocation = Prediction().obs;

  // Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  bool isStandard() {
    return totalUsers.value <= 10;
  }

  bool isLarge() {
    return totalUsers.value > 10 && totalUsers.value <= 15;
  }

  bool isStandardX2() {
    return totalUsers.value > 15 && totalUsers.value <= 20;
  }

  bool isStandardX3() {
    return totalUsers.value > 20 && totalUsers.value <= 30;
  }

  bool isStandardX4() {
    return totalUsers.value > 30 && totalUsers.value <= 40;
  }

  Future<void> selectDate(context) async {
    var lastDate = selectedBiodigesterRequestType == "1" ? 5 : 7;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
          Duration(days: lastDate)), // Set lastDate to 5 days from current date
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  @override
  void onInit() async {
    final position = await LocationService.determinePosition();

    // await getUserArea();
    await getAvailableBiodigesterServices();
    await getBiodigesterPricing();
    await getTimeRanges();

    final box = await GetStorage();

    latitude.value = position!.latitude;
    longitude.value = position.longitude;
    accuracy.value = position.accuracy;

    userId.value = box.read('userId');

    await getAddressFromCoords();

    // placemarks =
    //     await placemarkFromCoordinates(latitude.value, longitude.value);

    displayName.value = box.read('displayName') ?? "";
    email.value = box.read('email') ?? "";
    photoURL.value = box.read('photoURL') ?? "";
    phoneNumber.value = box.read('phoneNumber') ?? "";

    super.onInit();
  }

  Future<void> changeTabIndex(int index) async {
    try {
      currentIndex.value = index;
      // currentTitle.value = titlesList[index];

      //await getUserArea();

      if (index == 1) {
        isLoading.value = true;
        // reports.value = await DataServices.getReports(userId);
        isLoading.value = false;
      }

      update();
    } catch (e) {
      isLoading.value = false;
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
    final box = await GetStorage();

    await box.remove('displayName');
    await box.remove('email');
    await box.remove('phoneNumber');
    await box.remove('photoURL');
  }

  // void getDistricts() async {
  //   try {
  //     districts.value = await DataServices.getDistricts();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

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

      var transactionId = generateTransactionCode() +
          controller.serviceAreaId.value.toString() +
          "3";

      // var address = await getAddressFromLatLng(
      //     controller.longitude.value, controller.longitude.value);

      final Map<String, dynamic> data = {
        'transactionId': transactionId,
        'requestDetails': selectedServices,
        'userId': controller.userId.value,
        'customerLng': controller.longitude.value,
        'customerLat': controller.latitude.value,
        'address': selectedLocation.value.description,
        'placeLat': selectedLocation.value.lat,
        'placeLng': selectedLocation.value.lng,
        'placeId': selectedLocation.value.placeId,
        'accuracy': controller.accuracy.value,
        'totalCost': calculateTotalCost(selectedServices),
        'serviceAreaId': controller.serviceAreaId.value,
        'scheduledDate': selectedDate.value.toIso8601String(),
        'timeFrame': selectedTimeRangeId.value
      };
      logger.d(data);
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
        logger.d(response.body);
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

  Future<void> getAvailableBiodigesterServices() async {
    final String apiUrl = Constants.BIODIGESTER_SERVICES_AVAILABLE_API_URL;
    final Map<String, String> params = {
      'serviceAreaId': controller.serviceAreaId.value.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        final data = json.decode(response.body);

        biodigesterServicesAvailable.value = data;
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception getAvailableBiodigesterPricing: $error');
    }
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

  Future getBiodigesterPricing() async {
    final String apiUrl = Constants.BIODIGESTER_PRICING_API_URL;
    final Map<String, String> params = {
      'device': Constants.DEVICE,
      'serviceAreaId': controller.serviceAreaId.value.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        List<Map<String, dynamic>> typedData =
            List<Map<String, dynamic>>.from(data);

        biodigesterPricings.value = parseData(typedData);
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception>>: $error');
    }
  }

  getBiodigesterServiceIndex(int targetId) {
    int index = biodigesterPricings
        .indexWhere((service) => service.biodigesterServiceId == targetId);

    if (index != -1) {
      // log('Index of object with id $targetId: $index');
    } else {
      // log('Object with id $targetId not found in the list.');
    }
    return index;
  }

  List<BiodigesterPricing> parseData(List<Map<String, dynamic>> data) {
    var formattedData = data
        .map((item) => BiodigesterPricing(
              id: item['id'],
              biodigesterServiceId: item['biodigesterServiceId'],
              name: item['name'],
              shortDesc: item['shortDesc'],
              fullDesc: item['fullDesc'],
              type: item['type'],
              cost: item['cost'],
              standardCost: item['standardCost'],
              largeCost: item['largeCost'],
            ))
        .toList();

    return formattedData;
  }

  // List<TimeRange> parseTimeSchedule(List<Map<String, dynamic>> data) {
  //   var formattedData = data
  //       .map((item) => TimeRange(
  //             id: item['id'],
  //             time_schedule: item['time_schedule'],
  //             start_time: item['start_time'],
  //             end_time: item['end_time'],
  //           ))
  //       .toList();

  //   return formattedData;
  // }

  double calculateUnitCost() {
    if (isStandard()) {
      return double.parse(biodigesterPricings[1].standardCost);
    } else if (isLarge()) {
      return double.parse(biodigesterPricings[1].largeCost);
    } else if (isStandardX2()) {
      return double.parse(biodigesterPricings[1].standardCost) * 2;
    } else if (isStandardX3()) {
      return double.parse(biodigesterPricings[1].standardCost) * 3;
    } else if (isStandardX4()) {
      return double.parse(biodigesterPricings[1].standardCost) * 4;
    } else {
      return 0;
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

  // Future<String?> getAddressFromLatLng(double lat, double lng) async {
  //   lat = 5.549576;
  //   lng = -0.254363;
  //   final apiKey = Constants.GOOGLE_MAPS_API_KEY;
  //   final apiUrl =
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';

  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       if (data['status'] == 'OK') {
  //         return data['results'][0]['formatted_address'];
  //       } else {
  //         print('Error: ${data['status']}');
  //         return null;
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
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
    if (exp == "" || exp == "null" || exp == "") {
      return "null";
    } else {
      return exp;
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

  void addService(Map<String, dynamic> newItem) {
    // myArray.value = [];
    int indexOfExistingItem = selectedServices.indexWhere(
      (item) => item["id"] == newItem["id"],
    );

    if (indexOfExistingItem != -1) {
      // Remove the existing item
      selectedServices.removeAt(indexOfExistingItem);
    } else {
      // Add the item
      selectedServices.add(newItem);
      print("Added: $newItem");
    }
  }

  // void addOrRemoveItem(myArray, Map<String, dynamic> newItem) {
  //   int indexOfExistingItem = myArray.indexWhere(
  //     (item) => item["id"] == newItem["id"],
  //   );

  //   if (indexOfExistingItem != -1) {
  //     // Remove the existing item
  //     myArray.removeAt(indexOfExistingItem);
  //   } else {
  //     // Add the item
  //     myArray.add(newItem);
  //     print("Added: $newItem");
  //   }
  // }

  calculateTotalCost(myArray) {
    double totalCost = selectedServices.fold(0, (sum, item) {
      if (item["unitCost"] is double) {
        return sum + (item["unitCost"] as double? ?? 0);
      } else if (item["unitCost"] is String) {
        return sum + double.parse(item["unitCost"] as String);
      } else {
        return sum;
      }
    });

    return totalCost.toStringAsFixed(2);
  }

  void calcUsers() {
    totalUsers.value =
        (int.parse(adultsNumber.text) + int.parse(childrenNumber.text));
  }

  // void saveTransactionFirestore() {
  //   // Add data to Firestore collection
  //   _firestore.collection('transaction').add({
  //     'transactionId': transactionId.value,
  //     'userId': controller.userId.value,
  //     'lng': controller.longitude.value,
  //     'lat': controller.longitude.value,
  //     'accuracy': controller.accuracy.value,
  //     'totalCost': calculateTotalCost(selectedServices),
  //     'serviceAreaId': controller.serviceAreaId.value
  //     // Add more fields as needed
  //   }).then((value) {
  //     print('Data added successfully!');
  //   }).catchError((error) {
  //     print('Failed to add data: $error');
  //   });
  // }
}
