import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icesspool/services/data_services.dart';

class TransactionHistoryController extends GetxController {
  var transactionHistory = [].obs;
  final userId = 0.obs;

  var isLoading = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    final box = await GetStorage();

    userId.value = box.read('userId');
    isLoading.value = true;
    transactionHistory.value =
        await DataServices.getTransactionHistory(userId.value);
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
