// ignore_for_file: unnecessary_set_literal, must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../core/mask_formatter.dart';
import '../core/validator.dart';
import '../themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';

import '../widgets/progress-icon-button.dart';

class SignupView extends StatelessWidget {
  final controller = Get.put(SignupController());
  final formKey = new GlobalKey<FormState>();

  SignupView({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _minimumPadding = 2.0;
  final maxLines = 5;
  InputMasker inputMasker = new InputMasker();

  final ButtonStyle flatBtnStyle1 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      backgroundColor: const Color.fromARGB(255, 195, 229, 252),
      elevation: 0,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ));

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

    return UpgradeAlert(
      child: Theme(
        data: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.teal,
          colorScheme: ColorScheme.light(primary: Colors.teal),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login',
          theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(width: 1, color: Colors.greenAccent),
                // ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: MyColors.MainColor),
                ),
                labelStyle: TextStyle(color: MyColors.MainColor),
                iconColor: MyColors.MainColor),
            scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          ),
          home: Scaffold(
            appBar: AppBar(
                forceMaterialTransparency: true,
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    }),
                title: Text("Sign up")),
            body: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: TextFormField(
                              controller: controller.firstNameController,
                              keyboardType: TextInputType.name,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              onSaved: (value) {
                                controller.firstNameController.text = value!;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),

                                // errorText: widget.errorText,
                                labelText: 'First name',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  // borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.tag_faces_outlined),
                              ),
                              validator: (value) {
                                return Validator.textFieldValidator(value!);
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: TextFormField(
                                controller: controller.lastNameController,
                                keyboardType: TextInputType.name,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                onSaved: (value) {
                                  controller.lastNameController.text = value!;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),

                                  // errorText: widget.errorText,
                                  labelText: 'Last name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(Icons.tag_faces_outlined),
                                ),
                                validator: (value) {
                                  return Validator.textFieldValidator(value!);
                                },
                              )),

                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: TextFormField(
                                controller: controller.phoneNumberController,
                                keyboardType: TextInputType.phone,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                onSaved: (value) {
                                  controller.phoneNumberController.text =
                                      value!;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),

                                  // errorText: widget.errorText,
                                  labelText: 'Phone Number',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(Icons.phone_android),
                                ),
                                inputFormatters: [inputMasker.phoneMask],
                                validator: (value) {
                                  return Validator.phoneValidator(value!);
                                },
                              )),

                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: TextFormField(
                                controller: controller.passwordController,
                                keyboardType: TextInputType.text,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                onSaved: (value) {
                                  controller.passwordController.text = value!;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),

                                  // errorText: widget.errorText,
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                                validator: (value) {
                                  return Validator.passwordValidator(value!);
                                },
                              )),

                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: TextFormField(
                                controller: controller.cpasswordController,
                                keyboardType: TextInputType.text,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                onSaved: (value) {
                                  controller.cpasswordController.text = value!;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),

                                  // errorText: widget.errorText,
                                  labelText: 'Confirm Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    // borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                                validator: (value) {
                                  // return Validator.confirmPasswordValidator(
                                  //     value!,
                                  //     controller.passwordController.text);
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm Password is required';
                                  }
                                  if (value !=
                                      controller.passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              )),
                          // Obx(
                          //   () => Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: LoadingButton(
                          //       label: "Login",
                          //       showLoading: controller.isLoading.value,
                          //       onPressed: () {
                          //         controller.isLoading.value = true;
                          //         final isValid =
                          //             _formKey.currentState!.validate();
                          //         if (!isValid) {
                          //           controller.isLoading.value = false;
                          //           return;
                          //         }
                          //         controller.signUpLogin();

                          //         // Get.to(() => HomeDashboardPage());
                          //         // Navigator.pushReplacementNamed(context, Constants.HomeRoute);
                          //       },
                          //       color: MyColors.MainColor,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ProgressIconButton(
                                onPressed: () {
                                  controller.isLoading.value = true;
                                  final isValid =
                                      _formKey.currentState!.validate();
                                  if (!isValid) {
                                    controller.isLoading.value = false;
                                    return;
                                  }
                                  controller.signup();
                                },
                                isLoading: controller.isLoading.value,
                                iconData: Icons.verified_user_outlined,
                                label: 'Signup',
                                iconColor: Colors.white,
                                progressColor: Colors.white,
                                textColor: Colors.white,
                                backgroundColor: controller.isLoading.value
                                    ? Colors.teal
                                    : Colors.teal,
                                borderColor: Colors.teal,
                              ),
                            ),
                          ),

                          Text.rich(
                            TextSpan(
                              text: 'By signing up  you accept the',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {openUrl()},
                                  text: ' privacy policy ',
                                  style: TextStyle(
                                      color: MyColors.SecondaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(
                                    text: 'and terms of use',
                                    style: TextStyle()),
                              ],
                            ),
                          ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   child: const Text("OR"),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(16.0),
                          //   child: ElevatedButton(
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           getSmallImageAsset(
                          //               "assets/images/google.png", 24.0),
                          //           const Expanded(
                          //             child: Text("Sign up with Google",
                          //                 style: TextStyle(
                          //                     color: Colors.black,
                          //                     fontWeight: FontWeight.w600,
                          //                     fontSize: 14)),
                          //           ),
                          //         ],
                          //       ),
                          //       style: flatBtnStyle1,
                          //       onPressed: () {
                          //         controller.loginWithGoogle();
                          //         // context
                          //         //     .read<AuthenticationService>()
                          //         //     .signUpWithGoogle();
                          //       }),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getImageAsset(path, size) {
    AssetImage assetImage = AssetImage(path);
    Image image = Image(
      image: assetImage,
      width: size,
      height: size,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 1),
    );
  }

  Widget getSmallImageAsset(path, size) {
    AssetImage assetImage = AssetImage(path);
    Image image = Image(
      image: assetImage,
      width: size,
      height: size,
    );
    return Container(
      child: image,
      margin: const EdgeInsets.fromLTRB(20.0, 10.0, 15.0, 10.0),
    );
  }

  // void _googleSignin() {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  //}

  Future<void> openUrl() async {
    var url = Uri.parse(
        "https://esicapps-files.s3.eu-west-2.amazonaws.com/privacy-policy/sr-privacy.html");
    await launchUrl(url);

    // if (await canLaunchUrl(url))
    //   await launchUrl(url);
    // else
    //   // can't launch url, there is some error
    //   throw "Could not launch $url";
  }
}
