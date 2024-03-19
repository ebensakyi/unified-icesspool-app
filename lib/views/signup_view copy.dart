// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:icesspool/views/about_view.dart';
// import 'package:icesspool/widgets/progress-button.dart';

// import '../controllers/signup_controller.dart';
// import '../core/mask_formatter.dart';
// import '../core/validator.dart';
// import '../themes/colors.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:upgrader/upgrader.dart';

// import '../widgets/progress-icon-button.dart';

// class SignupView extends StatelessWidget {
//   final controller = Get.put(SignupController());
//   final _formKey = GlobalKey<FormState>();

//   SignupView({Key? key}) : super(key: key);

//   final _minimumPadding = 2.0;
//   final maxLines = 5;
//   final InputMasker inputMasker = InputMasker();

//   @override
//   Widget build(BuildContext context) {
//     return UpgradeAlert(
//       child: Scaffold(
//         appBar: AppBar(
//           forceMaterialTransparency: true,
//           elevation: 0,
//           // leading: IconButton(
//           //   icon: Icon(Icons.arrow_back),
//           //   onPressed: () {
//           //     Get.back();
//           //   },
//           // ),
//           title: Text("Sign up"),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   getImageAsset("assets/images/logo_2.png", 100.0),
//                   TextFormField(
//                     controller: controller.firstNameController,
//                     keyboardType: TextInputType.name,
//                     // decoration: InputDecoration(
//                     //   labelText: 'First name',
//                     //   prefixIcon: Icon(Icons.tag_faces_outlined),
//                     //   border: OutlineInputBorder(),
//                     // ),
//                     // validator: (value) {
//                     //   return Validator.textFieldValidator(value!);
//                     // },
//                   ),
//                   // SizedBox(height: 16),
//                   // TextFormField(
//                   //   controller: controller.lastNameController,
//                   //   keyboardType: TextInputType.name,
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Last name',
//                   //     prefixIcon: Icon(Icons.tag_faces_outlined),
//                   //     border: OutlineInputBorder(),
//                   //   ),
//                   //   validator: (value) {
//                   //     return Validator.textFieldValidator(value!);
//                   //   },
//                   // ),
//                   // SizedBox(height: 16),
//                   // TextFormField(
//                   //   controller: controller.phoneNumberController,
//                   //   keyboardType: TextInputType.phone,
//                   //   inputFormatters: [inputMasker.phoneMask],
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Phone Number',
//                   //     prefixIcon: Icon(Icons.phone_android),
//                   //     border: OutlineInputBorder(),
//                   //   ),
//                   //   validator: (value) {
//                   //     return Validator.phoneValidator(value!);
//                   //   },
//                   // ),
//                   // SizedBox(height: 16),
//                   // TextFormField(
//                   //   obscureText: true,
//                   //   controller: controller.passwordController,
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Password',
//                   //     prefixIcon: Icon(Icons.password_outlined),
//                   //     border: OutlineInputBorder(),
//                   //   ),
//                   //   validator: (value) {
//                   //     return Validator.passwordValidator(value!);
//                   //   },
//                   // ),
//                   // SizedBox(height: 16),
//                   // TextFormField(
//                   //   obscureText: true,
//                   //   controller: controller.cpasswordController,
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Confirm Password',
//                   //     prefixIcon: Icon(Icons.password_outlined),
//                   //     border: OutlineInputBorder(),
//                   //   ),
//                   //   validator: (value) {
//                   //     if (value == null || value.isEmpty) {
//                   //       return 'Confirm Password is required';
//                   //     }
//                   //     if (value != controller.passwordController.text) {
//                   //       return 'Passwords do not match';
//                   //     }
//                   //     return null;
//                   //   },
//                   // ),
//                   // SizedBox(height: 16),
//                   // ProgressButton(
//                   //   onPressed: () {
//                   //     _formKey.currentState!.validate();
//                   //     controller.signup(context);
//                   //   },
//                   //   isLoading: controller.isLoading.value,
//                   //   label: 'Signup',
//                   //   progressColor: Colors.white,
//                   //   textColor: Colors.white,
//                   //   backgroundColor: MyColors.secondary,
//                   //   borderColor: MyColors.secondary,
//                   // ),
//                   SizedBox(height: 16),
//                   Text.rich(
//                     TextSpan(
//                       text: 'By signing up you accept the ',
//                       style: TextStyle(fontSize: 12),
//                       children: [
//                         TextSpan(
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () => openUrl(),
//                           text: 'privacy policy',
//                           style: TextStyle(
//                             color: MyColors.secondary,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                         TextSpan(text: ' and terms of use'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> openUrl() async {
//     final url = Uri.parse(
//         "https://esicapps-files.s3.eu-west-2.amazonaws.com/privacy-policy/sr-privacy.html");
//     await launch(url.toString());
//   }
// }
