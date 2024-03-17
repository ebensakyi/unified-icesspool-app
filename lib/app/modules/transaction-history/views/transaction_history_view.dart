import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icesspool/core/utils.dart';

import '../controllers/transaction_history_controller.dart';

class TransactionHistoryView extends StatelessWidget {
  final controller = Get.put(TransactionHistoryController());
  TransactionHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.transactionHistory.length,
        itemBuilder: (context, index) {
          final item = controller.transactionHistory[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 1,
              child: ListTile(
                title: Text(item['service']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('GHS ${item['discountedCost']}'),
                    Text(Utils.convertTime('${item['createdAt']}')),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    // body: Center(
    //   child: Text("data"),
    // ),
  }
}
