import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icesspool/controllers/otp_controller.dart';

import '../themes/colors.dart';
import '../widgets/otp-box.dart';
import '../widgets/small-button.dart';

class OtpPageView extends GetView<OtpController> {
  const OtpPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).unfocus();
    // });
    return GetBuilder(
        init: OtpController(),
        builder: (OtpController controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Verify Account'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              foregroundColor: MyColors.primary,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                SvgPicture.asset(
                  "assets/images/otp.svg",
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Verification",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter your OTP code here",
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Request focus on the first text field when tapped
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              child: OtpBox(
                                controller: controller.num1Controller,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  // Request focus on the first text field when tapped
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: OtpBox(
                                    controller: controller.num2Controller)),
                            GestureDetector(
                                onTap: () {
                                  // Request focus on the first text field when tapped
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: OtpBox(
                                    controller: controller.num3Controller)),
                            GestureDetector(
                                onTap: () {
                                  // Request focus on the first text field when tapped
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: OtpBox(
                                    controller: controller.num4Controller)),
                          ],
                        ),
                        SmallButton(
                          onPressed: () {
                            controller.verifyOtp();
                          },
                          showLoading: false,
                          label: Text("Verify"),
                          textColor: Colors.white,
                          backgroundColor: MyColors.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
                Text("Didn't receive any code?"),
                SizedBox(
                  height: 20,
                ),
                Obx(() => Visibility(
                      visible: controller.hideTimer.value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.resendOtp();
                          },
                          child: InkWell(
                            child: Text(
                              "Resend code",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.primary),
                            ),
                          ),
                        ),
                      ),
                    )),
                Obx(() => Visibility(
                      visible: !controller.hideTimer.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              // value: controller.progress.value,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MyColors.primary),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(() => Text(
                                "Waiting for OTP ${controller.countdown.value}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondary),
                              )),
                        ],
                      ),
                    )),
              ]),
            ),
          );
        });
  }
}
