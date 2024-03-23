import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/water_tanker_controller.dart';

class WaterTankerView extends GetView<WaterTankerController> {
  const WaterTankerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WaterTankerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WaterTankerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
