import 'package:flutter/material.dart';

class EmptyingMainView extends StatelessWidget {
  EmptyingMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Text("Tanker emptying"),
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
