import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icesspool/services/data_services.dart';
import 'package:logger_plus/logger_plus.dart';

class TransactionHistoryController extends GetxController {
  var logger = new Logger();
  var transactionHistory = [].obs;
  final userId = 0.obs;

  var isLoading = false.obs;
  @override
  Future onInit() async {
    super.onInit();
    final box = await GetStorage();

    userId.value = box.read('userId');
    logger.d(userId.value);
    isLoading.value = true;
    transactionHistory.value =
        await DataServices.getTransactionHistory(userId.value);

    logger.wtf(transactionHistory);
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
