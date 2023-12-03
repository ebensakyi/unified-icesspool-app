import 'package:get/get.dart';
import 'package:icesspool/controllers/single_report_controller.dart';

import '../controllers/home_controller.dart';
import '../controllers/report_controller.dart';

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
