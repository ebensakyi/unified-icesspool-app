import 'package:get/get.dart';

import '../controllers/toilet_truck_controller.dart';

class ToiletTruckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToiletTruckController>(
      () => ToiletTruckController(),
    );
  }
}
