import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icesspool/app/modules/login/controllers/login_controller.dart';
import 'package:icesspool/app/modules/services/views/services_view.dart';
import 'package:icesspool/contants.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/emptying_main_view.dart';
import 'package:icesspool/views/water_main_view.dart';
import 'package:icesspool/widgets/question-card.dart';
import 'package:icesspool/widgets/service-widget.dart';
import 'package:icesspool/widgets/small-button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';

import '../controllers/home_controller.dart';
import '../controllers/request_controller.dart';

import '../widgets/progress-icon-button.dart';
import '../widgets/progress-outline-icon-button.dart';
import 'biodigester_main_view.dart';

class RequestView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final controller = Get.put(RequestController());
  final homeController = Get.put(HomeController());

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  late GoogleMapController mapController;

//  static CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(homeController.latitude.value, homeController.longitude.value),
//     zoom: 12,
//     tilt: 59.440717697143555,
//     bearing: 12.8334901395799,
//   );

  RequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: InteractiveBottomSheet(
        options: InteractiveBottomSheetOptions(
            expand: false,
            maxSize: .9,
            initialSize: 0.8, // controller.initialSize.value,
            minimumSize: 0.5),
        child: Obx(() => Column(
              children: [
                !controller.customerHasTransaction.value
                    ? servicesView()
                    : Column(
                        children: [
                          controller.transactionStatus.value == 1
                              ? searchingForSP(context)
                              : controller.transactionStatus.value == 2
                                  ? spFound(context)
                                  : controller.transactionStatus.value == 3
                                      ? orderInPlace(context)
                                      : controller.transactionStatus.value == 9
                                          ? orderInPlace(context)
                                          : controller.transactionStatus
                                                      .value ==
                                                  12
                                              ? searchingForDifferentSP(context)
                                              : controller.transactionStatus
                                                          .value ==
                                                      14
                                                  ? workStarted(context)
                                                  : controller.transactionStatus
                                                              .value ==
                                                          15
                                                      ? rateSp(context)
                                                      : servicesView()
                        ],
                      ),
              ],
            )),

        //  controller.transactionStatus.value == 1
        //     ? searchingForSP(context)
        //     : controller.transactionStatus.value == 2
        //         ? spFound(context)
        //         : controller.transactionStatus.value == 3
        //             ? searchingForSP(context)
        //             : servicesView(),
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
      body: Obx(
        () {
          final LatLng? currentLocation = controller.currentLocation.value;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLocation ?? LatLng(5.700004, -0.222509),
              zoom: 15,
            ),
            onMapCreated: controller.onMapCreated,
            markers: currentLocation != null
                ? Set<Marker>.of([
                    Marker(
                      markerId: MarkerId('currentLocation'),
                      position: currentLocation,
                      infoWindow: InfoWindow(
                        title: 'Current Location',
                      ),
                    ),
                  ])
                : Set<Marker>(),
          );
        },
      ),
    );
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

  Widget orderInPlace(context) {
    return Obx(
      () => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                // color: MyColors.primary.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/images/job-progress.svg',
                          height: 150, semanticsLabel: 'In progress'),
                      // CircularProgressIndicator(
                      //   valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
                      // ),
                      // SizedBox(width: 16.0),
                      Text(
                        'Service provider is on the way',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Hold on the service provider is on the way.You can call the Service provider',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                      ),

                      // GifController _controller = GifController(vsync: this);
                      SizedBox(width: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          backgroundColor: Colors.grey[
                              200], // Background color of the progress bar
                          valueColor: AlwaysStoppedAnimation<Color>(MyColors
                              .primary), // Color of the progress indicator
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  "${Constants.AWS_S3_URL}${controller.spImageUrl.value}"),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.spName.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                              Text(
                                controller.spCompany.value,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SmallButton(
                        onPressed: () {
                          controller.openPhoneDialer();
                        },
                        showLoading: false,
                        label: IconButton(
                          icon: Icon(Icons.call),
                          onPressed: () {
                            controller.openPhoneDialer();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchingForSP(context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // color: MyColors.primary.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/searching.svg',
                        height: 200, semanticsLabel: 'Searching'),
                    // CircularProgressIndicator(
                    //   valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
                    // ),
                    // SizedBox(width: 16.0),
                    Text(
                      'Locating your Service Provider',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
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
                            Colors.amber), // Color of the progress indicator
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ProgressOutlineIconButton(
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchingForDifferentSP(context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // color: MyColors.primary.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/searching.svg',
                        height: 200, semanticsLabel: 'Searching'),
                    // CircularProgressIndicator(
                    //   valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
                    // ),
                    // SizedBox(width: 16.0),
                    Text(
                      'Locating another Service Provider',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),

                    Text(
                      'Sorry the SP cancelled transaction. We are connecting you to another service providers',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black54),
                    ),
                    // GifController _controller = GifController(vsync: this);
                    SizedBox(width: 50.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        minHeight: 10,
                        backgroundColor: Colors
                            .grey[200], // Background color of the progress bar
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amber), // Color of the progress indicator
                      ),
                    ),
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
              // color: MyColors.primary.shade100,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Service Provider found',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      // SvgPicture.asset('assets/images/payment.svg',
                      //     height: 200, semanticsLabel: 'Searching'),

                      // SizedBox(height: 10.0),
                      Text(
                        'Make payment to confirm the job.',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      SizedBox(height: 10.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Obx(() => CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      "${Constants.AWS_S3_URL}${controller.spImageUrl.value}"),
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    controller.spName.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                              Obx(() => Text(
                                    controller.spCompany.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      // GifController _controller = GifController(vsync: this);
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: LinearProgressIndicator(
                      //     minHeight: 10,
                      //     backgroundColor: Colors
                      //         .grey[200], // Background color of the progress bar
                      //     valueColor: AlwaysStoppedAnimation<Color>(
                      //         MyColors.primary), // Color of the progress indicator
                      //   ),
                      // ),
                      Divider(),
                      ListTile(
                        title: Text(
                          "Fee",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Obx(
                            () => Text('GHS ${controller.totalCost.value}')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProgressIconButton(
                            onPressed: () {
                              controller.initiateTellerPayment("momo");
                            },
                            isLoading: controller.isLoading.value,
                            iconData: Icons.mobile_friendly_sharp,
                            label: 'Pay with MoMo',
                            iconColor: Colors.white,
                            progressColor: Colors.white,
                            textColor: Colors.white,
                            backgroundColor: controller.isLoading.value
                                ? MyColors.secondary
                                : MyColors.secondary,
                            borderColor: MyColors.secondary,
                          ),
                          ProgressIconButton(
                            onPressed: () {
                              controller.initiateTellerPayment("card");
                            },
                            isLoading: controller.isLoading.value,
                            iconData: Icons.payment_sharp,
                            label: 'Pay with Card',
                            iconColor: Colors.white,
                            progressColor: Colors.white,
                            textColor: Colors.white,
                            backgroundColor: controller.isLoading.value
                                ? MyColors.primary
                                : MyColors.primary,
                            borderColor: MyColors.primary,
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          ProgressOutlineIconButton(
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
        ],
      ),
    );
  }

  Widget workStarted(context) {
    //SP found, show details of sp with image make payment
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // color: MyColors.primary.shade100,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Work has started',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      // SvgPicture.asset('assets/images/payment.svg',
                      //     height: 200, semanticsLabel: 'Searching'),

                      // SizedBox(height: 10.0),
                      Text(
                        'Service Provider says work has started.',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                      SizedBox(height: 10.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Obx(() => CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      "${Constants.AWS_S3_URL}${controller.spImageUrl.value}"),
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    controller.spName.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                              Obx(() => Text(
                                    controller.spCompany.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      // GifController _controller = GifController(vsync: this);
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: LinearProgressIndicator(
                      //     minHeight: 10,
                      //     backgroundColor: Colors
                      //         .grey[200], // Background color of the progress bar
                      //     valueColor: AlwaysStoppedAnimation<Color>(
                      //         MyColors.primary), // Color of the progress indicator
                      //   ),
                      // ),

                      SmallButton(
                        onPressed: () {
                          controller.openPhoneDialer();
                        },
                        showLoading: false,
                        label: IconButton(
                          icon: Icon(Icons.call),
                          onPressed: () {
                            controller.openPhoneDialer();
                          },
                        ),
                      ),
                      Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProgressIconButton(
                            onPressed: () {
                              controller.confirmClaim();
                            },
                            isLoading: controller.isLoading.value,
                            iconData: FontAwesome.thumbs_up,
                            label: 'Confirm claim',
                            iconColor: Colors.white,
                            progressColor: Colors.white,
                            textColor: Colors.white,
                            backgroundColor: controller.isLoading.value
                                ? MyColors.secondary
                                : MyColors.secondary,
                            borderColor: MyColors.secondary,
                          ),
                          ProgressIconButton(
                            onPressed: () {
                              controller.denyClaim();
                            },
                            isLoading: controller.isLoading.value,
                            iconData: FontAwesome.thumbs_down,
                            label: 'Deny claim',
                            iconColor: Colors.white,
                            progressColor: Colors.white,
                            textColor: Colors.white,
                            backgroundColor: controller.isLoading.value
                                ? MyColors.primary
                                : MyColors.primary,
                            borderColor: MyColors.primary,
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget rateSp(context) {
    return Column(
      children: [
        SvgPicture.asset('assets/images/rating.svg',
            height: 200, semanticsLabel: 'Searching'),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "How was the service?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RatingBar.builder(
            initialRating: controller.rating.value,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: TextField(
            controller: controller.ratingCommentController,
            decoration: InputDecoration(
              labelText: 'Enter comment',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SmallButton(
          onPressed: () {
            controller.submitRating();
          },
          showLoading: false,
          label: Text("Submit"),
        ),
      ],
    );

    // return Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Container(
    //           // color: MyColors.primary.shade100,
    //           child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     'Rate Service Provider',
    //                     style: TextStyle(
    //                         fontSize: 20.0, fontWeight: FontWeight.bold),
    //                   ),
    //                   // SvgPicture.asset('assets/images/payment.svg',
    //                   //     height: 200, semanticsLabel: 'Searching'),

    //                   // SizedBox(height: 10.0),
    //                   Text(
    //                     'Kindly take a moment to rate our Service Provider',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         color: Colors.black54),
    //                   ),
    //                   SizedBox(height: 10.0),

    //                   Divider(),
    //                   Text(
    //                     'Did the Service Provider and team Undertake the work with the required personal protective gear?',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         color: Colors.black54),
    //                   ),
    //                   Text(
    //                     'Did the operator make any cash demand other than your receipted payment to iCesspool?',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         color: Colors.black54),
    //                   ),
    //                   Text(
    //                     'Did the Operator cause any damage to property during the operations?',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         color: Colors.black54),
    //                   ),
    //                   Text(
    //                     'Did the Operator cover well all opened inspection ports of your tanks/bio-digester and cleaned all spills after the operation?',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         color: Colors.black54),
    //                   ),
    //                   Text(
    //                     'Did Operator use any abusive language on persons within household?',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         color: Colors.black54),
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       ProgressIconButton(
    //                         onPressed: () {
    //                           controller.submitRating();
    //                         },
    //                         isLoading: controller.isLoading.value,
    //                         iconData: FontAwesome.thumbs_up,
    //                         label: 'Submit',
    //                         iconColor: Colors.white,
    //                         progressColor: Colors.white,
    //                         textColor: Colors.white,
    //                         backgroundColor: controller.isLoading.value
    //                             ? MyColors.secondary
    //                             : MyColors.secondary,
    //                         borderColor: MyColors.secondary,
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               )),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
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
                title: 'Learn More',
                subTitle: 'Learn more about our services',
                onTap: () {
                  Get.to(() => ServicesView());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Widget buildListTile(String title, String value) {
//   return ListTile(
//     title: Text(
//       title,
//       style: TextStyle(fontWeight: FontWeight.bold),
//     ),
//     subtitle: Text(value),
//   );
// }

openBioDigesterMainView() {
  return Get.to(() => BioDigesterMainView());
}

openTankerMainView() {
  return Get.to(() => EmptyingMainView());
}

openWaterMainView() {
  return Get.to(() => WaterMainView());
}
