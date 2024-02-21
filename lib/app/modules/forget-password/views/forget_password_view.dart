import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:icesspool/core/mask_formatter.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/progress-button.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  InputMasker inputMasker = new InputMasker();

  ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    // key: formKey,
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
                              TextFormField(
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
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 16, right: 16, bottom: 16),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         'Password ',
                        //         style: TextStyle(
                        //             color: Colors.black54, fontSize: 16),
                        //       ),
                        //       SizedBox(height: 8),
                        //       Obx(() => TextFormField(
                        //             obscureText:
                        //                 controller.obscurePassword.value,
                        //             controller:
                        //                 controller.passwordController,
                        //             decoration: InputDecoration(
                        //               contentPadding:
                        //                   EdgeInsets.symmetric(
                        //                       vertical: 10,
                        //                       horizontal: 10),
                        //               labelText: '',
                        //               filled: true,
                        //               fillColor: Colors.white,
                        //               border: OutlineInputBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(8),
                        //               ),
                        //               prefixIcon:
                        //                   Icon(Icons.password_outlined),
                        //               suffixIcon: Obx(() => IconButton(
                        //                     icon: Icon(
                        //                       controller.obscurePassword
                        //                               .value
                        //                           ? Icons.visibility
                        //                           : Icons.visibility_off,
                        //                     ),
                        //                     onPressed: () => controller
                        //                         .togglePasswordVisibility(),
                        //                   )),
                        //             ),
                        //             validator: (value) {
                        //               return Validator.passwordValidator(
                        //                   value!);
                        //             },
                        //           ))
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Obx(() => ProgressButton(
                                  onPressed: () {
                                    // final isValid =
                                    //     formKey.currentState!.validate();
                                    // if (!isValid) {
                                    //   controller.isLoading.value = false;
                                    //   return;
                                    // }
                                    controller.login(context);
                                  },
                                  isLoading: controller.isLoading.value,
                                  label: 'Login',
                                  progressColor: Colors.white,
                                  textColor: Colors.white,
                                  backgroundColor: controller.isLoading.value
                                      ? MyColors.primary
                                      : MyColors.primary,
                                  borderColor: MyColors.primary,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Text("Forgot password?"),
                              onTap: () => Get.to(() => ForgetPasswordView()),
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
    );
  }
}
