import 'package:flutter/material.dart';

class WaterMainView extends StatelessWidget {
  WaterMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Tanker"),
      ),
      body: Column(
        children: [
          Container(
            child: Text("Water main"),
          ),
          // ListView.builder(
          //   itemCount: controller.priceList.length,
          //   itemBuilder: (context, index) {
          //     return     PriceItemWidget(path: path, size: size, title: title, subTitle: subTitle)
          //   },
          // ),
        ],
      ),
    );
  }
}
