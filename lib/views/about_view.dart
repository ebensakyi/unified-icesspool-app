import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icesspool/controllers/home_controller.dart';

class AboutView extends StatelessWidget {
  final controller = Get.put(HomeController());

  AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          getImageAsset("assets/images/logo.png", 105.0),
          Container(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                style: TextStyle(
                  wordSpacing: 3,
                  fontSize: 16,
                ),
                '''iCesspool is a digital platform that enables Households and Institutions to access Sanitation and Bulk Water Services.

iCesspool is carefully tailored to assist homes locate the nearest Toilet Containment Emptying Vehicle, Toilet Manual Emptying Gang, Bulk Water (Tanker) Supply Service or Biodigester Servicing Teams at system set prices.

The platform monitor Operator compliance to industry code of conduct and enforce proper occupational health and safety standards'''),
          )),
          SizedBox(height: 20),
          Center(
              child: Obx(() => Text("App name: ${controller.AppName.value}"))),
          Center(
              child: Obx(
                  () => Text("App version: ${controller.AppVersion.value}")))
        ],
      ),
    );
  }

  Widget getImageAsset(path, size) {
    AssetImage assetImage = AssetImage(path);
    Image image = Image(
      image: assetImage,
      width: size,
      height: size,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(5),
    );
  }
}
