import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icesspool/app/modules/change-password/views/change_password_view.dart';
import 'package:icesspool/app/modules/help/views/help_view.dart';
import 'package:icesspool/app/modules/notification/views/notification_view.dart';
import 'package:icesspool/app/modules/privacy/views/privacy_view.dart';
import 'package:icesspool/app/modules/profile/bindings/profile_binding.dart';
import 'package:icesspool/app/modules/profile/views/profile_view.dart';
import 'package:icesspool/app/modules/safety/views/safety_view.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/about_view.dart';
import 'package:icesspool/widgets/progress-outline-icon-button.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomSheet: InteractiveBottomSheet(
        //   options: InteractiveBottomSheetOptions(
        //       expand: false,
        //       maxSize: 1,
        //       initialSize: 0.5, // controller.initialSize.value,
        //       minimumSize: 0.5),
        // ),
        appBar: AppBar(
          title: const Text('Setting'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.account_circle_outlined),
                    title: Text('Profile'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => ProfileView());
                    }),
                ListTile(
                    leading: Icon(Icons.password_outlined),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => ChangePasswordView());
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ListTile(
                    leading: Icon(Icons.notifications_active_outlined),
                    title: Text('Notifications'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => NotificationView());
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => PrivacyView());
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ListTile(
                    leading: Icon(Icons.lock_outline_sharp),
                    title: Text('Safety'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => SafetyView());
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ListTile(
                    leading: Icon(Icons.headphones_outlined),
                    title: Text('Help'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => HelpView());
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ListTile(
                    leading: Icon(Icons.help_outline_sharp),
                    title: Text('About'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Get.to(() => AboutView());
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
              ],
            ),
          ),
        ));
  }

  // Widget profileModal() {
  //   return Wrap(
  //     children: [
  //       ListTile(
  //         leading: Icon(Icons.share),
  //         title: Row(
  //           children: [
  //             // TextBox(
  //             //   labelText: 'LLsd',
  //             // ),
  //             Text('Share'),
  //           ],
  //         ),
  //       ),
  //       ListTile(
  //         leading: Icon(Icons.copy),
  //         title: Text('Copy Link'),
  //       ),
  //       ListTile(
  //         leading: Icon(Icons.edit),
  //         title: Text('Edit'),
  //       ),
  //     ],
  //   );
  // }
}
