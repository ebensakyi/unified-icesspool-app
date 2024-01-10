import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../contants.dart';
import 'home_controller.dart';

class RequestController extends GetxController {
  final community = "".obs;
  final Completer<GoogleMapController> _controller = Completer();
  final controller = Get.put(HomeController());

  final Map<MarkerId, Marker> markers = {};
  final pendingTransaction = false.obs;

  @override
  onInit() async {
    // community.value = Get.arguments['community'];

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
}
