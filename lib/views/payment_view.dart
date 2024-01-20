import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends StatelessWidget {
  final controller = Get.put(PaymentController());

  PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkoutUrl = Get.arguments['checkoutUrl'];

    return Scaffold(body: Text("PaymentView ${checkoutUrl}"));
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
