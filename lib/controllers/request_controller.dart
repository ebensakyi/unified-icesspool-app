import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icesspool/views/payment_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bindings/payment_binding.dart';
import '../contants.dart';
import '../core/random.dart';
import 'home_controller.dart';

class RequestController extends GetxController {
  final controller = Get.put(HomeController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> documents = <Map<String, dynamic>>[].obs;
  late GoogleMapController googleMapController;

  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);

  final community = "".obs;
  // final Completer<GoogleMapController> _controller = Completer();
  // late Rx<CameraPosition> kGooglePlex;
  // late GoogleMapController googleMapController;

  final isLoading = false.obs;
  final initialSize = 0.8.obs;

  final Map<MarkerId, Marker> markers = {};
  final transactionStatus = 0.obs;
  final userId = 0.obs;
  final transactionId = "".obs;
  final paymentId = "".obs;
  final totalCost = 0.0.obs;
  final spImageUrl = "".obs;
  final spName = "".obs;
  final spCompany = "".obs;
  final spPhoneNumber = "".obs;
  final longitude = 0.0.obs;
  final latitude = 0.0.obs;
  final accuracy = 0.0.obs;
  final isPendingTrxnAvailable = false.obs;
  final isDeleted = false.obs;
  final customerHasTransaction = false.obs;
  Rx<Duration> countdownDuration =
      Duration(hours: 6).obs; // Replace with your desired end hour

  DateTime now = DateTime.now();
  final box = GetStorage();

  final currentStep = 0.obs;
  final questions = [
    'Did the Service Provider and team Undertake the work with the required personal protective gear?',
    'Did the operator make any cash demand other than your receipted payment to iCesspool?',
    'Did the Operator cause any damage to property during the operations?',
    'Did the Operator cover well all opened inspection ports of your tanks/bio-digester and cleaned all spills after the operation?',
    'Did Operator use any abusive language on persons within household?',
  ];

  var ratingCommentController = TextEditingController();
  var rating = 0.0.obs;

  // void nextStep() {
  //   if (currentStep.value < questions.length - 1) {
  //     currentStep.value++;
  //   }
  // }

  // void prevStep() {
  //   if (currentStep.value > 0) {
  //     currentStep.value--;
  //   }
  // }

  @override
  onInit() async {
    super.onInit();

    await getCurrentLocation();

    final box = await GetStorage();
    userId.value = box.read('userId')!;
    // latitude.value = controller.latitude.value;
    // longitude.value = controller.longitude.value;
    // accuracy.value = controller.accuracy.value;

    await checkAvailableRequest();
    // if (box.hasData('countdownDuration')) {
    //   countdownDuration.value =
    //       Duration(seconds: box.read('countdownDuration'));
    // }

    // startCountdown();
    await checkAvailableRequest1();

    await checkUserTransactionStates();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      currentLocation.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  void openPhoneDialer() async {
    final Uri phoneLaunchUri =
        Uri(scheme: 'tel', path: spPhoneNumber.toString());
    if (!await launchUrl(phoneLaunchUri)) {
      throw 'Could not launch $phoneLaunchUri';
    }

    // canLaunchUrl(phoneLaunchUri).then((bool result) {});
  }

  Future<void> addMarker() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(12, 12)),
        "assets/images/toilet-tanker.png");

    final MarkerId markerId = MarkerId('marker1');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(controller.latitude.value, controller.longitude.value),
      infoWindow: InfoWindow(
        title: 'Service',
        snippet: 'This is the first marker.',
      ),
      icon: customIcon,
    );

    markers[markerId] = marker;
    update(); // Update the UI with the new marker
  }

  // Future<void> onMapCreated(GoogleMapController controller) async {
  //   _controller.complete(controller);
  //   await addMarker(); // Add the initial marker when the map is created
  // }

  Future<void> cancelRequest() async {
    var client = http.Client();

    await client.post(
      Uri.parse(Constants.UPDATE_TRANSACTION_STATUS_API_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'transactionId': transactionId.value,
        'status': Constants.CANCELLED_BY_CUSTOMER,
      }),
    );

    transactionStatus.value = 0;
    // box.remove('countdownDuration');
  }

  Future checkUserTransactionStates() async {
    try {
      _firestore
          .collection('transaction')
          .where('customerId', isEqualTo: userId.value)
          .where('deleted', isEqualTo: false)
          .snapshots()
          .listen((snapshot) {
        // documents.assignAll(snapshot.docs);
        documents.assignAll(snapshot.docs.map((doc) => doc.data()).toList());

        var data = documents[0];
        initialSize.value = 0.85;

        transactionStatus.value = data["txStatusCode"]!;
        totalCost.value = data['totalCost'];

        isDeleted.value = data["deleted"]!;

        log(">>>>>>>>>> checkUserTransactionStates called");
        inspect(data);
        log("data ${data}");
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> checkAvailableRequest1() async {
    try {
      // Listen to changes in the Firestore collection
      _firestore
          .collection('transaction')
          .where('customerId', isEqualTo: userId.value)
          .where('deleted', isEqualTo: false)
          .limit(1)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          isPendingTrxnAvailable.value = true;
          customerHasTransaction.value = true;

          // If there is at least one document matching the query
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

          Map<String, dynamic>? data =
              documentSnapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            int? txStatusCode = data['txStatusCode'];
            String _transactionId = data['transactionId'];
            // bool _isDeleted = data['deleted'];

            transactionStatus.value = txStatusCode!;
            transactionId.value = _transactionId;
            // isDeleted.value = _isDeleted;
            //amount.value = data['unitCost'];

            initialSize.value = 0.85;
          } else {
            // Handle the case where data is null
          }
        } else {
          // If no documents match the query
          customerHasTransaction.value = false;
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future checkAvailableRequest() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('transaction')
          .where('customerId', isEqualTo: userId.value) // Add your where clause
          .where('deleted', isEqualTo: false) // Add your where clause

          .limit(1) // Limit the result to 1 document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        isPendingTrxnAvailable.value = true;

// If there is at least one document matching the query
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          int? txStatusCode = data['txStatusCode'];
          String _transactionId = data['transactionId'];
          spImageUrl.value = data['spImageUrl'];
          spCompany.value = data["spCompany"]!;
          spName.value = data["spName"]!;
          spPhoneNumber.value = data["spPhoneNumber"]!;

          totalCost.value = data['totalCost'];

          transactionStatus.value = txStatusCode!;
          transactionId.value = _transactionId;

          initialSize.value = 0.85;
        }
      } else {
        // If no documents match the query
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future initiateTellerPayment(paymentMethod) async {
    paymentId.value = generatePaymentCode(12);

    String url = Constants.INITIATE_PAYMENT_URL +
        "?transactionId=" +
        transactionId.value +
        "&paymentId=" +
        paymentId.value +
        "&payment_method=" +
        paymentMethod.toString() +
        "&amount=" +
        totalCost.value.toString();

    try {
      http.Response response = await http.get(Uri.parse(url));

      isLoading.value = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);

        // int code = data['data']['code'];

        // String token = jsonMap['response']['token'];
        String checkoutUrl = jsonMap['response']['checkout_url'];
        int code = jsonMap['response']['code'];
        isLoading.value = false;

        if (code == 200) {
          Get.to(() => PaymentView(),
              binding: PaymentBinding(),
              arguments: [checkoutUrl, transactionId.value]);

          ///Open checkout page with url
        } else if (code == 900) {
          Get.snackbar("Error message",
              "Payment already initiated. Please wait for it to be processed");
        }
      } else {
        print('initiateTellerPayment> Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('initiateTellerPayment> Error: $error');
      isLoading.value = false;
    }
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      countdownDuration.value -= Duration(seconds: 1);

      if (countdownDuration.value.isNegative) {
        await cancelRequest();
        box.write('countdownDuration', countdownDuration.value.inSeconds);

        timer.cancel();
      }
      // Save the countdown duration to storage
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  void confirmClaim() {}

  void denyClaim() {}

  Future<void> submitRating() async {
    var client = http.Client();

    await client.post(
      Uri.parse(Constants.UPDATE_TRANSACTION_STATUS_API_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'comment': ratingCommentController.text,
        'transactionId': transactionId.value,
        'rating': rating.value.toString(),
      }),
    );
  }
}
