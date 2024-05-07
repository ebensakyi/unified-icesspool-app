import 'package:get/get.dart';

import '../controllers/forgotten_password_controller.dart';

class ForgottenPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgottenPasswordController>(
      () => ForgottenPasswordController(),
    );
  }
}
