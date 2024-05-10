// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:icesspool/app/modules/services/views/services_view.dart';
import 'package:icesspool/constants.dart';
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/model/time_range.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:icesspool/widgets/small-text-box.dart';
import 'package:icesspool/widgets/solid-button.dart';
import 'package:intl/intl.dart';

import '../controllers/biodigester_controller.dart';
import '../core/validator.dart';
import '../widgets/dropdown.dart';
import '../widgets/outline-button.dart';
import '../widgets/sub-service-widget2.dart';

class BioDigesterMainView extends StatelessWidget {
  final controller = Get.put(BiodigesterController());
  final homeController = Get.put(HomeController());
  late GoogleMapController mapController;

  BioDigesterMainView({super.key});

  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Biodigester"),
        ),
        body: Obx(
          () => Theme(
            data: ThemeData(
                // accentColor: Colors.orange,
                // primarySwatch: MyColors.primary,
                colorScheme: ColorScheme.light(primary: MyColors.primary)),
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    connectorThickness: 0.4,
                    connectorColor: MaterialStatePropertyAll(MyColors.primary),
                    type: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? StepperType.vertical
                        : StepperType.horizontal,
                    physics: const ScrollPhysics(),
                    currentStep: controller.currentStep.value,
                    //onStepTapped: (step) => controller.tapped(step),
                    onStepContinue: controller.continued,
                    onStepCancel: controller.cancel,
                    controlsBuilder: (context, _) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: <Widget>[
                            OutlineButton(
                              onPressed: () {
                                controller.cancel();
                              },
                              showLoading: false,
                              borderColor: MyColors.primary,
                              textColor: MyColors.primary,
                              label: Text("Previous"),
                              // sho: false,
                              // iconData: Icons.cancel,
                              // label: "Cancel",
                              // iconColor: Colors.white,
                              // progressColor: Colors.white,
                              // textColor: Colors.white,
                              // backgroundColor: MyColors.primary,
                              // borderColor: MyColors.primary,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            controller.currentStep == 0
                                ? SolidButton(
                                    onPressed: () {
                                      //First step section
                                      if (controller
                                              .selectedLocation.value.lat !=
                                          null) {
                                        controller.selectedRequestType.value =
                                            "";
                                        controller.continued();
                                      } else {
                                        showToast(
                                          backgroundColor:
                                              Colors.yellow.shade800,
                                          alignment: Alignment.center,
                                          'Please enter your location',
                                          context: context,
                                          animation: StyledToastAnimation.scale,
                                          duration: Duration(seconds: 4),
                                          position: StyledToastPosition.top,
                                        );
                                        return;
                                      }
                                    },
                                    showLoading: false,
                                    label: Text("Next"),
                                    buttonColor: MyColors.secondary,
                                    textColor: Colors.white,
                                  )
                                : controller.currentStep == 1
                                    ? SolidButton(
                                        onPressed: () {
                                          if (controller
                                                  .selectedRequestType.value ==
                                              "") {
                                            showToast(
                                              backgroundColor:
                                                  Colors.yellow.shade800,
                                              alignment: Alignment.center,
                                              'Please select request type',
                                              context: context,
                                              animation:
                                                  StyledToastAnimation.scale,
                                              duration: Duration(seconds: 4),
                                              position: StyledToastPosition.top,
                                            );
                                            return;
                                          }

                                          if (controller
                                                  .selectedRequestType.value ==
                                              "2") {
                                            if (controller.adultsNumber.text
                                                    .toString() ==
                                                "") {
                                              showToast(
                                                backgroundColor:
                                                    Colors.yellow.shade800,
                                                alignment: Alignment.center,
                                                'Please enter number of adults',
                                                context: context,
                                                animation:
                                                    StyledToastAnimation.scale,
                                                duration: Duration(seconds: 4),
                                                position:
                                                    StyledToastPosition.top,
                                              );
                                              return;
                                            }
                                            if (controller.childrenNumber.text
                                                    .toString() ==
                                                "") {
                                              showToast(
                                                backgroundColor:
                                                    Colors.yellow.shade800,
                                                alignment: Alignment.center,
                                                'Please enter number of children',
                                                context: context,
                                                animation:
                                                    StyledToastAnimation.scale,
                                                duration: Duration(seconds: 4),
                                                position:
                                                    StyledToastPosition.top,
                                              );
                                              return;
                                            }
                                          }

                                          if (formKey2.currentState!
                                              .validate()) {
                                            log("formKey2==>");
                                            log(controller
                                                .selectedRequestType.value);

                                            if (controller.selectedRequestType
                                                    .value ==
                                                "1") {
                                              log(controller
                                                  .selectedRequestType.value);
                                              controller.addService({
                                                "id": controller
                                                    .biodigesterPricings[0]
                                                    .biodigesterServiceId
                                                    .toInt(),
                                                "unitCost": controller
                                                    .biodigesterPricings[0].cost
                                                    .toString(),
                                                "biodigesterService": controller
                                                    .biodigesterPricings[0]
                                                    .biodigesterServiceId
                                                    .toString(),
                                                "biodigesterType": controller
                                                    .biodigesterPricings[0].type
                                                    .toString(),
                                                "name": controller
                                                    .biodigesterPricings[0].name
                                                    .toString(),
                                              });
                                              controller.continued();
                                            }

                                            if (controller.selectedRequestType
                                                    .value ==
                                                "2") {
                                              controller.calcUsers();

                                              controller.addService({
                                                "id": controller
                                                    .biodigesterPricings[1].id
                                                    .toInt(),
                                                "unitCost": controller
                                                    .calculateUnitCost(),
                                                "name": controller
                                                    .biodigesterPricings[1].name
                                                    .toString(),
                                                "biodigesterService": controller
                                                    .biodigesterPricings[1]
                                                    .biodigesterServiceId
                                                    .toString(),
                                                "biodigesterType": controller
                                                    .biodigesterPricings[1].type
                                                    .toString(),
                                              });
                                              controller.continued();
                                            }
                                          }
                                        },
                                        showLoading: false,
                                        label: Text('Next'),
                                        buttonColor: MyColors.secondary,
                                        textColor: Colors.white,
                                      )
                                    : controller.currentStep == 2
                                        ? SolidButton(
                                            onPressed: () {
                                              // if (controller.selectedServices
                                              //         .length ==
                                              //     0) {
                                              //   showToast(
                                              //     backgroundColor:
                                              //         Colors.yellow.shade800,
                                              //     alignment: Alignment.center,
                                              //     'Please select service',
                                              //     context: context,
                                              //     animation:
                                              //         StyledToastAnimation
                                              //             .scale,
                                              //     duration:
                                              //         Duration(seconds: 4),
                                              //     position: StyledToastPosition
                                              //         .center,
                                              //   );
                                              //   return;
                                              // }
                                              if (formKey2.currentState!
                                                  .validate()) {
                                                // controller
                                                //     .selectedTimeRangeId.value = 1;
                                                controller.continued();
                                              }
                                            },
                                            showLoading: false,
                                            label: Text('Next'),
                                            buttonColor: MyColors.secondary,
                                            textColor: Colors.white,
                                          )
                                        : controller.currentStep == 3
                                            ? SolidButton(
                                                onPressed: () {
                                                  if (controller
                                                          .selectedTimeRangeId
                                                          .value ==
                                                      0) {
                                                    return showToast(
                                                      backgroundColor:
                                                          Colors.red.shade800,
                                                      alignment:
                                                          Alignment.center,
                                                      'Please select time frame for the job',
                                                      context: context,
                                                      animation:
                                                          StyledToastAnimation
                                                              .scale,
                                                      duration:
                                                          Duration(seconds: 4),
                                                      position:
                                                          StyledToastPosition
                                                              .center,
                                                    );
                                                  }
                                                  if (controller
                                                          .calculateHoursDifference() <
                                                      4) {
                                                    return showToast(
                                                      backgroundColor:
                                                          Colors.red.shade800,
                                                      alignment:
                                                          Alignment.center,
                                                      'Please select date and time at least 4 hrs from now',
                                                      context: context,
                                                      animation:
                                                          StyledToastAnimation
                                                              .scale,
                                                      duration:
                                                          Duration(seconds: 4),
                                                      position:
                                                          StyledToastPosition
                                                              .center,
                                                    );
                                                  }
                                                  // controller.continued();

                                                  if (formKey2.currentState!
                                                      .validate())
                                                    controller.continued();
                                                },
                                                showLoading: false,
                                                label: Text('Next'),
                                                buttonColor: MyColors.secondary,
                                                textColor: Colors.white,
                                              )
                                            : Obx(() => ProgressButton(
                                                  onPressed: () {
                                                    controller
                                                        .sendRequest(context);
                                                  },
                                                  isLoading: controller
                                                      .isLoading.value,
                                                  label: 'Submit',
                                                  progressColor: Colors.white,
                                                  textColor: Colors.white,
                                                  backgroundColor:
                                                      controller.isLoading.value
                                                          ? MyColors.secondary
                                                          : MyColors.secondary,
                                                  borderColor:
                                                      MyColors.secondary,
                                                )),
                          ],
                        ),
                      );
                    },
                    steps: <Step>[
                      Step(
                        subtitle: Text('Enter your location here'),
                        title: const Text('Location'),
                        content: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: GooglePlaceAutoCompleteTextField(
                                textEditingController:
                                    controller.googlePlacesController,
                                googleAPIKey: Constants.GOOGLE_MAPS_API_KEY,
                                inputDecoration: InputDecoration(
                                  hintText: "Search your location",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                debounceTime: 400,
                                countries: ["gh"],
                                isLatLngRequired: true,
                                getPlaceDetailWithLatLng:
                                    (Prediction prediction) {
                                  controller.selectedLocation.value =
                                      prediction;
                                },

                                itemClick: (Prediction prediction) {
                                  controller.googlePlacesController.text =
                                      prediction.description ?? "";
                                  controller.googlePlacesController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              prediction.description?.length ??
                                                  0));
                                },
                                seperatedBuilder: Divider(),
                                containerHorizontalPadding: 10,

                                // OPTIONAL// If you want to customize list view item builder
                                itemBuilder:
                                    (context, index, Prediction prediction) {
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Expanded(
                                            child: Text(
                                                "${prediction.description ?? ""}"))
                                      ],
                                    ),
                                  );
                                },

                                isCrossBtnShown: true,

                                // default 600 ms ,
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 0,
                        state: controller.currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        subtitle: Text('Make a selection here'),
                        title: const Text('Biodigester needs'),
                        content: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(
                                    0.3), // Light yellow background
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as needed
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Get.back();
                                  // homeController.changeTabIndex(2);
                                  Get.to(() => ServicesView());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Tap here to learn more about the service you need",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Form(
                              key: formKey1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Dropdown(
                                      onChangedCallback: (newValue) {
                                        controller.selectedServices.value = [];

                                        controller.selectedRequestType.value =
                                            newValue;

                                        // if (controller.selectedRequestType.value ==
                                        //     "2") {
                                        //   showDialog(
                                        //     barrierDismissible: false,
                                        //     context: context,
                                        //     builder: (context) {
                                        //       String contentText =
                                        //           "How many people will be using the toilet?";
                                        //       return StatefulBuilder(
                                        //         builder: (context, setState) {
                                        //           return AlertDialog(
                                        //             title: Text(
                                        //                 "New Biodigester Needs"),
                                        //             content: Container(
                                        //               height: 250,
                                        //               child: Column(
                                        //                 children: [
                                        //                   Text(contentText),
                                        //                   SmallTextBox(
                                        //                       label:
                                        //                           "No. of adults",
                                        //                       controller: controller
                                        //                           .adultsNumber),
                                        //                   SmallTextBox(
                                        //                       label:
                                        //                           "No. of children",
                                        //                       controller: controller
                                        //                           .childrenNumber)
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //             actions: <Widget>[
                                        //               TextButton(
                                        //                 onPressed: () =>
                                        //                     Navigator.pop(context),
                                        //                 child: Text("Cancel"),
                                        //               ),
                                        //               TextButton(
                                        //                 onPressed: () {
                                        //                   // inspect(controller
                                        //                   //     .adultsNumber.text
                                        //                   //     .toString());
                                        //                   // log(controller
                                        //                   //     .adultsNumber.text
                                        //                   //     .toString());
                                        //                   // print(controller
                                        //                   //     .adultsNumber.text
                                        //                   //     .toString());
                                        //                   if (controller
                                        //                           .adultsNumber.text
                                        //                           .toString() ==
                                        //                       "") {
                                        //                     showToast(
                                        //                       backgroundColor:
                                        //                           Colors.yellow
                                        //                               .shade800,
                                        //                       alignment:
                                        //                           Alignment.center,
                                        //                       'Please enter number of adults',
                                        //                       context: context,
                                        //                       animation:
                                        //                           StyledToastAnimation
                                        //                               .scale,
                                        //                       duration: Duration(
                                        //                           seconds: 4),
                                        //                       position:
                                        //                           StyledToastPosition
                                        //                               .top,
                                        //                     );
                                        //                     return;
                                        //                   }
                                        //                   if (controller
                                        //                           .childrenNumber
                                        //                           .text
                                        //                           .toString() ==
                                        //                       "") {
                                        //                     showToast(
                                        //                       backgroundColor:
                                        //                           Colors.yellow
                                        //                               .shade800,
                                        //                       alignment:
                                        //                           Alignment.center,
                                        //                       'Please enter number of children',
                                        //                       context: context,
                                        //                       animation:
                                        //                           StyledToastAnimation
                                        //                               .scale,
                                        //                       duration: Duration(
                                        //                           seconds: 4),
                                        //                       position:
                                        //                           StyledToastPosition
                                        //                               .top,
                                        //                     );
                                        //                     return;
                                        //                   }
                                        //                   controller.calcUsers();
                                        //                   //  controller.cancelRequest();
                                        //                   Navigator.pop(context);
                                        //                 },
                                        //                 child: Text("Ok"),
                                        //               ),
                                        //             ],
                                        //           );
                                        //         },
                                        //       );
                                        //     },
                                        //   );
                                        // }
                                      },
                                      value: controller.returnValue(
                                          controller.selectedRequestType.value),
                                      initialValue: controller.returnValue(
                                          controller.selectedRequestType.value),
                                      dropdownItems: [
                                        DropdownMenuItem(
                                          child:
                                              Text("Biodigester Maintenance"),
                                          value: "1",
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                              "New Biodigester Construction"),
                                          value: "2",
                                        ),
                                      ],
                                      hintText: '',
                                      labelText: "What is your need? *",
                                      validator: (value) {
                                        return Validator.dropdownValidator(
                                            value);
                                      },
                                    ),
                                  ),
                                  Obx(() => Visibility(
                                        visible: controller
                                                .selectedRequestType.value ==
                                            "2",
                                        child: Text(
                                            "How many people will be using the toilet?"),
                                      )),
                                  Obx(
                                    () => Visibility(
                                      visible: controller
                                              .selectedRequestType.value ==
                                          "2",
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SmallTextBox(
                                              label: "No. of adults",
                                              controller:
                                                  controller.adultsNumber,
                                              validator: (value) {
                                                return Validator
                                                    .textFieldValidator(value);
                                              },
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SmallTextBox(
                                              label: "No. of children",
                                              controller:
                                                  controller.childrenNumber,
                                              validator: (value) {
                                                return Validator
                                                    .textFieldValidator(value);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 1,
                        state: controller.currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text(
                          'Details',
                        ),
                        subtitle: Text('Select service'),
                        content: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: formKey2,
                            child: Column(
                              children: [
                                controller.selectedRequestType.value == "1"
                                    ? biodigesterServicing()
                                    : biodigesterConstruction(),
                              ],
                            )),
                        isActive: controller.currentStep >= 2,
                        state: controller.currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text(
                          'Schedule',
                        ),
                        subtitle: Text('Choose date and time to schedule'),
                        content: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: formKey3,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(
                                          0.2), // Light yellow background
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust the radius as needed
                                    ),
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          "Choose a time at least 4hrs from current time",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.selectDate(context);
                                      },
                                      child: Text("Select date"),
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  final selectedDate =
                                      controller.selectedDate.value;

                                  // List<String> splitString =
                                  //     selectedDate.toString().split(" ");

                                  // inspect(splitString[0]);
                                  final formattedDate =
                                      DateFormat('EEEE, MMMM d, y')
                                          .format(selectedDate);

                                  return Text(' $formattedDate');
                                }),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Divider(),
                                // ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(() {
                                  if (controller.timeRanges.isEmpty) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .grey), // Set border color
                                          borderRadius: BorderRadius.circular(
                                              10), // Set border radius
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: DropdownButton<int>(
                                            borderRadius:
                                                BorderRadius.all(Radius.zero),
                                            alignment: Alignment.center,
                                            hint: Text('Select Time Range'),
                                            value: controller
                                                .selectedTimeRangeId.value,
                                            onChanged: (int? value) {
                                              if (value != null) {
                                                TimeRange selectedTimeRange =
                                                    controller.timeRanges
                                                        .firstWhere((ts) =>
                                                            ts.id == value);

                                                controller.selectedTimeRangeId
                                                    .value = value;
                                                controller.selectedStartTime
                                                        .value =
                                                    selectedTimeRange
                                                        .start_time;
                                              }
                                            },
                                            underline: Container(),
                                            items: controller.timeRanges
                                                .map<DropdownMenuItem<int>>(
                                                    (ts) {
                                              return DropdownMenuItem<int>(
                                                value: ts.id,
                                                child: Text(ts.time_schedule),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ],
                            )),
                        isActive: controller.currentStep >= 3,
                        state: controller.currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Submit'),
                        subtitle: Text('Submit request'),
                        content: Form(
                          key: formKey4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invoice for Service',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Use ListView.builder to loop through myArray and display in a Column
                              Obx(() => ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.selectedServices.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                          controller.selectedServices[index];
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text('${item["name"]}'),
                                            subtitle:
                                                Text('GHS ${item["unitCost"]}'),
                                          ),
                                          Divider(
                                            height: 1,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      );
                                    },
                                  )),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Total Fee: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Obx(() => Text(
                                          "GHS ${controller.calculateTotalCost(controller.selectedServices)}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        isActive: controller.currentStep >= 4,
                        state: controller.currentStep >= 4
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: CarouselSlider(
                //     options: CarouselOptions(height: 80.0, autoPlay: true),
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
                //               width: MediaQuery.of(context).size.width,
                //               margin: EdgeInsets.symmetric(horizontal: 5.0),
                //               decoration: BoxDecoration(color: Colors.white),
                //               child: Image.asset('$i'));
                //         },
                //       );
                //     }).toList(),
                //   ),
                // ),
              ],
            ),
          ),
        )

// int currentStep = 0;
// bool completed = false;

        );
  }

  Widget biodigesterServicing() {
    final int index1 = controller.getBiodigesterServiceIndex(1);
    // final int index2 = controller.getBiodigesterServiceIndex(2);
    // final int index3 = controller.getBiodigesterServiceIndex(3);

    return Column(children: [
      controller.biodigesterServicesAvailable.contains(1) && index1 != -1
          ? SubServiceWidget2(
              activeBgColor: MyColors.primary,
              inactiveBgColor: MyColors.SubServiceColor2,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title: controller.biodigesterPricings[index1].name,
              subTitle:
                  controller.biodigesterPricings[index1].shortDesc.toString(),
              onPressed: () {
                // controller.isSelected1.value = !controller.isSelected1.value;

                // controller.addService(controller.selectedServices, {
                //   "id": controller
                //       .biodigesterPricings[index1].biodigesterServiceId
                //       .toInt(),
                //   "unitCost":
                //       controller.biodigesterPricings[index1].cost.toString(),
                //   "name":
                //       controller.biodigesterPricings[index1].name.toString(),
                // });
              },
              price: "GHS " +
                  controller.biodigesterPricings[index1].cost.toString(),
              isSelected: controller.isSelected1.value,
              description: Text(""),
            )
          : SizedBox.shrink(),
    ]);
  }

  Widget biodigesterConstruction() {
    final int index2 = controller.getBiodigesterServiceIndex(2);

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      controller.biodigesterServicesAvailable.contains(2) && index2 != -1
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubServiceWidget2(
                  activeBgColor: MyColors.primary,
                  inactiveBgColor: MyColors.SubServiceColor2,
                  isAvailable: false,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: controller.biodigesterPricings[index2].name,
                  subTitle: controller.biodigesterPricings[index2].shortDesc
                      .toString(),
                  onPressed: () {
                    // controller.isSelected4.value =
                    //     !controller.isSelected4.value;

                    // controller.addService(controller.selectedServices, {
                    //   "id": controller.biodigesterPricings[index2].id.toInt(),
                    //   "unitCost": controller.isStandard()
                    //       ? controller.biodigesterPricings[index2].standardCost
                    //           .toString()
                    //       : controller.isLarge()
                    //           ? controller.biodigesterPricings[index2].largeCost
                    //           : controller
                    //               .biodigesterPricings[index2].doubleLargeCost,
                    //   "name": controller.biodigesterPricings[index2].name
                    //       .toString(),
                    // });
                  },
                  price: 'GHS ${controller.calculateUnitCost()}',
                  isSelected: controller.isSelected4.value,
                  description: Column(
                    children: [
                      Obx(() => Visibility(
                            visible: controller.isStandard(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Standard digester",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.isLarge(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Large digesters",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.isStandardX2(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Two standard digesters",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.isStandardX3(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Three standard digesters",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.isStandardX4(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Four standard digesters",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
    ]);
  }

  // placesAutoCompleteTextField() {
  //   return Container(
  //     height: 100,
  //     padding: EdgeInsets.symmetric(horizontal: 0),
  //     child: GooglePlaceAutoCompleteTextField(
  //       textEditingController: controller.googlePlacesController,
  //       googleAPIKey: Constants.GOOGLE_MAPS_API_KEY,
  //       inputDecoration: InputDecoration(
  //         hintText: "Search your location",
  //         border: InputBorder.none,
  //         enabledBorder: InputBorder.none,
  //       ),
  //       debounceTime: 400,
  //       countries: ["gh", "fr"],
  //       isLatLngRequired: true,
  //       getPlaceDetailWithLatLng: (Prediction prediction) {
  //         print("placeDetails" + prediction.lat.toString());
  //       },

  //       itemClick: (Prediction prediction) {
  //         controller.googlePlacesController.text = prediction.description ?? "";
  //         controller.googlePlacesController.selection =
  //             TextSelection.fromPosition(
  //                 TextPosition(offset: prediction.description?.length ?? 0));
  //       },
  //       seperatedBuilder: Divider(),
  //       containerHorizontalPadding: 10,

  //       // OPTIONAL// If you want to customize list view item builder
  //       itemBuilder: (context, index, Prediction prediction) {
  //         return Container(
  //           padding: EdgeInsets.all(10),
  //           child: Row(
  //             children: [
  //               Icon(Icons.location_on),
  //               SizedBox(
  //                 width: 7,
  //               ),
  //               Expanded(child: Text("${prediction.description ?? ""}"))
  //             ],
  //           ),
  //         );
  //       },

  //       isCrossBtnShown: true,

  //       // default 600 ms ,
  //     ),
  //   );
  // }
}
