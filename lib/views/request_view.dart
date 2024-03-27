// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icesspool/app/modules/login/controllers/login_controller.dart';
import 'package:icesspool/app/modules/services/views/services_view.dart';
import 'package:icesspool/app/modules/toilet-truck/views/toilet_truck_view.dart';
import 'package:icesspool/contants.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/emptying_main_view.dart';
import 'package:icesspool/views/water_main_view.dart';
import 'package:icesspool/widgets/service-widget.dart';
import 'package:icesspool/widgets/small-button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../controllers/home_controller.dart';
import '../controllers/request_controller.dart';

import '../widgets/progress-icon-button.dart';
import '../widgets/progress-outline-icon-button.dart';
import 'biodigester_main_view.dart';

class RequestView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final homeController = Get.put(HomeController());
  final contentKey = GlobalKey();

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
    return GetBuilder<RequestController>(
        init: RequestController(),
        builder: (RequestController controller) {
          return Scaffold(
            bottomSheet: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final maxHeight = constraints.maxHeight;
                final initialSize = controller.contentHeight.value > 0
                    ? (controller.contentHeight.value / maxHeight)
                    : 0.8;

                return InteractiveBottomSheet(
                  options: InteractiveBottomSheetOptions(
                      expand: false,
                      initialSize: controller.contentHeight.value > 0
                          ? controller.contentHeight.value / maxHeight
                          : 0.8,
                      maxSize: 0.9,
                      minimumSize: initialSize * 0.5),
                  child: Builder(
                    builder: (BuildContext context) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final RenderBox renderBox = contentKey.currentContext
                            ?.findRenderObject() as RenderBox;

                        controller.updateContentHeight(renderBox.size.height);
                      });

                      return Column(
                        key: contentKey,
                        children: [
                          controller.customerHasTransaction.value == 1
                              ? Column(
                                  children: [
                                    displayViewByStatus(context, controller)
                                  ],
                                )
                              : controller.customerHasTransaction.value == 2
                                  ? servicesView()
                                  : servicesView(),
                        ],
                      );
                    },
                  ),
                  draggableAreaOptions: DraggableAreaOptions(
                    indicatorColor: Color.fromARGB(255, 230, 230, 230),
                    indicatorWidth: 40,
                    indicatorHeight: 5,
                    indicatorRadius: 10,
                  ),
                );
              },
            ),
            body: Obx(
              () {
                final LatLng? currentLocation =
                    controller.currentLocation.value;
                return currentLocation == null
                    ? Shimmer(
                        duration: Duration(seconds: 3), //Default value
                        interval: Duration(
                            seconds: 5), //Default value: Duration(seconds: 0)
                        color: Colors.white, //Default value
                        colorOpacity: 0, //Default value
                        enabled: true, //Default value
                        direction: ShimmerDirection.fromLTRB(), //Default Value
                        child: Container(
                          color: Colors.grey.shade300,
                        ),
                      )
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: currentLocation,
                          zoom: 15,
                        ),
                        onMapCreated: controller.onMapCreated,
                        markers: Set<Marker>.of([
                          Marker(
                            markerId: MarkerId('currentLocation'),
                            position: currentLocation,
                            infoWindow: InfoWindow(
                              title: 'Current Location',
                            ),
                          ),
                        ]),
                      );
              },
            ),
          );
        });
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

  Widget orderInPlace(context, controller) {
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

  Widget searchingForSP(context, controller) {
    return SingleChildScrollView(
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
                    SizedBox(height: 30.0),
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

  Widget searchingForDifferentSP(context, controller) {
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

  Widget spFound(context, controller) {
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
                            isLoading: controller.pmIsLoading.value,
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
                            isLoading: controller.pcIsLoading.value,
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

  Widget workStarted(context, controller) {
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
                      SvgPicture.asset('assets/images/searching.svg',
                          height: 200, semanticsLabel: 'Searching'),
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
                              controller.respondClaim();
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
                              controller.respondClaim();
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

  Widget rateSp(context, controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.rating.value = rating;
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
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
              controller.submitRating(context);
            },
            showLoading: false,
            label: Text("Submit"),
          ),
        ],
      ),
    );
  }

  Widget shimmerEffect(context, controller) {
    return Shimmer(
      duration: Duration(seconds: 3), //Default value
      interval: Duration(seconds: 5), //Default value: Duration(seconds: 0)
      color: Colors.white, //Default value
      colorOpacity: 0, //Default value
      enabled: true, //Default value
      direction: ShimmerDirection.fromLTRB(), //Default Value
      child: Container(
        color: Colors.grey.shade300,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(height: 600),
                Container(height: 600),
                Container(height: 600)
              ],
            ),
          ],
        ),
      ),
    );
  }

  confirmWorkStarted(context, controller) {
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
                      Text(
                        'Is the Service Provider at your premises',
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
                              controller.respondClaim();
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
                              controller.respondClaim();
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

  offerResassigned(context, controller) {
    if (controller.paymentStatus.value == 1) {
      return orderInPlace(context, controller);
    }
    return spFound(context, controller);
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
                  subTitle: 'Emptying and new biodigester\n construction',
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
                  title: 'Toilet Truck',
                  subTitle: 'Empty your Septic tank\n',
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
                  subTitle: 'Request for bulk water\n',
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
                subTitle: 'Learn more about our services\n',
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

  displayViewByStatus(context, controller) {
    switch (controller.transactionStatus.value) {
      case Constants.OFFER_MADE:
        return searchingForSP(context, controller);

      case Constants.OFFER_ACCEPTED:
        return spFound(context, controller);

      case Constants.PAYMENT_MADE:
        return orderInPlace(context, controller);
      case Constants.WORK_STARTED_REQUEST:
        return confirmWorkStarted(context, controller);

      case Constants.WORK_STARTED:
        return workStarted(context, controller);
      case Constants.OFFER_CANCELLED_SP:
        return searchingForDifferentSP(context, controller);

      case Constants.OFFER_CANCELLED_CL:
        return servicesView();
      case Constants.OFFER_REASSIGNED:
        return offerResassigned(context, controller);
      case Constants.WORK_COMPLETED_REQUEST:
        return confirmWorkCompleted(context, controller);
      case Constants.WORK_COMPLETED:
        return rateSp(context, controller);
      case Constants.OFFER_CLOSED:
        return rateSp(context, controller);
      case Constants.WORK_NOT_COMPLETED:
        return workStarted(context, controller);
      case Constants.OFFER_RATED:
        return servicesView();

      default:
        servicesView();
    }
    //  controller.transactionStatus.value ==
  }

  confirmWorkCompleted(context, controller) {
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
                      Text(
                        'Has the Service Provider completed the work?',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      // SvgPicture.asset('assets/images/payment.svg',
                      //     height: 200, semanticsLabel: 'Searching'),

                      // SizedBox(height: 10.0),
                      Text(
                        'Service Provider says he has completed the work.',
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
                              controller.confirmJobCompletedClaim();
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
                              controller.denyJobCompletedClaim();
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
    return Get.to(() => ToiletTruckView());
  }

  openWaterMainView() {
    return Get.to(() => WaterMainView());
  }
}
