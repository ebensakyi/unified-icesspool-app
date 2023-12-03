import 'package:get/get.dart';
import 'package:icesspool/controllers/single_report_controller.dart';

class SingleReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SingleReportController>(SingleReportController());
  }
}
