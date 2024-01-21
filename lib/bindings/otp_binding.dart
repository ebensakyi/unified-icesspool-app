import 'package:get/get.dart';
import 'package:icesspool/controllers/home_controller.dart';

import '../controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OtpController>(OtpController());
  }
}
