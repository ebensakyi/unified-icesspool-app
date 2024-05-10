import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:icesspool/app/modules/services/views/services_view.dart';
import 'package:icesspool/constants.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/model/time_range.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/dropdown.dart';
import 'package:icesspool/widgets/outline-button.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:icesspool/widgets/small-text-box.dart';
import 'package:icesspool/widgets/solid-button.dart';
import 'package:icesspool/widgets/toilet-truck-pricing.dart';
import 'package:intl/intl.dart';

import '../controllers/toilet_truck_controller.dart';

class ToiletTruckView extends StatelessWidget {
  final controller = Get.put(ToiletTruckController());

  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();

  ToiletTruckView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Toilet Truck"),
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
                    connectorColor:
                        MaterialStatePropertyAll(MyColors.secondary),
                    type: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? StepperType.vertical
                        : StepperType.horizontal,
                    physics: const ScrollPhysics(),
                    currentStep: controller.currentStep.value,
                    onStepTapped: (step) => controller.tapped(step),
                    onStepContinue: controller.continued,
                    onStepCancel: controller.cancel,
                    controlsBuilder: (context, _) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: <Widget>[
                            controller.currentStep == 0
                                ? SolidButton(
                                    onPressed: () {
                                      print(
                                          "formKey2.currentState!.validate()");
                                      if (formKey1.currentState!.validate()) {
                                        // controller
                                        //     .selectedTimeRangeId.value = 1;

                                        controller.continued();
                                      }
                                      // if (controller
                                      //         .selectedLocation.value.lat !=
                                      //     null) {
                                      //   controller.continued();
                                      // } else {
                                      //   showToast(
                                      //     backgroundColor:
                                      //         Colors.yellow.shade800,
                                      //     alignment: Alignment.center,
                                      //     'Please enter your location',
                                      //     context: context,
                                      //     animation: StyledToastAnimation.scale,
                                      //     duration: Duration(seconds: 4),
                                      //     position: StyledToastPosition.top,
                                      //   );
                                      //   return;
                                      // }
                                    },
                                    showLoading: false,
                                    label: Text("Next"),
                                    buttonColor: MyColors.primary,
                                    textColor: Colors.white,
                                  )
                                : controller.currentStep == 1
                                    ? SolidButton(
                                        onPressed: () {
                                          if (formKey2.currentState!
                                              .validate()) {
                                            controller.continued();
                                          } else {
                                            showToast(
                                              backgroundColor:
                                                  Colors.yellow.shade800,
                                              alignment: Alignment.center,
                                              'Please enter your location',
                                              context: context,
                                              animation:
                                                  StyledToastAnimation.scale,
                                              duration: Duration(seconds: 4),
                                              position: StyledToastPosition.top,
                                            );
                                            return;
                                          }
                                        },
                                        showLoading: false,
                                        label: Text('Next'),
                                        buttonColor: MyColors.primary,
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
                                              // if (formKey2.currentState!
                                              //     .validate()) {
                                              //   // controller
                                              //   //     .selectedTimeRangeId.value = 1;
                                              //   controller.continued();
                                              // }
                                            },
                                            showLoading: false,
                                            label: Text('Next'),
                                            buttonColor: MyColors.primary,
                                            textColor: Colors.white,
                                          )
                                        // : controller.currentStep == 3
                                        //     ? SolidButton(
                                        //         onPressed: () {
                                        //           if (controller
                                        //                   .selectedTimeRangeId
                                        //                   .value ==
                                        //               0) {
                                        //             return showToast(
                                        //               backgroundColor:
                                        //                   Colors.red.shade800,
                                        //               alignment:
                                        //                   Alignment.center,
                                        //               'Please select time frame for the job',
                                        //               context: context,
                                        //               animation:
                                        //                   StyledToastAnimation
                                        //                       .scale,
                                        //               duration:
                                        //                   Duration(seconds: 4),
                                        //               position:
                                        //                   StyledToastPosition
                                        //                       .center,
                                        //             );
                                        //           }
                                        //           if (controller
                                        //                   .calculateHoursDifference() <
                                        //               4) {
                                        //             return showToast(
                                        //               backgroundColor:
                                        //                   Colors.red.shade800,
                                        //               alignment:
                                        //                   Alignment.center,
                                        //               'Please select date and time at least 4 hrs from now',
                                        //               context: context,
                                        //               animation:
                                        //                   StyledToastAnimation
                                        //                       .scale,
                                        //               duration:
                                        //                   Duration(seconds: 4),
                                        //               position:
                                        //                   StyledToastPosition
                                        //                       .center,
                                        //             );
                                        //           }
                                        //           // controller.continued();

                                        //           if (formKey2.currentState!
                                        //               .validate())
                                        //             controller.continued();
                                        //         },
                                        //         showLoading: false,
                                        //         label: Text('Next'),
                                        //         buttonColor: MyColors.primary,
                                        //         textColor: Colors.white,
                                        //       )

                                        : Obx(() => ProgressButton(
                                              onPressed: () {
                                                if (controller
                                                        .selectedTimeRangeId
                                                        .value ==
                                                    0) {
                                                  showToast(
                                                    backgroundColor:
                                                        Colors.red.shade800,
                                                    alignment: Alignment.center,
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
                                                  showToast(
                                                    backgroundColor:
                                                        Colors.red.shade800,
                                                    alignment: Alignment.center,
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
                                                controller.sendRequest(context);
                                              },
                                              isLoading:
                                                  controller.isLoading.value,
                                              label: 'Submit',
                                              progressColor: Colors.white,
                                              textColor: Colors.white,
                                              backgroundColor:
                                                  controller.isLoading.value
                                                      ? MyColors.secondary
                                                      : MyColors.secondary,
                                              borderColor: MyColors.secondary,
                                            )),
                            SizedBox(
                              width: 20,
                            ),
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
                            )
                          ],
                        ),
                      );
                    },
                    steps: <Step>[
                      Step(
                        subtitle: Text('Enter your details to show on receipt'),
                        title: const Text('Receipt Details'),
                        content: Form(
                          key: formKey1,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: TextFormField(
                                  controller: controller.nameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Enter name(User or Company)',
                                    // prefixIcon: Icon(Icons.tag_faces_outlined),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                  ),
                                  validator: (value) {
                                    return Validator.textFieldValidator1(value!,
                                        "Please enter your name or company");
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: TextFormField(
                                  controller: controller.phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    labelText: 'Enter phone',
                                    // prefixIcon: Icon(Icons.tag_faces_outlined),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                  ),
                                  validator: (value) {
                                    return Validator.phoneValidator(value!);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        isActive: controller.currentStep >= 0,
                        state: controller.currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
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
                        isActive: controller.currentStep >= 1,
                        state: controller.currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        subtitle: Text('Make a selection here'),
                        title: const Text('Choose truck type'),
                        content: Column(
                          children: [
                            Form(
                              key: formKey2,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: controller.pricing
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;

                                  Map<String, dynamic> element = entry.value;

                                  return ToiletTruckPricing(
                                    activeBgColor: MyColors.primary,
                                    inactiveBgColor: MyColors.SubServiceColor2,
                                    isAvailable: false,
                                    path: "assets/images/biodigester.png",
                                    size: 32,
                                    title: element["name"],
                                    subTitle: "",
                                    onPressed: () {
                                      controller.updateSelectedIndex(index);
                                    },
                                    price: "GHS ${element["price"]}",
                                    isSelected:
                                        controller.isSelectedList[index],
                                    description: RichText(
                                      text: TextSpan(
                                        text: element["tankVolume"].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: MyColors.primary,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' m',
                                            style: TextStyle(
                                              fontSize:
                                                  12, // Adjust the size for superscript
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              // Move the superscript text up by half its font size
                                              // You can adjust this value based on your font and size
                                              //baseline: TextBaseline.ideographic,
                                              letterSpacing: -1,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '3',
                                            style: TextStyle(
                                              fontSize:
                                                  12, // Adjust the size for superscript
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              // Move the superscript text up by half its font size
                                              // You can adjust this value based on your font and size
                                              //baseline: TextBaseline.ideographic,
                                              letterSpacing: -1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //  Text(element["tankVolume"].toString()+" m"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 2,
                        state: controller.currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      // Step(
                      //   title: new Text(
                      //     'Schedule',
                      //   ),
                      //   subtitle: Text('Choose date and time to schedule'),
                      //   content: Form(
                      //       autovalidateMode:
                      //           AutovalidateMode.onUserInteraction,
                      //       key: formKey3,
                      //       child: Column(
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: Colors.yellow.withOpacity(
                      //                     0.3), // Light yellow background
                      //                 borderRadius: BorderRadius.circular(
                      //                     10.0), // Adjust the radius as needed
                      //               ),
                      //               child: InkWell(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(16.0),
                      //                   child: Text(
                      //                     "Choose a time at least 4hrs from current time",
                      //                     style: TextStyle(
                      //                       color: Colors.black,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           ElevatedButton(
                      //             onPressed: () {
                      //               // controller.selectDate(context);
                      //             },
                      //             child: Text("Select date"),
                      //           ),
                      //           Obx(() {
                      //             final selectedDate =
                      //                 controller.selectedDate.value;

                      //             final formattedDate =
                      //                 DateFormat('EEEE, MMMM d, y')
                      //                     .format(selectedDate);

                      //             return Text(' $formattedDate');
                      //           }),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Divider(),
                      //           ),
                      //           Obx(() {
                      //             if (controller.timeRanges.isEmpty) {
                      //               return CircularProgressIndicator();
                      //             } else {
                      //               return Container(
                      //                 decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                       color: Colors
                      //                           .grey), // Set border color
                      //                   borderRadius: BorderRadius.circular(
                      //                       100), // Set border radius
                      //                 ),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(
                      //                       left: 8.0, right: 8),
                      //                   child: DropdownButton<int>(
                      //                     alignment: Alignment.center,
                      //                     hint: Text('Select Time Range'),
                      //                     value: controller
                      //                         .selectedTimeRangeId.value,
                      //                     onChanged: (int? value) {
                      //                       if (value != null) {
                      //                         TimeRange selectedTimeRange =
                      //                             controller.timeRanges
                      //                                 .firstWhere((ts) =>
                      //                                     ts.id == value);

                      //                         controller.selectedTimeRangeId
                      //                             .value = value;
                      //                         controller
                      //                                 .selectedStartTime.value =
                      //                             selectedTimeRange.start_time;
                      //                       }
                      //                     },
                      //                     underline: Container(),
                      //                     items: controller.timeRanges
                      //                         .map<DropdownMenuItem<int>>((ts) {
                      //                       return DropdownMenuItem<int>(
                      //                         value: ts.id,
                      //                         child: Text(ts.time_schedule),
                      //                       );
                      //                     }).toList(),
                      //                   ),
                      //                 ),
                      //               );
                      //             }
                      //           }),
                      //         ],
                      //       )),
                      //   isActive: controller.currentStep >= 0,
                      //   state: controller.currentStep >= 1
                      //       ? StepState.complete
                      //       : StepState.disabled,
                      // ),
                      Step(
                        title: new Text('Submit'),
                        subtitle: Text('Submit request'),
                        content: Form(
                          key: formKey4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.withOpacity(
                                        0.3), // Light yellow background
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
                              ElevatedButton(
                                onPressed: () {
                                  // controller.selectDate(context);
                                },
                                child: Text("Select date"),
                              ),
                              Obx(() {
                                final selectedDate =
                                    controller.selectedDate.value;

                                final formattedDate =
                                    DateFormat('EEEE, MMMM d, y')
                                        .format(selectedDate);

                                return Text(' $formattedDate');
                              }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              Obx(() {
                                if (controller.timeRanges.isEmpty) {
                                  return CircularProgressIndicator();
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.grey), // Set border color
                                      borderRadius: BorderRadius.circular(
                                          100), // Set border radius
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: DropdownButton<int>(
                                        alignment: Alignment.center,
                                        hint: Text('Select Time Range'),
                                        value: controller
                                            .selectedTimeRangeId.value,
                                        onChanged: (int? value) {
                                          if (value != null) {
                                            TimeRange selectedTimeRange =
                                                controller
                                                    .timeRanges
                                                    .firstWhere(
                                                        (ts) => ts.id == value);

                                            controller.selectedTimeRangeId
                                                .value = value;
                                            controller.selectedStartTime.value =
                                                selectedTimeRange.start_time;
                                          }
                                        },
                                        underline: Container(),
                                        items: controller.timeRanges
                                            .map<DropdownMenuItem<int>>((ts) {
                                          return DropdownMenuItem<int>(
                                            value: ts.id,
                                            child: Text(ts.time_schedule),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                }
                              }),

                              Text(
                                'Invoice for Selected Services',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   itemCount: controller.selectedServices.length,
                              //   itemBuilder: (context, index) {
                              //     final item =
                              //         controller.selectedServices[index];
                              //     return Column(
                              //       children: [
                              //         ListTile(
                              //           title: Text('${item["name"]}'),
                              //           subtitle:
                              //               Text('GHS ${item["unitCost"]}'),
                              //         ),
                              //         Divider(
                              //           height: 1,
                              //           color: Colors.grey,
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Total Bill: GHS ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        isActive: controller.currentStep >= 3,
                        state: controller.currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )

// int currentStep = 0;
// bool completed = false;

        );
  }
}
