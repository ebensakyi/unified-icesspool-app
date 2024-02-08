import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/controllers/request_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:icesspool/core/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

import '../contants.dart';
import '../core/random.dart';
import '../model/biodigester_pricing.dart';
import '../themes/colors.dart';
import '../widgets/small-button.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';

class BiodigesterController extends GetxController {
  final controller = Get.put(HomeController());
  final requestController = Get.put(RequestController());

  final formKey = new GlobalKey<FormState>();

  final isLoading = false.obs;
  final isVisble = true.obs;

  final transactionId = "".obs;

  final selectedRequestType = "".obs;
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

  var currentIndex = 0.obs;
  var currentTitle = "Report".obs;
  List<String> titlesList = ["Home", "Report Status", "About"];

  late List<Placemark> placemarks = [];

  final currentStep = 0.obs;
  StepperType stepperType = StepperType.vertical;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1, 1, 1).add(Duration(days: 14)),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  @override
  void onInit() async {
    // await getUserArea();
    await getAvailableBiodigesterServices();
    await getBiodigesterPricing();

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

      //await getUserArea();

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

  Future sendRequest() async {
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
          "3" +
          generateTransactionCode();
      String formattedTime =
          '${selectedTime.value.hour}:${selectedTime.value.minute.toString().padLeft(2, '0')}';

      final Map<String, dynamic> data = {
        'transactionId': transactionId,
        'requestDetails': selectedServices,
        'userId': controller.userId.value,
        'customerLng': controller.longitude.value,
        'customerLat': controller.latitude.value,
        'accuracy': controller.accuracy.value,
        'totalCost': calculateTotalCost(selectedServices),
        'serviceAreaId': controller.serviceAreaId.value,
        'scheduledDate': selectedDate.value.toIso8601String(),
        'scheduledTime': formattedTime
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

        var cost = response["cost"];
        requestController.amount.value = cost;

        Get.back();
      } else {
        isLoading.value = false;
        print(
            'Failed to send POST request. Status code: ${response.statusCode}');
      }

      // var res = await request.send();
      // isLoading.value = true;

      //   if (res.statusCode == 200) {
      //     isLoading.value = false;
      //     selectedImagePath.value = "";
      //     selectedDistrict.value = "";
      //     selectedRequestType.value = "";
      //     descriptionController.text = "";
      //     communityController.text = "";

      //     showSubmissionReport();
      //   } else {
      //     isLoading.value = false;
      //     Get.snackbar("Error", "A error occurred. Please try again.",
      //         snackPosition: SnackPosition.TOP,
      //         backgroundColor: Colors.red,
      //         duration: Duration(seconds: 5),
      //         colorText: Colors.white);
      //   }
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

        log("getAvailableBiodigesterServices $data");
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception getAvailableBiodigesterPricing: $error');
    }
  }

  Future getBiodigesterPricing() async {
    final String apiUrl = Constants.BIODIGESTER_PRICING_API_URL;
    final Map<String, String> params = {
      'platform': '2',
      'serviceAreaId': controller.serviceAreaId.value.toString(),
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        //final data = json.decode(response.body);
        List data = json.decode(response.body);

        log("getBiodigesterPricing===>$data");
        List<Map<String, dynamic>> typedData =
            List<Map<String, dynamic>>.from(data);

        // print(parseData(typedData));

        // var x = data
        //     .map((item) => BiodigesterPricing(
        //           id: item['id'],
        //           name: item['name'],
        //           cost: item['cost'].toDouble(),
        //         ))
        //     .toList();

        // log(x);

        biodigesterPricings.value = parseData(typedData);

        // return data;
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

    log(index.toString());
    if (index != -1) {
      log('Index of object with id $targetId: $index');
    } else {
      log('Object with id $targetId not found in the list.');
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
            ))
        .toList();

    return formattedData;
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

  currentStepperType() {
    return stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical;
  }

  tapped(int step) {
    currentStep.value = step;
  }

  continued() {
    inspect(currentStep);
    if (currentStep < 3) {
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

  void addOrRemoveItem(myArray, Map<String, dynamic> newItem) {
    int indexOfExistingItem = myArray.indexWhere(
      (item) => item["id"] == newItem["id"],
    );

    if (indexOfExistingItem != -1) {
      // Remove the existing item
      myArray.removeAt(indexOfExistingItem);
    } else {
      // Add the item
      myArray.add(newItem);
      print("Added: $newItem");
    }
  }

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
