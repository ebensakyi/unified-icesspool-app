import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icesspool/views/emptying_main_view.dart';
import 'package:icesspool/views/water_main_view.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:icesspool/widgets/progress-outline-button.dart';
import 'package:icesspool/widgets/service-widget.dart';

import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';

import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/request_controller.dart';

import 'biodigester_main_view.dart';

class RequestView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final controller = Get.put(RequestController());
  final homeController = Get.put(HomeController());

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.635264, -0.188335),
    zoom: 12,
    tilt: 59.440717697143555,
    bearing: 12.8334901395799,
  );

//  static CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(homeController.latitude.value, homeController.longitude.value),
//     zoom: 12,
//     tilt: 59.440717697143555,
//     bearing: 12.8334901395799,
//   );

  RequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomSheet: InteractiveBottomSheet(
            options: InteractiveBottomSheetOptions(
                expand: false,
                maxSize: 0.8,
                initialSize: controller.initialSize.value,
                minimumSize: 0.3),
            child: controller.transactionStatus.value == 1
                ? searchingForSP(context)
                : controller.transactionStatus.value == 2
                    ? spFound(context)
                    : controller.transactionStatus.value == 2
                        ? searchingForSP(context)
                        : servicesView(),
            draggableAreaOptions: DraggableAreaOptions(
              //topBorderRadius: 20,
              // height: 75,
              // backgroundColor: Colors.grey,
              indicatorColor: Color.fromARGB(255, 230, 230, 230),
              indicatorWidth: 40,
              indicatorHeight: 5,
              indicatorRadius: 10,
            ),
          ),
          body: GoogleMap(
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            // onMapCreated: (GoogleMapController controller) {
            //   _controller.complete(controller);
            // },
            onMapCreated: controller.onMapCreated,
            markers: Set<Marker>.of(controller.markers.values),
          ),
        ));

    // GoogleMap(
    //   mapType: MapType.hybrid,
    //   initialCameraPosition: _kGooglePlex,
    //   onMapCreated: (GoogleMapController controller) {
    //     _controller.complete(controller);
    //   },
    // );
  }

  Widget transactionHistory() {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {
                  // print(data[index]);
                },
                title: Text("data[index].name"),
                leading: Icon(Icons.history),
                // leading: CircleAvatar(
                //   backgroundImage: AssetImage('assets/${data[index].avatar}'),
                // ),
              ),
            ),
          );
        });
  }

  Widget searchingForSP(context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/searching.svg',
                        height: 200, semanticsLabel: 'Searching'),
                    // CircularProgressIndicator(
                    //   valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                    // ),
                    // SizedBox(width: 16.0),
                    Text(
                      'Looking for a service provider',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Connecting to available service providers',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black54),
                    ),
                    // GifController _controller = GifController(vsync: this);
                    SizedBox(width: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        minHeight: 10,
                        backgroundColor: Colors
                            .grey[200], // Background color of the progress bar
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.teal), // Color of the progress indicator
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ProgressOutlineButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              String contentText =
                                  "Are you sure you want to cancel this request?";
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: Text("Cancel Request"),
                                    content: Text(contentText),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.cancelRequest();
                                          Navigator.pop(context);
                                          // setState(() {
                                          //   contentText =
                                          //       "Changed Content of Dialog";
                                          // });
                                        },
                                        child: Text("Ok"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        isLoading: controller.isLoading.value,
                        iconData: Icons.cancel_outlined,
                        label: "Cancel",
                        primaryColor: Colors.red)
                    // ProgressButton(
                    //   onPressed: () {
                    //     controller.cancelRequest("controller.transactionId");
                    //   },
                    //   isLoading: controller.isLoading.value,
                    //   iconData: Icons.cancel_outlined,
                    //   label: 'Cancel',
                    //   iconColor: Colors.white,
                    //   progressColor: Colors.white,
                    //   textColor: Colors.white,
                    //   backgroundColor: controller.isLoading.value
                    //       ? Colors.teal
                    //       : Colors.teal,
                    //   borderColor: Colors.teal,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spFound(context) {
    //SP found, show details of sp with image make payment
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Service Provider found',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SvgPicture.asset('assets/images/payment.svg',
                        height: 200, semanticsLabel: 'Searching'),

                    SizedBox(height: 20.0),
                    Text(
                      'Make payment to confirm the job.',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black54),
                    ),
                    SizedBox(height: 10.0),

                    Text(
                      'Job will automatically be cancelled if payment is not done within the expiry time',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                    // GifController _controller = GifController(vsync: this);
                    SizedBox(height: 20.0),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: LinearProgressIndicator(
                    //     minHeight: 10,
                    //     backgroundColor: Colors
                    //         .grey[200], // Background color of the progress bar
                    //     valueColor: AlwaysStoppedAnimation<Color>(
                    //         Colors.teal), // Color of the progress indicator
                    //   ),
                    // ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: buildListTile(
                              'Fee', 'GHS ${controller.amount.value}'),
                        ),
                        // Expanded(
                        //   child: buildListTile('Wait Time', '10 minutes'),
                        // ),
                        Expanded(
                          child: ListTile(
                            //leading: Icon(Icons.history_toggle_off),
                            leading: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.teal,
                              ),
                            ),
                            title: Text(
                              "Expires in",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Obx(() {
                              return Text(
                                controller.formatDuration(
                                    controller.countdownDuration.value),
                                // style: TextStyle(fontSize: 24),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProgressButton(
                          onPressed: () {
                            controller.initiateTellerPayment();
                          },
                          isLoading: controller.isLoading.value,
                          iconData: Icons.payment_sharp,
                          label: 'Pay',
                          iconColor: Colors.white,
                          progressColor: Colors.white,
                          textColor: Colors.white,
                          backgroundColor: controller.isLoading.value
                              ? Colors.teal
                              : Colors.teal,
                          borderColor: Colors.teal,
                        ),
                        ProgressOutlineButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String contentText =
                                      "Are you sure you want to cancel this request?";
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: Text("Cancel Request"),
                                        content: Text(contentText),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.cancelRequest();
                                              Navigator.pop(context);
                                              // setState(() {
                                              //   contentText =
                                              //       "Changed Content of Dialog";
                                              // });
                                            },
                                            child: Text("Ok"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            isLoading: controller.isLoading.value,
                            iconData: Icons.cancel_outlined,
                            label: "Cancel",
                            primaryColor: Colors.red)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value),
    );
  }

  Widget servicesView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() {
              return Expanded(
                child: ServiceWidget(
                  isAvailable: homeController.biodigesterServiceAvailable.value,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: 'Biodigester',
                  subTitle: 'Service or build a new biodigester',
                  onTap: openBioDigesterMainView,
                ),
              );
            }),
            Obx(() {
              return Expanded(
                child: ServiceWidget(
                  isAvailable: homeController.emptyingServiceAvailable.value,
                  path: "assets/images/toilet-tanker.png",
                  size: 32,
                  title: 'Septic Tank',
                  subTitle: 'Empty your Septic tank',
                  onTap: openTankerMainView,
                ),
              );
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() {
              return Expanded(
                child: ServiceWidget(
                  isAvailable: homeController.waterServiceAvailable.value,
                  path: "assets/images/water-tanker.png",
                  size: 32,
                  title: 'Tanker Water',
                  subTitle: 'Request for bulk water',
                  onTap: openWaterMainView,
                ),
              );
            }),
            Expanded(
              child: ServiceWidget(
                isAvailable: true,
                path: "assets/images/more.png",
                size: 32,
                title: 'Read More',
                subTitle: 'Read more about our services',
              ),
            ),
          ],
        ),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            'Biodigester',
            style: TextStyle(fontSize: 12),
          ),
          leading: Icon(Icons.history),
          subtitle: Text(
            'Dansoman - 21/11/2023',
            style: TextStyle(fontSize: 10),
          ),
        ),
        Divider(),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            'Tanker Water',
            style: TextStyle(fontSize: 12),
          ),
          leading: Icon(Icons.history),
          subtitle: Text(
            'Sowutuom - 11/01/2023',
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
// Widget stepperUI(context) {
//   final controller = Get.put(HomeController());
//   final formKey1 = new GlobalKey<FormState>();
//   final formKey2 = new GlobalKey<FormState>();
//   final formKey3 = new GlobalKey<FormState>();

//   return Obx(
//     () => Stepper(
//       type: MediaQuery.of(context).orientation == Orientation.portrait
//           ? StepperType.vertical
//           : StepperType.horizontal,
//       physics: const ScrollPhysics(),
//       currentStep: controller.currentStep.value,
//       onStepTapped: (step) => controller.tapped(step),
//       onStepContinue: controller.continued,
//       onStepCancel: controller.cancel,
//       controlsBuilder: (context, _) {
//         return Row(
//           children: <Widget>[
//             controller.currentStep == 0
//                 ? Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: MyColors.MainColor,
//                           borderRadius: BorderRadius.circular(6)),
//                       height: 35,
//                       child: TextButton(
//                         onPressed: () {
//                           if (formKey1.currentState!.validate())
//                             controller.continued();
//                         },
//                         child: Text(
//                           'Continue',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )
//                 : controller.currentStep == 1
//                     ? Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: MyColors.MainColor,
//                               borderRadius: BorderRadius.circular(6)),
//                           height: 35,
//                           child: TextButton(
//                             onPressed: () {
//                               if (formKey2.currentState!.validate())
//                                 controller.continued();
//                             },
//                             child: Text(
//                               'Continue',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       )
//                     : controller.isLoading.value
//                         ? Obx(() => Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Visibility(
//                                 visible: controller.isLoading.value,
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ))
//                         : Obx(() => Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: MyColors.MainColor,
//                                     borderRadius: BorderRadius.circular(6)),
//                                 height: 35,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     controller.sendReport();
//                                   },
//                                   child: Text(
//                                     'Submit Report',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             )),
//             Container(
//               decoration: BoxDecoration(
//                   // color: Colors.indigo,
//                   border: Border.all(color: MyColors.SecondaryColor),
//                   borderRadius: BorderRadius.circular(6)),
//               height: 34,
//               child: TextButton(
//                 onPressed: () {
//                   controller.cancel();
//                 },
//                 child: const Text(
//                   'Cancel',
//                   style: TextStyle(color: MyColors.SecondaryColor),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//       steps: <Step>[
//         Step(
//           subtitle: Text('Enter location info here'),
//           title: const Text('Location Info'),
//           content: Form(
//             key: formKey1,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: Column(
//               children: <Widget>[
//                 Obx(
//                   () => Dropdown(
//                     onChangedCallback: (newValue) {
//                       controller.selectedReportType.value = newValue;
//                       controller.getAddressFromCoords();
//                     },
//                     value: controller
//                         .returnValue(controller.selectedReportType.value),
//                     initialValue: controller
//                         .returnValue(controller.selectedReportType.value),
//                     dropdownItems: [
//                       DropdownMenuItem(
//                         child: Text("I am at the location"),
//                         value: "1",
//                       ),
//                       DropdownMenuItem(
//                         child: Text("I am at a diff. location"),
//                         value: "2",
//                       ),
//                     ],
//                     hintText: '',
//                     labelText: "Where are you reporting from? *",
//                     validator: (value) {
//                       return Validator.dropdownValidator(value);
//                     },
//                   ),
//                 ),
//                 Obx(() => Visibility(
//                       visible: controller.selectedReportType == "1",
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 16),
//                         child: Text(
//                           "${controller.address.value}",
//                           style: TextStyle(
//                               fontSize: 10, color: Colors.amber.shade700),
//                         ),
//                       ),
//                     )),
//                 TextBox(
//                   controller: controller.communityController,
//                   labelText: 'Community & Landmark*',
//                   maxLength: 50,
//                   validator: (value) {
//                     return Validator.textFieldValidator(value);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           isActive: controller.currentStep >= 0,
//           state: controller.currentStep >= 0
//               ? StepState.complete
//               : StepState.disabled,
//         ),
//         Step(
//           title: new Text(
//             'Report details',
//           ),
//           subtitle: Text('Enter report here'),
//           content: Form(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             key: formKey2,
//             child: Column(
//               children: <Widget>[
//                 // Obx(
//                 //   () => Dropdown(
//                 //     onChangedCallback: (newValue) {
//                 //       controller.selectedReportCategory.value = newValue;
//                 //     },
//                 //     value: controller
//                 //         .returnValue(controller.selectedReportCategory.value),
//                 //     initialValue: controller
//                 //         .returnValue(controller.selectedReportCategory.value),
//                 //     dropdownItems: controller.reportCategories.map((var obj) {
//                 //       return DropdownMenuItem<String>(
//                 //         child: Text(obj.name.toString()),
//                 //         value: obj.id.toString(),
//                 //       );
//                 //     }).toList(),
//                 //     hintText: '',
//                 //     labelText: "Select category of report *",
//                 //     validator: (value) {
//                 //       return Validator.dropdownValidator(value);
//                 //     },
//                 //   ),
//                 // ),
//                 TextBox(
//                     controller: controller.descriptionController,
//                     labelText: 'Description of nuisance ',
//                     maxLines: 3,
//                     // validator: (value) {
//                     //   return Validator.textFieldValidator(value);
//                     // },
//                     maxLength: 120),
//               ],
//             ),
//           ),
//           isActive: controller.currentStep >= 0,
//           state: controller.currentStep >= 1
//               ? StepState.complete
//               : StepState.disabled,
//         ),
//         // Step(
//         //   title: new Text('Item & other detais'),
//         //   content: Column(
//         //     children: <Widget>[

//         //     ],
//         //   ),
//         //   isActive: _currentStep >= 0,
//         //   state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
//         // ),
//         Step(
//           title: new Text('Choose Picture'),
//           subtitle: Text('Capture or select image here'),
//           content: Column(
//             children: [
//               // Obx(
//               //   () => Visibility(
//               //     maintainState: false,
//               //     visible: controller.selectedReportType.value == "1",
//               //     child: Padding(
//               //       padding: const EdgeInsets.all(8.0),
//               //       child: CameraButton(
//               //         onPressed: () {
//               //           controller.getImage(ImageSource.camera);
//               //         },
//               //         text: "Capture picture from camera *",
//               //         icon: Icon(Icons.camera_alt_outlined),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               // Obx(() => Visibility(
//               //       maintainState: false,
//               //       visible: controller.selectedReportType.value == "2",
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(16.0),
//               //         child: CameraButton(
//               //           onPressed: () {
//               //             controller.getImage(ImageSource.gallery);
//               //           },
//               //           text: "Add a picture from gallery *",
//               //           icon: Icon(Icons.photo),
//               //         ),
//               //       ),
//               //     )),
//               Obx(() => Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Visibility(
//                       maintainSize: false,
//                       visible: controller.selectedImagePath.value != "",
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12.0),
//                         child: Image.file(
//                           File(controller.selectedImagePath.value),
//                         ),
//                       ),
//                     ),
//                   )),
//             ],
//           ),
//           isActive: controller.currentStep >= 0,
//           state: controller.currentStep >= 2
//               ? StepState.complete
//               : StepState.disabled,
//         ),
//       ],
//     ),
//   );
// }
// int currentStep = 0;
// bool completed = false;

openBioDigesterMainView() {
  return Get.to(() => BioDigesterMainView());
}

openTankerMainView() {
  return Get.to(() => EmptyingMainView());
}

openWaterMainView() {
  return Get.to(() => WaterMainView());
}
