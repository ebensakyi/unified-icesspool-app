import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../contants.dart';

class RequestController extends GetxController {
  final community = "".obs;
  final Completer<GoogleMapController> _controller = Completer();

  final Map<MarkerId, Marker> markers = {};
  var emptyingServiceAvailable = false.obs;
  var waterServiceAvailable = false.obs;
  var biodigesterServiceAvailable = false.obs;
  @override
  onInit() async {
    await getAvailableServices();
    // community.value = Get.arguments['community'];

    super.onInit();
  }

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

    markers[markerId] = marker;
    update(); // Update the UI with the new marker
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    await addMarker(); // Add the initial marker when the map is created
  }

  Future<void> getAvailableServices() async {
    final String apiUrl = Constants.SERVICES_AVAILABLE_API_URL;
    final Map<String, String> params = {'serviceAreaId': '1'};

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        List<dynamic> data = json.decode(response.body);
        emptyingServiceAvailable.value = data.contains(1);
        waterServiceAvailable.value = data.contains(2);
        biodigesterServiceAvailable.value = data.contains(3);

        print('getAvailableServices Response Data: $data');
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exception
      print('Exception: $error');
    }
  }
}
