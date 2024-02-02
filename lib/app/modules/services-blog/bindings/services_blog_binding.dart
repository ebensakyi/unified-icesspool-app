import 'package:get/get.dart';

import '../controllers/services_blog_controller.dart';

class ServicesBlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesBlogController>(
      () => ServicesBlogController(),
    );
  }
}
