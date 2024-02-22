import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icesspool/app/modules/forget-password/views/forget_password_view.dart';
import 'package:icesspool/app/modules/login/controllers/login_controller.dart';
import 'package:icesspool/core/mask_formatter.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/signup_view.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:icesspool/widgets/progress-outline-button.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  final inputMasker = InputMasker();

  final imageList = [
    "assets/images/crs.jpg",
    "assets/images/ssgl.png",
    "assets/images/tama.png",
    "assets/images/espa.png",
    "assets/images/gama.jpg",
    "assets/images/crs.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    return UpgradeAlert(
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/background.svg',
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              getImageAsset("assets/images/logo_2.png", 200.0),
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
                                      'Password ',
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
                                            obscureText: controller
                                                .obscurePassword.value,
                                            controller:
                                                controller.passwordController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              labelText: '',
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              prefixIcon:
                                                  Icon(Icons.password_outlined),
                                              suffixIcon: Obx(() => IconButton(
                                                    icon: Icon(
                                                      controller.obscurePassword
                                                              .value
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                    ),
                                                    onPressed: () => controller
                                                        .togglePasswordVisibility(),
                                                  )),
                                            ),
                                            validator: (value) {
                                              return Validator
                                                  .passwordValidator(value!);
                                            },
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Obx(() => ProgressButton(
                                        onPressed: () {
                                          final isValid =
                                              formKey.currentState!.validate();
                                          if (!isValid) {
                                            controller.isLoading.value = false;
                                            return;
                                          }
                                          controller.login(context);
                                        },
                                        isLoading: controller.isLoading.value,
                                        label: 'Login',
                                        progressColor: Colors.white,
                                        textColor: Colors.white,
                                        backgroundColor:
                                            controller.isLoading.value
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
                                    onTap: () =>
                                        Get.to(() => ForgetPasswordView()),
                                  ),
                                ),
                              ),
                              Text("Or"),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ProgressOutlineButton(
                                    primaryColor: MyColors.secondary,
                                    onPressed: () {
                                      Get.to(() => SignupView());
                                    },
                                    isLoading: controller.isLoading.value,
                                    label: 'Signup',
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
                                        ..onTap = () => openUrl(),
                                      text: ' privacy policy ',
                                      style: TextStyle(
                                          color: MyColors.primary,
                                          decoration: TextDecoration.underline),
                                    ),
                                    TextSpan(
                                        text: 'and terms of use',
                                        style: TextStyle()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Place the CarouselSlider at the bottom
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: CarouselSlider(
                //     options: CarouselOptions(
                //       height: 60.0,
                //       autoPlay: true,
                //       aspectRatio: 16 / 9,
                //       viewportFraction: 0.8,
                //     ),
                //     items: [
                //       "assets/images/crs.jpg",
                //       "assets/images/ssgl.png",
                //       "assets/images/tama.png",
                //       "assets/images/espa.png",
                //       "assets/images/gama.jpg"
                //     ].map((i) {
                //       return Builder(
                //         builder: (BuildContext context) {
                //           return Container(
                //               width: MediaQuery.of(context).size.width * 0.8,
                //               margin: EdgeInsets.symmetric(horizontal: 5.0),
                //               decoration: BoxDecoration(color: Colors.white),
                //               child: Image.asset('$i'));
                //         },
                //       );
                //     }).toList(),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                      child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 60.0,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      autoPlay: true,
                    ),
                    itemCount: (imageList.length / 2).round(),
                    itemBuilder: (context, index, realIdx) {
                      final int first = index * 2;
                      final int second = first + 1;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [first, second].map((idx) {
                          return Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Image.asset(
                                imageList[idx],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  )),
                ),
              ],
            ),
          ],
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
      margin: EdgeInsets.all(2),
    );
  }

  Future<void> openUrl() async {
    var url = Uri.parse(
        "https://esicapps-files.s3.eu-west-2.amazonaws.com/privacy-policy/sr-privacy.html");
    await launch(url.toString());
  }
}
