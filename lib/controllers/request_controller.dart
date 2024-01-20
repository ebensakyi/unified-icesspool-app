import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icesspool/views/payment_view.dart';

import '../bindings/payment_binding.dart';
import '../contants.dart';
import '../core/random.dart';
import 'home_controller.dart';

class RequestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final community = "".obs;
  final Completer<GoogleMapController> _controller = Completer();
  final controller = Get.put(HomeController());
  final isLoading = false.obs;
  final initialSize = 0.5.obs;

  final Map<MarkerId, Marker> markers = {};
  final pendingTransaction = false.obs;
  final transactionStatus = 0.obs;
  final transactionId = "".obs;
  final paymentId = "".obs;
  final amount = "".obs;
  Rx<Duration> countdownDuration =
      Duration(hours: 6).obs; // Replace with your desired end hour

  DateTime now = DateTime.now();
  final box = GetStorage();

  @override
  onInit() async {
    log("RequestController created");
    await checkAvailableRequest();

    if (box.hasData('countdownDuration')) {
      countdownDuration.value =
          Duration(seconds: box.read('countdownDuration'));
    }

    startCountdown();
    // community.value = Get.arguments['community'];
    amount.value = "0.10";

    super.onInit();
  }

  Future<void> addMarker() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0, 0)),
        "assets/images/toilet-tanker.png");

    final MarkerId markerId = MarkerId('marker1');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(5.648931, -0.185246),
      infoWindow: InfoWindow(
        title: 'Service',
        snippet: 'This is the first marker.',
      ),
      icon: customIcon,
    );

    markers[markerId] = marker;
    update(); // Update the UI with the new marker
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    await addMarker(); // Add the initial marker when the map is created
  }

  //   static CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(controller.latitude.value, controller.longitude.value),
  //   zoom: 12,
  //   tilt: 59.440717697143555,
  //   bearing: 12.8334901395799,
  // );

  void cancelRequest(transactionId) {
    final data = {"deleted": true};

    _firestore
        .collection("transaction")
        .doc(transactionId)
        .set(data, SetOptions(merge: true));
  }

  Future checkAvailableRequest() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(
              'transaction') // Replace 'your_collection' with your actual collection name
          .where('customerId',
              isEqualTo: controller.userId.value) // Add your where clause
          .where('deleted', isEqualTo: false) // Add your where clause

          .limit(1) // Limit the result to 1 document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        pendingTransaction.value = true;

// If there is at least one document matching the query
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Explicitly cast data to Map<String, dynamic>
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          // Access the 'txStatus' field
          int? txStatusCode = data['txStatusCode'];
          String _transactionId = data['transactionId'];

          transactionStatus.value = txStatusCode!;
          transactionId.value = _transactionId;
          initialSize.value = 0.75;

          log('txStatusCode $txStatusCode');

          return txStatusCode;
        } else {
          // Handle the case where data is null
          return null;
        }
      } else {
        // If no documents match the query
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future initiateTellerPayment() async {
    paymentId.value = generatePaymentCode(12);

    log("paymentId.value ${paymentId.value}");

    String url = Constants.INITIATE_PAYMENT_URL +
        "?transactionId=" +
        transactionId.value +
        "&paymentId=" +
        paymentId.value +
        "&amount=" +
        amount.value.trim();
    print('initiateTellerPayment: $url');

    try {
      http.Response response = await http.get(Uri.parse(url));

      isLoading.value = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);

        // int code = data['data']['code'];

        String token = jsonMap['response']['token'];
        String checkoutUrl = jsonMap['response']['checkout_url'];
        int code = jsonMap['response']['code'];

        if (code == 200) {
          Get.off(() => PaymentView(),
              binding: PaymentBinding(), arguments: [checkoutUrl]);

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
    }
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      countdownDuration.value -= Duration(seconds: 1);

      if (countdownDuration.value.isNegative) {
        timer.cancel();
      }
      // Save the countdown duration to storage
      box.write('countdownDuration', countdownDuration.value.inSeconds);
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
