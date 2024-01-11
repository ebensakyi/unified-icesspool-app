import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icesspool/controllers/home_controller.dart';

class AccountView extends StatelessWidget {
  final controller = Get.put(HomeController());

  AccountView({Key? key}) : super(key: key);

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
                '''User Account Details'''),
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
