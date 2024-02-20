// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:icesspool/controllers/home_controller.dart';
// import 'package:icesspool/themes/colors.dart';
// import 'package:icesspool/widgets/progress-outline-button.dart';
// import 'package:icesspool/widgets/text-box.dart';

// import '../widgets/progress-outline-icon-button.dart';

// class AccountView extends StatelessWidget {
//   final controller = Get.put(HomeController());

//   AccountView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Account")),
//       body: Card(
//         child: Container(
//             child: Obx(
//           () => ListView(
//             children: [
//               // getImageAsset("assets/images/logo.png", 105.0),
//               Container(
//                   child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                     style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 16,
//                     ),
//                     '''User Account Details'''),
//               )),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Obx(() {
//                       return TextBox(
//                         initialValue: controller.firstName.value,
//                         labelText: "First name",
//                       );
//                     }),
//                   ),
//                   Expanded(
//                     child: Obx(() => TextBox(
//                           initialValue: controller.lastName.value,
//                           labelText: "Last name",
//                         )),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Obx(() => TextBox(
//                     initialValue: controller.phoneNumber.value,
//                     labelText: "Phone number",
//                   )),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ProgressOutlineIconButton(
//                     primaryColor: MyColors.primary,
//                     onPressed: () {
//                       controller.logout();
//                     },
//                     isLoading: controller.isLoading.value,
//                     iconData: Icons.logout_sharp,
//                     label: "Logout"),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Divider(),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   "Press on the button below to delete your account and every associated data",
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ProgressOutlineIconButton(
//                     primaryColor: Colors.red,
//                     onPressed: () {
//                       controller.logout();
//                     },
//                     isLoading: controller.isLoading.value,
//                     iconData: Icons.delete_forever_outlined,
//                     label: "Delete Account"),
//               ),
//               Center(
//                   child:
//                       Obx(() => Text("App name: ${controller.AppName.value}"))),
//               Center(
//                   child: Obx(() =>
//                       Text("App version: ${controller.AppVersion.value}")))
//             ],
//           ),
//         )),
//       ),
//     );
//   }

//   Widget getImageAsset(path, size) {
//     AssetImage assetImage = AssetImage(path);
//     Image image = Image(
//       image: assetImage,
//       width: size,
//       height: size,
//     );
//     return Container(
//       child: image,
//       margin: EdgeInsets.all(5),
//     );
//   }
// }
