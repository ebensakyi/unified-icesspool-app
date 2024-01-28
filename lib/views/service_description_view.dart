import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icesspool/widgets/circular-imageview.dart';
import 'package:intl/intl.dart';
import 'package:icesspool/bindings/single_report_binding.dart';
import 'package:icesspool/contants.dart';
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/routes/app_pages.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/single_report_view.dart';

import '../core/random.dart';
import '../widgets/service-description-cards.dart';

class ServiceDescriptionView extends GetView<HomeController> {
  final controller = Get.put(HomeController());
  final List<ListItem> items = [
    ListItem(
        name: 'Biodigester emptying',
        description:
            'A biodigester is a waste treatment technology that decomposes organic matter, primarily from human waste, through anaerobic digestion. The process generates biogas and a nutrient-rich effluent that can be used as fertilizer. ',
        imageUrl: ""),
    ListItem(
      name: 'Drainfield servicing',
      description:
          'A drainfield, also known as a leach field or absorption field, is a crucial component of a septic system. It is responsible for receiving and treating the liquid effluent from the septic tank before it is absorbed into the soil. ',
    ),
    ListItem(
      name: 'Soakaway servicing',
      description:
          'A soakaway, also known as a soak pit, is an underground structure designed to receive and disperse surface water or wastewater into the surrounding soil. It is commonly used for stormwater management, septic systems, or wastewater from various sources.',
    ),
    ListItem(
        name: 'Biodigester Only',
        description:
            'A biodigester is a waste treatment technology that employs anaerobic digestion to break down organic matter, primarily from human waste, animal manure, or other organic materials. ',
        imageUrl: "assets/images/biodigester_only.png"),
    ListItem(
      name: 'Biodigester With Seat',
      description:
          'A biodigester with a seat is a sanitation technology that integrates the functions of a biodigester with a toilet seat. This combination allows for the treatment of human waste through anaerobic digestion while providing a convenient and hygienic toilet facility. ',
    ),
    ListItem(
      name: 'Standalone Toilet',
      description:
          'A standalone toilet, often referred to as a "freestanding toilet" or simply a "toilet," is a fixture used for the disposal of human waste. It is typically found in bathrooms or restrooms and is a crucial component of sanitation infrastructure in residential, commercial, and public spaces.',
    ),
  ];

  ServiceDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Services details")),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ServiceDescription(
              name: items[index].name,
              description: items[index].description,
              circleImageView:
                  CircularImageView(imageUrl: "assets/images/logo_2.png"),
            );
          },
        ));
  }
}

class ListItem {
  final String name;
  final String description;
  final String? imageUrl;

  ListItem({this.imageUrl, required this.name, required this.description});
}
