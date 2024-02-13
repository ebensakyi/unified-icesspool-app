import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:get/get.dart';

import '../controllers/payment_controller.dart';
import '../themes/colors.dart';
import '../widgets/progress-icon-button.dart';

class PaymentView extends StatelessWidget {
  final controller = Get.put(PaymentController());

  // ..loadRequest(Uri.parse('https://flutter.dev'));

  PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Make Payment"),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  child:
                      WebViewWidget(controller: controller.webViewController)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => Visibility(
                      visible: controller.show.value,
                      child: ProgressIconButton(
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
                        backgroundColor: controller.isLoading.value
                            ? MyColors.primary
                            : MyColors.primary,
                        borderColor: MyColors.primary,
                      ),
                    )),
              )
            ],
          ),
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
