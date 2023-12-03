// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:icesspool/contants.dart';
// import 'package:icesspool/controllers/home_controller.dart';
// import 'package:icesspool/controllers/login_controller.dart';
// import 'package:icesspool/themes/colors.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:icesspool/views/about_view.dart';
// import 'package:icesspool/views/report_status_view.dart';

// import '../controllers/report_controller.dart';
// import '../core/validator.dart';
// import '../widgets/button.dart';
// import '../widgets/camera-button.dart';
// import '../widgets/custom-animated-bottom-bar.dart';
// import '../widgets/dropdown.dart';
// import '../widgets/text-box.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// class ReportView extends StatelessWidget {
//   final _controller = Get.put(HomeController());
//   final loginController = Get.put(LoginController());

// //   PersistentTabController persistentTabController;

// // persistentTabController = PersistentTabController(initialIndex: 0);

//   ReportView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _controller.formKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             // TextBox(
//             //   labelText: 'Enter your name',
//             // ),
//             // TextBox(
//             //   labelText: 'Enter your phone',
//             // ),
//             // Obx(
//             //   () => Dropdown(
//             //     onChangedCallback: (newValue) {
//             //       _controller.selectedRegion.value = newValue;
//             //       _controller.getDistricts();
//             //       _controller.districts.value = [];
//             //     },
//             //     value:
//             //         _controller.returnValue(_controller.selectedDistrict.value),
//             //     initialValue:
//             //         _controller.returnValue(_controller.selectedRegion.value),
//             //     dropdownItems: _controller.regions.map((var obj) {
//             //       return DropdownMenuItem<String>(
//             //         value: obj.id.toString(),
//             //         child: Text(obj.name.toString()),
//             //       );
//             //     }).toList(),
//             //     hintText: '',
//             //     labelText: "Select your region",
//             //   ),
//             // ),

//             // Obx(
//             //   () => Dropdown(
//             //     onChangedCallback: (newValue) {
//             //       _controller.selectedDistrict.value = newValue;
//             //     },
//             //     value: _controller
//             //         .returnValue(_controller.selectedDistrict.value),
//             //     initialValue: _controller
//             //         .returnValue(_controller.selectedDistrict.value),
//             //     dropdownItems: _controller.districts.map((var obj) {
//             //       return DropdownMenuItem<String>(
//             //         value: obj.id.toString(),
//             //         child: Text(obj.name.toString()),
//             //       );
//             //     }).toList(),
//             //     hintText: '',
//             //     labelText: "Select your district *",
//             //     validator: (value) {
//             //       return Validator.dropdownValidator(value);
//             //     },
//             //   ),
//             // ),

//             Obx(
//               () => Dropdown(
//                 onChangedCallback: (newValue) {
//                   _controller.selectedReportType.value = newValue;
//                   _controller.getAddressFromCoords();
//                 },
//                 value: _controller
//                     .returnValue(_controller.selectedReportType.value),
//                 initialValue: _controller
//                     .returnValue(_controller.selectedReportType.value),
//                 dropdownItems: [
//                   DropdownMenuItem(
//                     child: Text("I am at the location"),
//                     value: "1",
//                   ),
//                   DropdownMenuItem(
//                     child: Text("I am not at the location"),
//                     value: "2",
//                   ),
//                 ],
//                 hintText: '',
//                 labelText: "Select type of report *",
//                 validator: (value) {
//                   return Validator.dropdownValidator(value);
//                 },
//               ),
//             ),
//             Obx(() => Visibility(
//                   visible: _controller.selectedReportType == "1",
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     child: Text(
//                       "${_controller.address.value}",
//                       style:
//                           TextStyle(fontSize: 10, color: Colors.amber.shade700),
//                     ),
//                   ),
//                 )),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 child: InputDecorator(
//                   decoration: InputDecoration(
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//                     // errorText: widget.errorText,
//                     labelText: 'Search for district *',
//                     filled: true,
//                     fillColor: MyColors.White,

//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       //borderSide: BorderSide.none,
//                     ),
//                   ),
//                   child: Obx(
//                     () => DropdownSearch<String>(
//                       popupProps: PopupProps.menu(
//                         showSearchBox: true,
//                         showSelectedItems: true,
//                         // disabledItemFn: (String s) => s.startsWith('I'),
//                       ),
//                       items: _controller.districts
//                           .map((element) => element.name)
//                           .toList(),
//                       dropdownDecoratorProps: DropDownDecoratorProps(
//                         dropdownSearchDecoration: InputDecoration(
//                           labelText: "",
//                           hintText: "Select your MMDA",
//                         ),
//                       ),
//                       onChanged: (value) {
//                         _controller.selectedDistrict.value = value.toString();
//                         _controller.selectedDistrictId.value =
//                             _controller.getItemId(value);
//                       },
//                       selectedItem: _controller.selectedDistrict.value,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             TextBox(
//               controller: _controller.communityController,
//               labelText: 'Community & Landmark*',
//               maxLength: 50,
//               validator: (value) {
//                 return Validator.textFieldValidator(value);
//               },
//             ),

//             Obx(
//               () => Dropdown(
//                 onChangedCallback: (newValue) {
//                   _controller.selectedReportCategory.value = newValue;
//                 },
//                 value: _controller
//                     .returnValue(_controller.selectedReportCategory.value),
//                 initialValue: _controller
//                     .returnValue(_controller.selectedReportCategory.value),
//                 dropdownItems: _controller.reportCategories.map((var obj) {
//                   return DropdownMenuItem<String>(
//                     child: Text(obj.name.toString()),
//                     value: obj.id.toString(),
//                   );
//                 }).toList(),
//                 hintText: '',
//                 labelText: "Select category of report *",
//                 validator: (value) {
//                   return Validator.dropdownValidator(value);
//                 },
//               ),
//             ),
//             TextBox(
//                 controller: _controller.descriptionController,
//                 labelText: 'Description of nuisance *',
//                 maxLines: 3,
//                 validator: (value) {
//                   return Validator.textFieldValidator(value);
//                 },
//                 maxLength: 120),
//             Obx(
//               () => Visibility(
//                 maintainState: false,
//                 visible: _controller.selectedReportType.value == "1",
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CameraButton(
//                     onPressed: () {
//                       _controller.getImage(ImageSource.camera);
//                     },
//                     text: "Capture picture from camera *",
//                     icon: Icon(Icons.camera_alt_outlined),
//                   ),
//                 ),
//               ),
//             ),
//             Obx(() => Visibility(
//                   maintainState: false,
//                   visible: _controller.selectedReportType.value == "2",
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: CameraButton(
//                       onPressed: () {
//                         _controller.getImage(ImageSource.gallery);
//                       },
//                       text: "Add a picture from gallery *",
//                       icon: Icon(Icons.photo),
//                     ),
//                   ),
//                 )),
//             Obx(() => Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Visibility(
//                     maintainSize: false,
//                     visible: _controller.selectedImagePath.value != "",
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12.0),
//                       child: Image.file(
//                         File(_controller.selectedImagePath.value),
//                       ),
//                     ),
//                   ),
//                 )),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Obx(() => Button(
//                     onPressed: () {
//                       _controller.sendReport();
//                       // _controller.getDistricts();
//                     },
//                     showLoading: _controller.isLoading.value,
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   showLoaderDialog(BuildContext context) {
//     AlertDialog alert = AlertDialog(
//       content: new Row(
//         children: [
//           CircularProgressIndicator(),
//           Container(
//             margin: EdgeInsets.only(left: 2),
//             child: Obx(
//               () => Text(
//                 "Submitting",
//                 style: TextStyle(fontSize: 11),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
