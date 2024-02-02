import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/complete_payment_controller.dart';

class CompletePaymentView extends GetView<CompletePaymentController> {
  const CompletePaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CompletePaymentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CompletePaymentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
