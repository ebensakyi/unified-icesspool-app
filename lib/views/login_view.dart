// ignore_for_file: unnecessary_set_literal

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../core/mask_formatter.dart';
import '../core/validator.dart';
import '../themes/colors.dart';
import '../widgets/loading-button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());
  final formKey = new GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

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
    const _minimumPadding = 5.0;

    return UpgradeAlert(
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
          // appBar: AppBar(
          //   forceMaterialTransparency: true,
          //   elevation: 0,
          //   title: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             Get.off(() => ReportView());
          //           },
          //           child: Text(
          //             "Skip",
          //             style: TextStyle(
          //               fontSize: 15,
          //               color: Colors.black54,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Container(
                  color: const Color(0xFFFFFFFF),
                  child: Column(
                    children: <Widget>[
                      getImageAsset("assets/images/logo_2.png", 105.0),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: _minimumPadding, bottom: _minimumPadding),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 20),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "The sanitation experts",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Container(
                        //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                        //   height: maxLines * 8.0,
                        //   child: TextField(
                        //     controller: controller.phoneNumberController,
                        //     maxLines: maxLines,
                        //     decoration: InputDecoration(
                        //       hintText: "Enter your phone",
                        //       fillColor: Colors.grey[300],
                        //       filled: false,
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           vertical: 10.0, horizontal: 20.0),
                        //       border: const OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //       enabledBorder: const OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Color.fromARGB(255, 2, 88, 128),
                        //             width: 1.0),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //       focusedBorder: const OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Color.fromARGB(255, 2, 88, 128),
                        //             width: 2.0),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                        //   height: maxLines * 8.0,
                        //   child: TextField(
                        //     controller: controller.passwordController,
                        //     maxLines: maxLines,
                        //     decoration: InputDecoration(
                        //       hintText: "Enter your passwoord",
                        //       fillColor: Colors.grey[300],
                        //       filled: false,
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           vertical: 10.0, horizontal: 20.0),
                        //       border: const OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //       enabledBorder: const OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Color.fromARGB(255, 2, 88, 128),
                        //             width: 1.0),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //       focusedBorder: const OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Color.fromARGB(255, 2, 88, 128),
                        //             width: 2.0),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(15.0)),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                        //   child: ElevatedButton(
                        //       child: Row(
                        //         children: const [
                        //           // getSmallImageAsset(
                        //           //     "assets/images/google.png", 24.0),
                        //           Expanded(
                        //             child: Align(
                        //               alignment: Alignment.center,
                        //               child: Text(
                        //                 "Sign up",
                        //                 style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 14),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       style: flatBtnStyle2,
                        //       onPressed: () {
                        //         controller.signUp(
                        //             email: emailController.text,
                        //             password: passwordController.text);
                        //       }),
                        // ),
                        // Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Enter your phone number to sign-up and login",
                            style: TextStyle(
                              color: MyColors.MainColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: TextFormField(
                              controller: controller.phoneNumberController,
                              keyboardType: TextInputType.number,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              onSaved: (value) {
                                controller.phoneNumberController.text = value!;
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
                        // TextBox(
                        //   labelText: "Enter password",
                        //   controller: controller.passwordController,
                        // ),

                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LoadingButton(
                              label: "Login",
                              showLoading: controller.isLoading.value,
                              onPressed: () {
                                controller.isLoading.value = true;
                                final isValid =
                                    _formKey.currentState!.validate();
                                if (!isValid) {
                                  controller.isLoading.value = false;
                                  return;
                                }
                                controller.signUpLogin();

                                // Get.to(() => HomeDashboardPage());
                                // Navigator.pushReplacementNamed(context, Constants.HomeRoute);
                              },
                              color: MyColors.MainColor,
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'By logging in you accept the',
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
                                  text: 'and terms of use', style: TextStyle()),
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
