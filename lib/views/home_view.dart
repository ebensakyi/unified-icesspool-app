import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icesspool/app/modules/transaction-history/views/transaction_history_view.dart';
import 'package:icesspool/core/notification_controller.dart';
import 'package:icesspool/views/report_history_view.dart';
import 'package:icesspool/views/request_view.dart';

import '../app/modules/setting/views/setting_view.dart';
import '../controllers/home_controller.dart';
import '../themes/colors.dart';
import '../widgets/custom-animated-bottom-bar.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: Obx(() {
          return CustomAnimatedBottomBar(
            containerHeight: 70,
            backgroundColor: Colors.grey.shade100,
            selectedIndex: controller.currentIndex.value,
            showElevation: true,
            itemCornerRadius: 24,
            curve: Curves.slowMiddle,
            onItemSelected: (index) => controller.changeTabIndex(index),
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('Home'),
                activeColor: MyColors.primary,
                inactiveColor: controller.inactiveColor.value,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.history),
                title: Text('History'),
                activeColor: MyColors.primary,
                inactiveColor: controller.inactiveColor.value,
                textAlign: TextAlign.center,
              ),
              // BottomNavyBarItem(
              //   icon: Icon(Icons.video_collection_outlined),
              //   title: Text('Services'),
              //   activeColor: MyColors.MainColor,
              //   inactiveColor: controller.inactiveColor.value,
              //   textAlign: TextAlign.center,
              // ),
              BottomNavyBarItem(
                icon: Icon(Icons.account_circle_outlined),
                title: Text('Account'),
                activeColor: MyColors.primary,
                inactiveColor: controller.inactiveColor.value,
                textAlign: TextAlign.center,
              ),
            ],
          );
        }));
  }

  Widget getBody() {
    List<Widget> pages = [
      RequestView(),
      TransactionHistoryView(),
      // ServicesBlogView(),
      SettingView()
    ];
    return Obx(() {
      return IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      );
    });
  }
}
