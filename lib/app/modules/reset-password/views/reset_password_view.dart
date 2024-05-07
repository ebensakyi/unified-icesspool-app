import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:icesspool/core/mask_formatter.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/section-header.dart';
import 'package:icesspool/widgets/solid-button.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  ResetPasswordView({Key? key}) : super(key: key);
  // InputMasker inputMasker = new InputMasker();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ResetPasswordController(),
        builder: (ResetPasswordController controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/reset-password.svg",
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SectionHeader(title: "Reset your password here"),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 16, right: 16, bottom: 16),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         'Phone Number',
                                //         style: TextStyle(
                                //             color: Colors.black54,
                                //             fontSize: 16),
                                //       ),
                                //       SizedBox(height: 8),
                                //       TextFormField(
                                //         enabled: false,
                                //         controller:
                                //             controller.phoneNumberController,
                                //         keyboardType: TextInputType.number,
                                //         maxLengthEnforcement:
                                //             MaxLengthEnforcement.enforced,
                                //         onSaved: (value) {
                                //           controller.phoneNumberController
                                //               .text = value!;
                                //         },
                                //         decoration: InputDecoration(
                                //           contentPadding: EdgeInsets.symmetric(
                                //               vertical: 10, horizontal: 10),
                                //           labelText: '',
                                //           filled: true,
                                //           fillColor: Colors.white,
                                //           border: OutlineInputBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(8),
                                //           ),
                                //           prefixIcon: Icon(Icons.phone_android),
                                //         ),
                                //         inputFormatters: [
                                //           inputMasker.phoneMask
                                //         ],
                                //         validator: (value) {
                                //           return Validator.phoneValidator(
                                //               value!);
                                //         },
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Reset Code',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        controller:
                                            controller.resetCodeController,
                                        keyboardType: TextInputType.number,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        onSaved: (value) {
                                          controller.resetCodeController.text =
                                              value!;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          labelText: '',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          prefixIcon: Icon(Icons.phone_android),
                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        obscureText: true,
                                        controller:
                                            controller.passwordController,
                                        keyboardType: TextInputType.text,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        onSaved: (value) {
                                          controller.phoneNumberController
                                              .text = value!;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          labelText: '',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          prefixIcon: Icon(Icons.password),
                                        ),

                                        validator: (value) {
                                          return Validator.passwordValidator(
                                              value!);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Confirm Password',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        obscureText: true,
                                        controller:
                                            controller.cpasswordController,
                                        keyboardType: TextInputType.text,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        onSaved: (value) {
                                          controller.passwordController.text =
                                              value!;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          labelText: '',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          prefixIcon: Icon(Icons.password),
                                        ),

                                        validator: (value) {
                                          // return Validator.confirmPasswordValidator(
                                          //     value!,
                                          //     controller.passwordController.text);
                                          if (value == null || value.isEmpty) {
                                            return 'Confirm Password is required';
                                          }
                                          if (value !=
                                              controller
                                                  .passwordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    height: 60,
                                    width: double.infinity,
                                    child: SolidButton(
                                      buttonColor: MyColors.primary,
                                      onPressed: () {
                                        final isValid =
                                            formKey.currentState!.validate();
                                        if (!isValid) {
                                          controller.isLoading.value = false;
                                          return;
                                        }
                                        controller.resetPassword(context);
                                      },
                                      showLoading: controller.isLoading.value,
                                      // icon: SizedBox.shrink(),
                                      label: Text("Submit"),
                                      textColor: MyColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
