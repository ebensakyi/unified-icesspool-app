import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:icesspool/core/mask_formatter.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/solid-button.dart';

import '../controllers/change_password_controller.dart';
import 'package:icesspool/widgets/text-box.dart';

class ChangePasswordView extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());
  final inputMasker = InputMasker();

  ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/forgot-password.svg",
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                // Request focus on the first text field when tapped
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              child: TextFormField(
                                controller: controller.phoneNumberController,
                                keyboardType: TextInputType.number,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                onSaved: (value) {
                                  controller.phoneNumberController.text =
                                      value!;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  labelText: '',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: Icon(Icons.phone_android),
                                ),
                                inputFormatters: [inputMasker.phoneMask],
                                validator: (value) {
                                  return Validator.phoneValidator(value!);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Password ',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Obx(() => GestureDetector(
                                  onTap: () {
                                    // Request focus on the first text field when tapped
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: TextFormField(
                                    obscureText:
                                        controller.obscurePassword1.value,
                                    controller:
                                        controller.oldPasswordController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      labelText: '',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      prefixIcon: Icon(Icons.password_outlined),
                                      suffixIcon: Obx(() => IconButton(
                                            icon: Icon(
                                              controller.obscurePassword1.value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () => controller
                                                .togglePasswordVisibility1(),
                                          )),
                                    ),
                                    validator: (value) {
                                      return Validator.passwordValidator(
                                          value!);
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Password ',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Obx(() => GestureDetector(
                                  onTap: () {
                                    // Request focus on the first text field when tapped
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: TextFormField(
                                    obscureText:
                                        controller.obscurePassword2.value,
                                    controller: controller.passwordController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      labelText: '',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      prefixIcon: Icon(Icons.password_outlined),
                                      suffixIcon: Obx(() => IconButton(
                                            icon: Icon(
                                              controller.obscurePassword2.value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () => controller
                                                .togglePasswordVisibility2(),
                                          )),
                                    ),
                                    validator: (value) {
                                      return Validator.passwordValidator(
                                          value!);
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password ',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Obx(() => GestureDetector(
                                  onTap: () {
                                    // Request focus on the first text field when tapped
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: TextFormField(
                                    obscureText:
                                        controller.obscurePassword3.value,
                                    controller: controller.cpasswordController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      labelText: '',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      prefixIcon: Icon(Icons.password_outlined),
                                      suffixIcon: Obx(() => IconButton(
                                            icon: Icon(
                                              controller.obscurePassword3.value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () => controller
                                                .togglePasswordVisibility3(),
                                          )),
                                    ),
                                    validator: (value) {
                                      return Validator.passwordValidator(
                                          value!);
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                      // TextBox(
                      //   controller: controller.phoneNumberController,
                      //   labelText: "Enter phone number",
                      //   keyboardType: TextInputType.number,
                      //   validator: (value) {
                      //     return Validator.phoneValidator(value!);
                      //   },
                      // ),
                      // TextBox(
                      //   obscureText: true,
                      //   controller: controller.oldPasswordController,
                      //   labelText: "Enter old password",
                      //   validator: (value) {
                      //     return Validator.passwordValidator(value!);
                      //   },
                      // ),
                      // TextBox(
                      //   obscureText: true,
                      //   controller: controller.passwordController,
                      //   labelText: "Enter new password",
                      //   validator: (value) {
                      //     return Validator.passwordValidator(value!);
                      //   },
                      // ),
                      // TextBox(
                      //   obscureText: true,
                      //   controller: controller.cpasswordController,
                      //   labelText: "Confirm password",
                      //   validator: (value) {
                      //     return Validator.passwordValidator(value!);
                      //   },
                      // ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Obx(() => SolidButton(
                                buttonColor: MyColors.primary,
                                onPressed: () {
                                  controller.changePassword(context);
                                },
                                showLoading: controller.isLoading.value,
                                // icon: SizedBox.shrink(),
                                label: Text("Submit"),
                                textColor: MyColors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
