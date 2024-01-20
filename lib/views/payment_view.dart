import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends StatelessWidget {
  final controller = Get.put(PaymentController());

  // ..loadRequest(Uri.parse('https://flutter.dev'));

  PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Make Payment ${controller.newUrl.value}"),
        ),
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: WebViewWidget(controller: controller.webViewController)),
            ProgressButton(
              onPressed: () {
                // controller.cancelRequest("controller.transactionId");
                Get.back();
              },
              isLoading: controller.isLoading.value,
              iconData: Icons.arrow_circle_right_outlined,
              label: 'Continue',
              iconColor: Colors.white,
              progressColor: Colors.white,
              textColor: Colors.white,
              backgroundColor:
                  controller.isLoading.value ? Colors.teal : Colors.teal,
              borderColor: Colors.teal,
            )
          ],
        ));
  }

  // Widget getImageAsset(path, size) {
  //   AssetImage assetImage = AssetImage(path);
  //   Image image = Image(
  //     image: assetImage,
  //     width: size,
  //     height: size,
  //   );
  //   return Container(
  //     child: image,
  //     margin: EdgeInsets.all(5),
  //   );
  // }
}
