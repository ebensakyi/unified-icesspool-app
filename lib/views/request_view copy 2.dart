// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:icesspool/views/emptying_main_view.dart';
// import 'package:icesspool/views/water_main_view.dart';
// import 'package:icesspool/widgets/progress-button.dart';
// import 'package:icesspool/widgets/progress-outline-button.dart';
// import 'package:icesspool/widgets/service-widget.dart';

// import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';

// import '../controllers/home_controller.dart';
// import '../controllers/login_controller.dart';
// import '../controllers/request_controller.dart';

// import 'biodigester_main_view.dart';

// class RequestView extends StatelessWidget {
//   final loginController = Get.put(LoginController());
//   final controller = Get.put(RequestController());
//   final homeController = Get.put(HomeController());

//   // final Completer<GoogleMapController> _controller =
//   //     Completer<GoogleMapController>();

//   static CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(5.635264, -0.188335),
//     zoom: 12,
//     tilt: 59.440717697143555,
//     bearing: 12.8334901395799,
//   );

// //  static CameraPosition _kGooglePlex = CameraPosition(
// //     target: LatLng(homeController.latitude.value, homeController.longitude.value),
// //     zoom: 12,
// //     tilt: 59.440717697143555,
// //     bearing: 12.8334901395799,
// //   );

//   RequestView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     log("REBUILDED");
//     return Scaffold(
//       bottomSheet: InteractiveBottomSheet(
//         options: InteractiveBottomSheetOptions(
//             expand: false,
//             maxSize: 0.8,
//             initialSize: controller.initialSize.value,
//             minimumSize: 0.3),
//         child: Column(
//           children: [
//             servicesView(),
//             searchingForSP(context),
//             spFound(context),
//             orderInPlace(context),
//             searchingForDifferentSP(context)
//           ],
//         ),

//         //  controller.transactionStatus.value == 1
//         //     ? searchingForSP(context)
//         //     : controller.transactionStatus.value == 2
//         //         ? spFound(context)
//         //         : controller.transactionStatus.value == 3
//         //             ? searchingForSP(context)
//         //             : servicesView(),
//         draggableAreaOptions: DraggableAreaOptions(
//           //topBorderRadius: 20,
//           // height: 75,
//           // backgroundColor: Colors.grey,
//           indicatorColor: Color.fromARGB(255, 230, 230, 230),
//           indicatorWidth: 40,
//           indicatorHeight: 5,
//           indicatorRadius: 10,
//         ),
//       ),
//       body: GoogleMap(
//         mapToolbarEnabled: true,
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         // onMapCreated: (GoogleMapController controller) {
//         //   _controller.complete(controller);
//         // },
//         onMapCreated: controller.onMapCreated,
//         markers: Set<Marker>.of(controller.markers.values),
//       ),
//     );

//     // GoogleMap(
//     //   mapType: MapType.hybrid,
//     //   initialCameraPosition: _kGooglePlex,
//     //   onMapCreated: (GoogleMapController controller) {
//     //     _controller.complete(controller);
//     //   },
//     // );
//   }

//   Widget transactionHistory() {
//     return ListView.builder(
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
//             child: Card(
//               child: ListTile(
//                 onTap: () {
//                   // print(data[index]);
//                 },
//                 title: Text("data[index].name"),
//                 leading: Icon(Icons.history),
//                 // leading: CircleAvatar(
//                 //   backgroundImage: AssetImage('assets/${data[index].avatar}'),
//                 // ),
//               ),
//             ),
//           );
//         });
//   }

//   Widget orderInPlace(context) {
//     return Obx(
//       () => Visibility(
//         visible: controller.transactionStatus.value == 3 &&
//             controller.customerHasTransaction.value,
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   // color: MyColors.primary.shade100,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         SvgPicture.asset('assets/images/job-progress.svg',
//                             height: 200, semanticsLabel: 'In progress'),
//                         // CircularProgressIndicator(
//                         //   valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
//                         // ),
//                         // SizedBox(width: 16.0),
//                         Text(
//                           'Service provider is on the way',
//                           style: TextStyle(
//                               fontSize: 20.0, fontWeight: FontWeight.bold),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             'Hold on the service provider is on the way.You can call the Service provider',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black54),
//                           ),
//                         ),
//                         // GifController _controller = GifController(vsync: this);
//                         SizedBox(width: 20.0),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: LinearProgressIndicator(
//                             minHeight: 10,
//                             backgroundColor: Colors.grey[
//                                 200], // Background color of the progress bar
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                                 MyColors.primary), // Color of the progress indicator
//                           ),
//                         ),
//                         SizedBox(height: 20.0),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget searchingForSP(context) {
//     log(controller.transactionStatus.value.toString());

//     return Obx(
//       () => Visibility(
//         visible: controller.transactionStatus.value == 1 &&
//             controller.customerHasTransaction.value,
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   // color: MyColors.primary.shade100,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         SvgPicture.asset('assets/images/searching.svg',
//                             height: 200, semanticsLabel: 'Searching'),
//                         // CircularProgressIndicator(
//                         //   valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
//                         // ),
//                         // SizedBox(width: 16.0),
//                         Text(
//                           'Locating your Service Provider',
//                           style: TextStyle(
//                               fontSize: 20.0, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 16.0),
//                         Text(
//                           'Connecting to available service providers',
//                           style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black54),
//                         ),
//                         // GifController _controller = GifController(vsync: this);
//                         SizedBox(width: 20.0),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: LinearProgressIndicator(
//                             minHeight: 10,
//                             backgroundColor: Colors.grey[
//                                 200], // Background color of the progress bar
//                             valueColor: AlwaysStoppedAnimation<Color>(Colors
//                                 .amber), // Color of the progress indicator
//                           ),
//                         ),
//                         SizedBox(height: 20.0),
//                         ProgressOutlineButton(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   String contentText =
//                                       "Are you sure you want to cancel this request?";
//                                   return StatefulBuilder(
//                                     builder: (context, setState) {
//                                       return AlertDialog(
//                                         title: Text("Cancel Request"),
//                                         content: Text(contentText),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             onPressed: () =>
//                                                 Navigator.pop(context),
//                                             child: Text("Cancel"),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               controller.cancelRequest();
//                                               Navigator.pop(context);
//                                               // setState(() {
//                                               //   contentText =
//                                               //       "Changed Content of Dialog";
//                                               // });
//                                             },
//                                             child: Text("Ok"),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                             isLoading: controller.isLoading.value,
//                             iconData: Icons.cancel_outlined,
//                             label: "Cancel",
//                             primaryColor: Colors.red)
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget searchingForDifferentSP(context) {
//     return Obx(
//       () => Visibility(
//         visible: controller.transactionStatus.value == 7 &&
//             controller.customerHasTransaction.value,
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   // color: MyColors.primary.shade100,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         SvgPicture.asset('assets/images/searching.svg',
//                             height: 200, semanticsLabel: 'Searching'),
//                         // CircularProgressIndicator(
//                         //   valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
//                         // ),
//                         // SizedBox(width: 16.0),
//                         Text(
//                           'Locating another Service Provider',
//                           style: TextStyle(
//                               fontSize: 20.0, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 16.0),

//                         Text(
//                           'Sorry the SP cancelled transaction. We are connecting you to another service providers',
//                           style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black54),
//                         ),
//                         // GifController _controller = GifController(vsync: this);
//                         SizedBox(width: 50.0),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: LinearProgressIndicator(
//                             minHeight: 10,
//                             backgroundColor: Colors.grey[
//                                 200], // Background color of the progress bar
//                             valueColor: AlwaysStoppedAnimation<Color>(Colors
//                                 .amber), // Color of the progress indicator
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget spFound(context) {
//     //SP found, show details of sp with image make payment
//     return Obx(
//       () => Visibility(
//         visible: controller.transactionStatus.value == 2 &&
//             controller.customerHasTransaction.value,
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   // color: MyColors.primary.shade100,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Service Provider found',
//                           style: TextStyle(
//                               fontSize: 20.0, fontWeight: FontWeight.bold),
//                         ),
//                         SvgPicture.asset('assets/images/payment.svg',
//                             height: 200, semanticsLabel: 'Searching'),

//                         SizedBox(height: 20.0),
//                         Text(
//                           'Make payment to confirm the job.',
//                           style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black54),
//                         ),
//                         SizedBox(height: 10.0),

//                         Text(
//                           'Job will automatically be cancelled if payment is not done within the expiry time',
//                           style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black),
//                         ),
//                         // GifController _controller = GifController(vsync: this);
//                         SizedBox(height: 20.0),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: LinearProgressIndicator(
//                         //     minHeight: 10,
//                         //     backgroundColor: Colors
//                         //         .grey[200], // Background color of the progress bar
//                         //     valueColor: AlwaysStoppedAnimation<Color>(
//                         //         MyColors.primary), // Color of the progress indicator
//                         //   ),
//                         // ),
//                         Divider(),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: buildListTile(
//                                   'Fee', 'GHS ${controller.amount.value}'),
//                             ),
//                             // Expanded(
//                             //   child: buildListTile('Wait Time', '10 minutes'),
//                             // ),
//                             Expanded(
//                               child: ListTile(
//                                 //leading: Icon(Icons.history_toggle_off),
//                                 leading: SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: MyColors.primary,
//                                   ),
//                                 ),
//                                 title: Text(
//                                   "Expires in",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 subtitle: Obx(() {
//                                   return Text(
//                                     controller.formatDuration(
//                                         controller.countdownDuration.value),
//                                     // style: TextStyle(fontSize: 24),
//                                   );
//                                 }),
//                               ),
//                             )
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ProgressButton(
//                               onPressed: () {
//                                 controller.initiateTellerPayment();
//                               },
//                               isLoading: controller.isLoading.value,
//                               iconData: Icons.payment_sharp,
//                               label: 'Pay',
//                               iconColor: Colors.white,
//                               progressColor: Colors.white,
//                               textColor: Colors.white,
//                               backgroundColor: controller.isLoading.value
//                                   ? MyColors.primary
//                                   : MyColors.primary,
//                               borderColor: MyColors.primary,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             ProgressOutlineButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       String contentText =
//                                           "Are you sure you want to cancel this request?";
//                                       return StatefulBuilder(
//                                         builder: (context, setState) {
//                                           return AlertDialog(
//                                             title: Text("Cancel Request"),
//                                             content: Text(contentText),
//                                             actions: <Widget>[
//                                               TextButton(
//                                                 onPressed: () =>
//                                                     Navigator.pop(context),
//                                                 child: Text("Cancel"),
//                                               ),
//                                               TextButton(
//                                                 onPressed: () {
//                                                   controller.cancelRequest();
//                                                   Navigator.pop(context);
//                                                   // setState(() {
//                                                   //   contentText =
//                                                   //       "Changed Content of Dialog";
//                                                   // });
//                                                 },
//                                                 child: Text("Ok"),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                                 isLoading: controller.isLoading.value,
//                                 iconData: Icons.cancel_outlined,
//                                 label: "Cancel",
//                                 primaryColor: Colors.red)
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildListTile(String title, String value) {
//     return ListTile(
//       title: Text(
//         title,
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(value),
//     );
//   }

//   Widget servicesView() {
//     return Obx(() => Visibility(
//           visible: controller.transactionStatus.value == 0,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Obx(() {
//                     return Expanded(
//                       child: ServiceWidget(
//                         isAvailable:
//                             homeController.biodigesterServiceAvailable.value,
//                         path: "assets/images/biodigester.png",
//                         size: 32,
//                         title: 'Biodigester',
//                         subTitle: 'Service or build a new biodigester',
//                         onTap: openBioDigesterMainView,
//                       ),
//                     );
//                   }),
//                   Obx(() {
//                     return Expanded(
//                       child: ServiceWidget(
//                         isAvailable:
//                             homeController.emptyingServiceAvailable.value,
//                         path: "assets/images/toilet-tanker.png",
//                         size: 32,
//                         title: 'Septic Tank',
//                         subTitle: 'Empty your Septic tank',
//                         onTap: openTankerMainView,
//                       ),
//                     );
//                   }),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Obx(() {
//                     return Expanded(
//                       child: ServiceWidget(
//                         isAvailable: homeController.waterServiceAvailable.value,
//                         path: "assets/images/water-tanker.png",
//                         size: 32,
//                         title: 'Tanker Water',
//                         subTitle: 'Request for bulk water',
//                         onTap: openWaterMainView,
//                       ),
//                     );
//                   }),
//                   Expanded(
//                     child: ServiceWidget(
//                       isAvailable: true,
//                       path: "assets/images/more.png",
//                       size: 32,
//                       title: 'Read More',
//                       subTitle: 'Read more about our services',
//                     ),
//                   ),
//                 ],
//               ),
//               ListTile(
//                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
//                 title: Text(
//                   'Biodigester',
//                   style: TextStyle(fontSize: 12),
//                 ),
//                 leading: Icon(Icons.history),
//                 subtitle: Text(
//                   'Dansoman - 21/11/2023',
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ),
//               Divider(),
//               ListTile(
//                 visualDensity: VisualDensity(horizontal: 0, vertical: -4),
//                 title: Text(
//                   'Tanker Water',
//                   style: TextStyle(fontSize: 12),
//                 ),
//                 leading: Icon(Icons.history),
//                 subtitle: Text(
//                   'Sowutuom - 11/01/2023',
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// openBioDigesterMainView() {
//   return Get.to(() => BioDigesterMainView());
// }

// openTankerMainView() {
//   return Get.to(() => EmptyingMainView());
// }

// openWaterMainView() {
//   return Get.to(() => WaterMainView());
// }
