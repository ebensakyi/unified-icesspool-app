import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';

import 'package:icesspool/widgets/solid-button.dart';

import '../../../../core/mask_formatter.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends StatelessWidget {
  final controller = Get.put(ForgetPasswordController());
   InputMasker inputMasker = new InputMasker();
  final formKey = GlobalKey<FormState>();
  ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/forgot-password.svg",
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: SectionHeader(
                  //       title:
                  //           "Enter phone number to receive an otp to reset password"),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),

                                TextFormField(
                                  controller:
                                      controller.phoneNumberController,
                                  keyboardType: TextInputType.number,
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
                                    prefixIcon: Icon(Icons.phone_android),
                                  ),
                                  inputFormatters: [
                                    inputMasker.phoneMask
                                  ],
                                  validator: (value) {
                                    return Validator.phoneValidator(
                                        value!);
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
                              child: Obx(
                                ()=> SolidButton(
                                  buttonColor: MyColors.primary,
                                  onPressed: () {
                                    final isValid =
                                        formKey.currentState!.validate();
                                    if (!isValid) {
                                      controller.isLoading.value = false;
                                      return;
                                    }
                                   controller.forgotPassword(context);
                                  },
                                  showLoading: controller.isLoading.value,
                                  // icon: SizedBox.shrink(),
                                  label: Text("Submit"),
                                  textColor: MyColors.white,
                                ),
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
          );
        }
  }

