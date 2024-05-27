import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:icesspool/constants.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/dropdown.dart';
import 'package:icesspool/widgets/outline-button.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:icesspool/widgets/small-text-box.dart';
import 'package:icesspool/widgets/solid-button.dart';
import 'package:intl/intl.dart';

import '../controllers/water_tanker_controller.dart';

class WaterTankerView extends StatelessWidget {
  final controller = Get.put(WaterTankerController());

  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();

  WaterTankerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Water Tanker"),
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
                                        // controller.selectedRequestType.value =
                                        //     "";
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
                                                  .selectedWaterTypeId.value !=
                                              "") {
                                            controller.continued();
                                          } else {
                                            showToast(
                                              backgroundColor:
                                                  Colors.yellow.shade800,
                                              alignment: Alignment.center,
                                              'Please select water type',
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
                                        buttonColor: MyColors.secondary,
                                        textColor: Colors.white,
                                      )
                                    : controller.currentStep == 2
                                        ? SolidButton(
                                            onPressed: () {},
                                            showLoading: false,
                                            label: Text('Next'),
                                            buttonColor: MyColors.secondary,
                                            textColor: Colors.white,
                                          )
                                        : controller.currentStep == 3
                                            ? SolidButton(
                                                onPressed: () {
                                                  // if (controller
                                                  //         .selectedTimeRangeId
                                                  //         .value ==
                                                  //     0) {
                                                  //   return showToast(
                                                  //     backgroundColor:
                                                  //         Colors.red.shade800,
                                                  //     alignment:
                                                  //         Alignment.center,
                                                  //     'Please select time frame for the job',
                                                  //     context: context,
                                                  //     animation:
                                                  //         StyledToastAnimation
                                                  //             .scale,
                                                  //     duration:
                                                  //         Duration(seconds: 4),
                                                  //     position:
                                                  //         StyledToastPosition
                                                  //             .center,
                                                  //   );
                                                  // }

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
                        title: const Text('Water Type'),
                        content: Column(
                          children: [
                            Form(
                              key: formKey1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Obx(() {
                                      if (controller.waterTypes.isEmpty) {
                                        return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                                      } else {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              controller.waterTypes.length,
                                              (index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                  horizontal: 16.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: controller
                                                              .selectedWaterTypeIndex
                                                              .value ==
                                                          index
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                subtitle: Text("Tap to select"),
                                                title: Text(controller
                                                    .waterTypes[index].name),
                                                tileColor: controller
                                                            .selectedWaterTypeIndex
                                                            .value ==
                                                        index
                                                    ? Colors.blue
                                                        .withOpacity(0.2)
                                                    : Colors.transparent,
                                                onTap: () => controller
                                                    .selectWaterType(index),
                                                trailing: controller
                                                            .selectedWaterTypeIndex
                                                            .value ==
                                                        index
                                                    ? Icon(Icons.check,
                                                        color: Colors.blue)
                                                    : null,
                                              ),
                                            );
                                          }),
                                        );
                                      }
                                    }),
                                  ),
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
                          'Tanker Volume',
                        ),
                        subtitle: Text('Select tanker volume'),
                        content: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: formKey3,
                            child: Column(
                              children: [
                                Center(
                                  child: Obx(
                                    () {
                                      if (controller.waterVolumes.isEmpty) {
                                        return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                                      } else {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              controller.waterVolumes.length,
                                              (index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                  horizontal: 16.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: controller
                                                              .selectedWaterVolumeIndex
                                                              .value ==
                                                          index
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                subtitle: Text("Tap to select"),
                                                title: Text(controller
                                                    .waterVolumes[index].name),
                                                tileColor: controller
                                                            .selectedWaterVolumeIndex
                                                            .value ==
                                                        index
                                                    ? Colors.blue
                                                        .withOpacity(0.2)
                                                    : Colors.transparent,
                                                onTap: () => controller
                                                    .selectWaterType(index),
                                                trailing: controller
                                                            .selectedWaterVolumeIndex
                                                            .value ==
                                                        index
                                                    ? Icon(Icons.check,
                                                        color: Colors.blue)
                                                    : null,
                                              ),
                                            );
                                          }),
                                        );
                                      }
                                    },
                                  ),
                                ),
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
                              // Obx(() => ListView.builder(
                              //       shrinkWrap: true,
                              //       itemCount:
                              //           controller.selectedServices.length,
                              //       itemBuilder: (context, index) {
                              //         final item =
                              //             controller.selectedServices[index];
                              //         return Column(
                              //           children: [
                              //             ListTile(
                              //               title: Text('${item["name"]}'),
                              //               subtitle:
                              //                   Text('GHS ${item["unitCost"]}'),
                              //             ),
                              //             Divider(
                              //               height: 1,
                              //               color: Colors.grey,
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     )),
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
                                    // Obx(() => Text(
                                    //       "GHS ${controller.calculateTotalCost(controller.selectedServices)}",
                                    //       style: TextStyle(
                                    //           fontSize: 20,
                                    //           fontWeight: FontWeight.bold),
                                    //     )),
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
}
