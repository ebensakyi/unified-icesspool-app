import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icesspool/views/payment_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bindings/payment_binding.dart';
import '../contants.dart';
import '../core/random.dart';

class RequestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> documents = <Map<String, dynamic>>[].obs;

  final community = "".obs;
  final Completer<GoogleMapController> _controller = Completer();
  // final controller = Get.put(HomeController());
  final isLoading = false.obs;
  final initialSize = 0.56.obs;

  final Map<MarkerId, Marker> markers = {};
  final transactionStatus = 0.obs;
  final userId = 0.obs;
  final transactionId = "".obs;
  final paymentId = "".obs;
  final amount = "".obs;
  final isPendingTrxnAvailable = false.obs;
  final isDeleted = false.obs;
  Rx<Duration> countdownDuration =
      Duration(hours: 6).obs; // Replace with your desired end hour

  DateTime now = DateTime.now();
  final box = GetStorage();

  @override
  onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getInt('userId')!;
    await checkAvailableRequest();
    if (box.hasData('countdownDuration')) {
      countdownDuration.value =
          Duration(seconds: box.read('countdownDuration'));
    }

    startCountdown();
    // community.value = Get.arguments['community'];
    //amount.value = "0.10";

    inspect(transactionId.string);

    await checkUserTransactionStates();

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
    log("Map is created");

    _controller.complete(controller);
    await addMarker(); // Add the initial marker when the map is created
  }

  //   static CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(controller.latitude.value, controller.longitude.value),
  //   zoom: 12,
  //   tilt: 59.440717697143555,
  //   bearing: 12.8334901395799,
  // );

  Future<void> cancelRequest() async {
    var client = http.Client();

    var response = await client.post(
      Uri.parse(Constants.TRANSACTION_CANCEL_API_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'transactionId': transactionId.value,
        'status': "8",
      }),
    );

    // _firestore
    //     .collection("transaction")
    //     .doc(transactionId.value)
    //     .delete()
    //     .then(
    //       (doc) => () {
    //         log("Document deleted");

    //         // checkAvailableRequest();
    //         // transactionStatus.value = 0;
    //         // update();
    //       },
    //       onError: (e) => log("Error updating document $e"),
    //     );

    transactionStatus.value = 0;
    box.remove('countdownDuration');
  }

  Future checkUserTransactionStates() async {
    log('checkAvailableRequest checkAvailableRequest');

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
        transactionStatus.value = data["txStatusCode"]!;
        amount.value = data["amount"]!;
      });

//       QuerySnapshot querySnapshot = await _firestore
//           .collection('transaction')
//           .where('customerId', isEqualTo: userId.value) // Add your where clause
//           .where('deleted', isEqualTo: false) // Add your where clause

//           .limit(1) // Limit the result to 1 document
//           .snapshots()
//           .listen();
//       inspect("data=====>");

//       if (querySnapshot.docs.isNotEmpty) {
//         isPendingTrxnAvailable.value = true;

// // If there is at least one document matching the query
//         DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

//         Map<String, dynamic>? data =
//             documentSnapshot.data() as Map<String, dynamic>?;

//         if (data != null) {
//           int? txStatusCode = data['txStatusCode'];
//           String _transactionId = data['transactionId'];

//           transactionStatus.value = txStatusCode!;
//           transactionId.value = _transactionId;
//           initialSize.value = 0.75;

//           return txStatusCode;
//         } else {
//           // Handle the case where data is null
//           return null;
//         }
//       } else {
//         // If no documents match the query
//         return null;
//       }
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
          bool _isDeleted = data['deleted'];

          transactionStatus.value = txStatusCode!;
          transactionId.value = _transactionId;
          isDeleted.value = _isDeleted;

          initialSize.value = 0.75;

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

    String url = Constants.INITIATE_PAYMENT_URL +
        "?transactionId=" +
        transactionId.value +
        "&paymentId=" +
        paymentId.value +
        "&amount=" +
        amount.value.trim();

    try {
      http.Response response = await http.get(Uri.parse(url));

      isLoading.value = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);

        // int code = data['data']['code'];

        String token = jsonMap['response']['token'];
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
}
