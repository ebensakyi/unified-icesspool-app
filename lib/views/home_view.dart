import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icesspool/views/report_history_view.dart';
import 'package:icesspool/views/request_view.dart';

import '../controllers/home_controller.dart';
import '../themes/colors.dart';
import '../widgets/custom-animated-bottom-bar.dart';
import 'about_view.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Obx(
        //     () => Text(controller.currentTitle.value),
        //   ),
        //   centerTitle: true,
        //   backgroundColor: MyColors.MainColor.asMaterialColor.shade900,
        //   actions: [
        //     PopupMenuButton(
        //         // add icon, by default "3 dot" icon
        //         // icon: Icon(Icons.book)
        //         itemBuilder: (context) {
        //       return [
        //         PopupMenuItem<int>(
        //           value: 0,
        //           child: Text("Share"),
        //         ),
        //         PopupMenuItem<int>(
        //           value: 1,
        //           child: Text("Logout"),
        //         ),
        //         // PopupMenuItem<int>(
        //         //   value: 2,
        //         //   child: Text("About"),
        //         // ),
        //       ];
        //     }, onSelected: (value) {
        //       if (value == 0) {
        //         controller.shareApplication();
        //       } else if (value == 1) {
        //         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        //       }
        //     }),
        //   ],
        // ),
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
                activeColor: MyColors.MainColor,
                inactiveColor: controller.inactiveColor.value,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.history),
                title: Text('History'),
                activeColor: MyColors.MainColor,
                inactiveColor: controller.inactiveColor.value,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.menu_open),
                title: Text('Services'),
                activeColor: MyColors.MainColor,
                inactiveColor: controller.inactiveColor.value,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.account_circle_outlined),
                title: Text('Account'),
                activeColor: MyColors.MainColor,
                inactiveColor: controller.inactiveColor.value,
                textAlign: TextAlign.center,
              ),
            ],
          );
        }));
  }

  Widget getBody() {
    List<Widget> pages = [RequestView(), ReportHistoryView(), AboutView()];
    return Obx(() {
      return IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      );
    });
  }
}
