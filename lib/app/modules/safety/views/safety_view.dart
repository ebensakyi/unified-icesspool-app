import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/safety_controller.dart';

class SafetyView extends GetView<SafetyController> {
  const SafetyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SafetyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
