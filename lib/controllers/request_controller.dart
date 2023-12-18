import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../views/biodigester_main_view.dart';

class RequestController extends GetxController {
  final community = "".obs;
  final Completer<GoogleMapController> _controller = Completer();

  final Map<MarkerId, Marker> markers = {};

  // @override
  // Future<void> onInit() async {
  //   await _addMarkers();
  //   // community.value = Get.arguments['community'];

  //   super.onInit();
  // }

  Future<void> addMarker() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
        "assets/images/toilet-tanker.png");

    final MarkerId markerId = MarkerId('marker1');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(5.648931, -0.185246),
      infoWindow: InfoWindow(
        title: 'Marker 1',
        snippet: 'This is the first marker.',
      ),
      icon: customIcon,
    );

    inspect(marker);

    markers[markerId] = marker;
    update(); // Update the UI with the new marker
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    await addMarker(); // Add the initial marker when the map is created
  }


}
