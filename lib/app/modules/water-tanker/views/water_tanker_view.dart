import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:icesspool/constants.dart';
import 'package:icesspool/core/utils.dart';
import 'package:icesspool/core/validator.dart';
import 'package:icesspool/model/time_range.dart';
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
  final formKey5 = new GlobalKey<FormState>();
  final formKey6 = new GlobalKey<FormState>();

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
                // primaryColor: Colors.white,
                // accentColor: Colors.orange,
                // primarySwatch: MyColors.primary,
                colorScheme: ColorScheme.light(primary: MyColors.primary)),
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    connectorThickness: 0.4,
                    connectorColor: WidgetStatePropertyAll(MyColors.primary),
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
                                            onPressed: () {
                                              if (controller.selectedWaterTypeId
                                                      .value !=
                                                  "") {
                                                controller.continued();
                                              } else {
                                                showToast(
                                                  backgroundColor:
                                                      Colors.yellow.shade800,
                                                  alignment: Alignment.center,
                                                  'Please select tanker volume',
                                                  context: context,
                                                  animation:
                                                      StyledToastAnimation
                                                          .scale,
                                                  duration:
                                                      Duration(seconds: 4),
                                                  position:
                                                      StyledToastPosition.top,
                                                );
                                                return;
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
                                                  if (Utils.calculateHoursDifference(
                                                          controller
                                                              .selectedDate
                                                              .value,
                                                          controller
                                                              .selectedStartTime
                                                              .value) <
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
                                            : controller.currentStep == 4
                                                ? SolidButton(
                                                    onPressed: () {
                                                      if (controller
                                                              .selectedTimeRangeId
                                                              .value ==
                                                          0) {
                                                        return showToast(
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade800,
                                                          alignment:
                                                              Alignment.center,
                                                          'Please select time frame for the job',
                                                          context: context,
                                                          animation:
                                                              StyledToastAnimation
                                                                  .scale,
                                                          duration: Duration(
                                                              seconds: 4),
                                                          position:
                                                              StyledToastPosition
                                                                  .center,
                                                        );
                                                      }
                                                      if (Utils.calculateHoursDifference(
                                                              controller
                                                                  .selectedDate
                                                                  .value,
                                                              controller
                                                                  .selectedStartTime
                                                                  .value) <
                                                          4) {
                                                        return showToast(
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade800,
                                                          alignment:
                                                              Alignment.center,
                                                          'Please select date and time at least 4 hrs from now',
                                                          context: context,
                                                          animation:
                                                              StyledToastAnimation
                                                                  .scale,
                                                          duration: Duration(
                                                              seconds: 4),
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
                                                    buttonColor:
                                                        MyColors.secondary,
                                                    textColor: Colors.white,
                                                  )
                                                : controller.currentStep == 5
                                                    ? Obx(() => ProgressButton(
                                                          onPressed: () {
                                                            controller
                                                                .sendRequest(
                                                                    context);
                                                          },
                                                          isLoading: controller
                                                              .isLoading.value,
                                                          label: 'Submit',
                                                          progressColor:
                                                              Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              controller
                                                                      .isLoading
                                                                      .value
                                                                  ? MyColors
                                                                      .secondary
                                                                  : MyColors
                                                                      .secondary,
                                                          borderColor: MyColors
                                                              .secondary,
                                                        ))
                                                    : SizedBox.shrink()
                          ],
                        ),
                      );
                    },
                    steps: <Step>[
                      Step(
                        subtitle: Text('Enter your location here'),
                        title: const Text('Location'),
                        content: Form(
                          key: formKey1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
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
                                    controller
                                            .googlePlacesController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: prediction
                                                    .description?.length ??
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
                              key: formKey2,
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
                                                      ? MyColors.secondary
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
                                                    ? MyColors.Red.withOpacity(
                                                        0.2)
                                                    : Colors.transparent,
                                                onTap: () {
                                                  controller
                                                      .selectWaterType(index);
                                                },
                                                trailing: controller
                                                            .selectedWaterTypeIndex
                                                            .value ==
                                                        index
                                                    ? Icon(Icons.check,
                                                        color:
                                                            MyColors.secondary)
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
                                                      ? MyColors.secondary
                                                      : Colors.grey,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: ListTile(
                                                subtitle: Text(controller
                                                    .waterVolumes[index]
                                                    .description),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .waterVolumes[index]
                                                          .name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(controller
                                                            .waterVolumes[index]
                                                            .tankCapacity +
                                                        "m3"),
                                                  ],
                                                ),
                                                tileColor: controller
                                                            .selectedWaterVolumeIndex
                                                            .value ==
                                                        index
                                                    ? MyColors.secondary
                                                        .withOpacity(0.2)
                                                    : Colors.transparent,
                                                onTap: () => controller
                                                    .selectWaterVolume(index),
                                                trailing: controller
                                                            .selectedWaterVolumeIndex
                                                            .value ==
                                                        index
                                                    ? Icon(Icons.check,
                                                        color:
                                                            MyColors.secondary)
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
                            key: formKey4,
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
                                        elevation: WidgetStateProperty.all(0),
                                        shape: WidgetStateProperty.all<
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
                        title: new Text(
                          'Service Provider',
                        ),
                        subtitle: Text('Choose Service Provider'),
                        content: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: formKey5,
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
                                          "Enter the name of the service provider to assign job or skip to allow us to broadcast your request",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 15),
                                        // errorText: widget.errorText,
                                        labelText:
                                            'Search for service provider',
                                        filled: true,
                                        fillColor: Colors.white,

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          //borderSide: BorderSide.none,
                                        ),
                                      ),
                                      child: Obx(
                                        () => DropdownSearch<String>(
                                          popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            showSelectedItems: true,
                                            // disabledItemFn: (String s) => s.startsWith('I'),
                                          ),
                                          items: controller.serviceProviders
                                              .map((element) => element.spName)
                                              .toList(),
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: "",
                                              hintText:
                                                  "Select service provider ",
                                            ),
                                          ),
                                          onChanged: (value) {
                                            controller.serviceProviderName
                                                .value = value.toString();
                                            controller.serviceProviderId.value =
                                                controller.getServiceProviderId(
                                                    value.toString().trim());
                                          },
                                          selectedItem: controller
                                              .serviceProviderName.value,
                                          // validator: (String? item) {
                                          //   inspect(item.toString());
                                          //   if (item == null || item == "")
                                          //     return "Required field";

                                          //   return null;
                                          // },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )),
                        isActive: controller.currentStep >= 4,
                        state: controller.currentStep >= 4
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Submit'),
                        subtitle: Text('Submit request'),
                        content: Form(
                          key: formKey6,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invoice for Service',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  "Water Type ${controller.selectedWaterTypeName.value.toUpperCase()}"),
                              Text(
                                  "Water Volume ${controller.selectedWaterVolumeName.value.toUpperCase()}")
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
