import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icesspool/core/mask_formatter.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/about_view.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:upgrader/upgrader.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final controller = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    final InputMasker inputMasker = InputMasker();
    return UpgradeAlert(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
          title: Text("Sign up"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getImageAsset("assets/images/logo_2.png", 30.0),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: controller.firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'First name',
                        prefixIcon: Icon(Icons.tag_faces_outlined),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      validator: (value) {
                        return Validator.textFieldValidator(value!);
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: controller.lastNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Last name',
                        prefixIcon: Icon(Icons.tag_faces_outlined),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      validator: (value) {
                        return Validator.textFieldValidator(value!);
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: controller.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [inputMasker.phoneMask],
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      validator: (value) {
                        return Validator.phoneValidator(value!);
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      validator: (value) {
                        return Validator.passwordValidator(value!);
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      controller: controller.cpasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.password_outlined),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (value != controller.passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Obx(() => ProgressButton(
                          onPressed: () {
                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              controller.isLoading.value = false;
                              return;
                            }
                            controller.signup(context);
                          },
                          isLoading: controller.isLoading.value,
                          label: 'Signup',
                          progressColor: Colors.white,
                          textColor: Colors.white,
                          backgroundColor: MyColors.secondary,
                          borderColor: MyColors.secondary,
                        )),
                    SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        text: 'By signing up you accept the ',
                        style: TextStyle(fontSize: 12),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.openUrl(),
                            text: 'privacy policy',
                            style: TextStyle(
                              color: MyColors.secondary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and terms of use'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
