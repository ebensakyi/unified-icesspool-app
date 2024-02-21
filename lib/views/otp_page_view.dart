import 'package:flutter/material.dart';
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
                  width: 250,
                ),
                SizedBox(
                  height: 30,
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
                            OtpBox(
                              controller: controller.num1Controller,
                            ),
                            OtpBox(controller: controller.num2Controller),
                            OtpBox(controller: controller.num3Controller),
                            OtpBox(controller: controller.num4Controller),
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
                Padding(
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
              ]),
            ),
          );
        });
  }
}
