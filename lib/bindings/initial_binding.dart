import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    // Get.lazyPut<SingleReportController>(
    //   () => SingleReportController(),
    // );
  }
}
