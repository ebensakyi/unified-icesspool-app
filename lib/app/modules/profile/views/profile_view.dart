import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/progress-outline-button.dart';
import 'package:icesspool/widgets/progress-outline-icon-button.dart';
import 'package:icesspool/widgets/section-header.dart';
import 'package:icesspool/widgets/solid-button.dart';
import 'package:icesspool/widgets/text-box.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        builder: (ProfileController controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                SectionHeader(
                  title: "Account",
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  labelText: "First name",
                                  controller: controller.firstName,
                                ),
                              ),
                              Expanded(
                                child: TextBox(
                                  labelText: "Last name",
                                  controller: controller.lastName,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  controller: controller.phoneNumber,
                                  labelText: "Phone number",
                                ),
                              ),
                              Expanded(
                                child: TextBox(
                                  controller: controller.email,
                                  labelText: "E-mail",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: SolidButton(
                                buttonColor: MyColors.primary,
                                onPressed: () {
                                  controller.logout();
                                },
                                showLoading: controller.isLoading.value,
                                // icon: SizedBox.shrink(),
                                label: Text("Save"),
                                textColor: MyColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProgressOutlineIconButton(
                          primaryColor: MyColors.secondary,
                          onPressed: () {
                            controller.logout();
                          },
                          isLoading: controller.isLoading.value,
                          iconData: Icons.logout_sharp,
                          label: "Logout"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SolidButton(
                        // primaryColor: MyColors.secondary,
                        onPressed: () {
                          controller.logout();
                        },
                        // isLoading: controller.isLoading.value,
                        // iconData: Icons.delete_forever_outlined,
                        label: Text("Delete Account"), showLoading: false,
                        buttonColor: MyColors.secondary,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
