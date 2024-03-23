import 'package:get/get.dart';

import '../controllers/water_tanker_controller.dart';

class WaterTankerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaterTankerController>(
      () => WaterTankerController(),
    );
  }
}
