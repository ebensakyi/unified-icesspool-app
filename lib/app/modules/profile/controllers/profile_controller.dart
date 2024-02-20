import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icesspool/views/login_view.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final firstName = "".obs;
  final lastName = "".obs;

  final email = "".obs;
  final photoURL = "".obs;
  final phoneNumber = "".obs;

  final isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> logout() async {
    final box = await GetStorage();
    box.write("isLogin", false);
    Get.to(() => LoginView());
  }
}
