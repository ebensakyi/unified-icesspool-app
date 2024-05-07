import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/progress-outline-button.dart';
import 'package:icesspool/widgets/progress-outline-icon-button.dart';
import 'package:icesspool/widgets/section-header.dart';
import 'package:icesspool/widgets/solid-button.dart';
import 'package:icesspool/widgets/text-box.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/profile.svg",
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
              alignment: Alignment.center,
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
                              controller: controller.firstNameController,
                            ),
                          ),
                          Expanded(
                            child: TextBox(
                              labelText: "Last name",
                              controller: controller.lastNameController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: TextBox(
                              controller: controller.phoneNumberController,
                              labelText: "Phone number",
                              readOnly: true,
                            ),
                          ),
                          Expanded(
                            child: TextBox(
                              controller: controller.emailController,
                              labelText: "E-mail",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TextBox(
                      //         obscureText: true,
                      //         controller: controller.passwordController,
                      //         labelText: "Password",
                      //         validator: (value) {
                      //           return Validator.passwordValidator(value!);
                      //         },
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: TextBox(
                      //         obscureText: true,
                      //         controller: controller.cpasswordController,
                      //         labelText: "Confirm password",
                      //         validator: (value) {
                      //           return Validator.passwordValidator(value!);
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Obx(() => SolidButton(
                                buttonColor: MyColors.primary,
                                onPressed: () {
                                  controller.updateProfile(context);
                                },
                                showLoading: controller.isLoading.value,
                                // icon: SizedBox.shrink(),
                                label: Text("Update Profile"),
                                textColor: MyColors.white,
                              )),
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
                      controller.deleteAccount();
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
      ),
    );
  }
}
