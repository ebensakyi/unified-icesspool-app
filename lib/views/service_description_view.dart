import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    ListItem(
      name: 'Drainfield servicing',
      description:
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    ),
    ListItem(
      name: 'Soakaway servicing',
      description:
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    ListItem(
      name: 'Person 3',
      description:
          'Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    ),
    ListItem(
      name: 'Person 4',
      description:
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
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
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            );
          },
        ));
  }
}

class ListItem {
  final String name;
  final String description;

  ListItem({required this.name, required this.description});
}
