import 'package:get/get.dart';

import '../controllers/complete_payment_controller.dart';

class CompletePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletePaymentController>(
      () => CompletePaymentController(),
    );
  }
}
