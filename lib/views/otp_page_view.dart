import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:icesspool/bindings/otp_binding.dart';
import 'package:icesspool/controllers/otp_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/auth_page_controller.dart';
import '../themes/colors.dart';
import '../widgets/otp-box.dart';
import '../widgets/small-button.dart';

class OtpPageView extends GetView<OtpController> {
  const OtpPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Account'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.teal,
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
              height: 10,
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
                        // Get.toNamed(Routes.CLIENT_LANDING_PAGE);
                        var res = controller.verifyOtp();
                        //if (res == 1) Get.toNamed(Routes.CLIENT_LANDING_PAGE);
                      },
                      showLoading: false,
                      label: "Verify",
                      backgroundColor: Colors.teal,
                    ),
                  ],
                ),
              ),
            ),
            Text("Didn't receive any code?"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: InkWell(
                  child: Text(
                    "Resend code",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: MyColors.DarkBlue),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
