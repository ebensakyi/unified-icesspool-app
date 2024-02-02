import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/validator.dart';
import '../controllers/auth_page_controller.dart';
import '../widgets/button.dart';
import '../widgets/dropdown.dart';

class RegisterServiceProviderPageView extends GetView<AuthPageController> {
  const RegisterServiceProviderPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Become a service provider'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.teal,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // SizedBox(
                //   height: 50,
                // ),
                // Text("Register as a regular user"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset("assets/images/f1.svg", width: 210),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextBox(
                //     controller: controller.surnameController,
                //     labelText: "Surname",
                //     hintText: "Enter surname *",
                //     prefixIcon: FontAwesomeIcons.user,
                //     // obscureText: false,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextBox(
                //     controller: controller.otherNamesController,
                //     labelText: "Other names",
                //     hintText: "Enter other names *",
                //     prefixIcon: FontAwesomeIcons.user,
                //     // obscureText: false,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dropdown(
                    onChangedCallback: (newValue) {
                      controller.selectedRegion.value = newValue;
                    },
                    // initialValue: basicInfoSectionController.returnValue(
                    //     basicInfoSectionController
                    //         .selectedRespondentDesignation.value),
                    value: controller.selectedRegion.value,
                    dropdownItems:
                        ["Greater Accra", "Northern Region"].map((var obj) {
                      return DropdownMenuItem<String>(
                        value: obj.toString(),
                        child: Text(obj.toString()),
                        // value: obj.id.toString(),
                        // child: Text(obj.name.toString()),
                      );
                    }).toList(),
                    hintText: '',
                    labelText: 'Please select region of residence *',
                    validator: (value) {
                      return Validator.dropdownValidator(value);
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextBox(
                //     controller: controller.companyController,
                //     labelText: "Company",
                //     hintText: "Enter your company name *",
                //     prefixIcon: FontAwesomeIcons.building,
                //     // obscureText: false,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextBox(
                //     controller: controller.phoneNumberController,
                //     labelText: "Phone",
                //     hintText: "Enter phone number *",
                //     prefixIcon: Icons.phone_android_outlined,
                //     // obscureText: false,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextBox(
                //     controller: controller.emailController,
                //     labelText: "Email",
                //     hintText: "Enter email",
                //     prefixIcon: Icons.email_outlined,
                //     // obscureText: false,
                //   ),
                // ),
                // Obx(() => Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: TextBox(
                //         controller: controller.passwordController,
                //         labelText: "Password",
                //         hintText: "Enter Password",
                //         prefixIcon: Icons.password_outlined,
                //         obscureText: controller.isHidden.value,
                //         suffixIcon: IconButton(
                //           onPressed: controller.togglePasswordView,
                //           icon: Icon(
                //             controller.isHidden.value
                //                 ? Icons.visibility
                //                 : Icons.visibility_off,
                //           ),
                //         ),
                //       ),
                //     )),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                    onPressed: () {
                      // s
                      controller.handleRegisterServiceProvider();
                    },
                    showLoading: false,
                    label: "Submit",
                    buttonColor: Colors.teal,
                    textColor: Colors.white,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //       "By continuing, you agree to iCesspool's Terms  of Service and Privacy"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
