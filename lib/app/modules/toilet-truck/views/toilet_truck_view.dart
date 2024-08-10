import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:icesspool/app/modules/services/views/services_view.dart';
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
import 'package:icesspool/widgets/toilet-truck-pricing.dart';
import 'package:intl/intl.dart';

import '../controllers/toilet_truck_controller.dart';

class ToiletTruckView extends StatelessWidget {
  final controller = Get.put(ToiletTruckController());

  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();
  final formKey5 = new GlobalKey<FormState>();
  final formKey6 = new GlobalKey<FormState>();

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
                    connectorColor: WidgetStatePropertyAll(MyColors.secondary),
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
                                    buttonColor: MyColors.secondary,
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
                                        buttonColor: MyColors.secondary,
                                        textColor: Colors.white,
                                      )
                                    : controller.currentStep == 2
                                        ? SolidButton(
                                            onPressed: () {
                                              if (controller.selectedTruckTypeId
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
                                            : Obx(() => ProgressButton(
                                                  onPressed: () {
                                                    if (controller
                                                            .selectedTimeRangeId
                                                            .value ==
                                                        0) {
                                                      showToast(
                                                        backgroundColor:
                                                            Colors.red.shade800,
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
                                                    if (controller
                                                            .calculateHoursDifference() <
                                                        4) {
                                                      showToast(
                                                        backgroundColor:
                                                            Colors.red.shade800,
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
                                    labelText: 'Enter name of user or company',
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
                        content: Form(
                          key: formKey2,
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
                            Center(
                              child: Obx(
                                () {
                                  if (controller.truckTypes.isEmpty) {
                                    return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          controller.truckTypes.length,
                                          (index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 16.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: controller
                                                          .selectedTruckTypeIndex
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
                                                .truckTypes[index].tankVolume
                                                .toString()),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                      .truckTypes[index].name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(controller
                                                        .truckTypes[index]
                                                        .tankVolume
                                                        .toString() +
                                                    "m3"),
                                              ],
                                            ),
                                            tileColor: controller
                                                        .selectedTruckTypeIndex
                                                        .value ==
                                                    index
                                                ? MyColors.secondary
                                                    .withOpacity(0.2)
                                                : Colors.transparent,
                                            onTap: () => controller
                                                .selectTruckType(index),
                                            trailing: controller
                                                        .selectedTruckTypeIndex
                                                        .value ==
                                                    index
                                                ? Icon(Icons.check,
                                                    color: MyColors.secondary)
                                                : null,
                                          ),
                                        );
                                      }),
                                    );
                                  }
                                },
                              ),

                              // Column(
                              //   children: [
                              //     Form(
                              //       key: formKey3,
                              //       autovalidateMode:
                              //           AutovalidateMode.onUserInteraction,
                              //       child: Column(
                              //         children: controller.pricing
                              //             .asMap()
                              //             .entries
                              //             .map((entry) {
                              //           int index = entry.key;

                              //           Map<String, dynamic> element = entry.value;

                              //           return ToiletTruckPricing(
                              //             activeBgColor: MyColors.primary,
                              //             inactiveBgColor: MyColors.SubServiceColor2,
                              //             isAvailable: false,
                              //             path: "assets/images/biodigester.png",
                              //             size: 32,
                              //             title: element["name"],
                              //             subTitle: "",
                              //             onPressed: () {
                              //               controller.updateSelectedIndex(index);
                              //             },
                              //             price: "GHS ${element["price"]}",
                              //             isSelected:
                              //                 controller.isSelectedList[index],
                              //             description: RichText(
                              //               text: TextSpan(
                              //                 text: element["tankVolume"].toString(),
                              //                 style: TextStyle(
                              //                   fontSize: 16,
                              //                   color: MyColors.primary,
                              //                   fontWeight: FontWeight.normal,
                              //                 ),
                              //                 children: <TextSpan>[
                              //                   TextSpan(
                              //                     text: ' m',
                              //                     style: TextStyle(
                              //                       fontSize:
                              //                           12, // Adjust the size for superscript
                              //                       color: Colors.black,
                              //                       fontWeight: FontWeight.bold,
                              //                       textBaseline:
                              //                           TextBaseline.alphabetic,
                              //                       // Move the superscript text up by half its font size
                              //                       // You can adjust this value based on your font and size
                              //                       //baseline: TextBaseline.ideographic,
                              //                       letterSpacing: -1,
                              //                     ),
                              //                   ),
                              //                   TextSpan(
                              //                     text: '3',
                              //                     style: TextStyle(
                              //                       fontSize:
                              //                           12, // Adjust the size for superscript
                              //                       color: Colors.black,
                              //                       fontWeight: FontWeight.bold,
                              //                       textBaseline:
                              //                           TextBaseline.alphabetic,
                              //                       // Move the superscript text up by half its font size
                              //                       // You can adjust this value based on your font and size
                              //                       //baseline: TextBaseline.ideographic,
                              //                       letterSpacing: -1,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),

                              //             //  Text(element["tankVolume"].toString()+" m"),
                              //           );
                              //         }).toList(),
                              //       ),
                            ),
                          ],
                        ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                        labelText:
                                            'Search for service provider',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Obx(
                                        () => DropdownSearch<String>(
                                          popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            showSelectedItems: true,
                                            itemBuilder:
                                                (context, item, isSelected) {
                                              return ListTile(
                                                title: Text(item),
                                              );
                                            },
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
                                                  "Select service provider",
                                            ),
                                          ),
                                          onChanged: (value) {
                                            controller.showCancelButton.value =
                                                true;
                                            controller.serviceProviderName
                                                .value = value.toString();
                                            controller.serviceProviderId.value =
                                                controller.getServiceProviderId(
                                                    value.toString().trim());

                                            controller.companyName.value =
                                                controller
                                                    .getServiceProviderCompany(
                                                        value
                                                            .toString()
                                                            .trim());

                                            controller.spPicture.value =
                                                controller
                                                    .getServiceProviderPicture(
                                                        value
                                                            .toString()
                                                            .trim());

                                            controller.spPhoneNumber.value =
                                                controller
                                                    .getServiceProviderPhoneNumber(
                                                        value
                                                            .toString()
                                                            .trim());
                                          },
                                          selectedItem: controller
                                              .serviceProviderName.value,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                controller.showCancelButton.value
                                    ? Obx(() {
                                        return controller.showCancelButton.value
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      16.0), // Padding inside the container
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .white, // Background color
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0), // Rounded corners
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.5), // Shadow color with opacity
                                                        spreadRadius:
                                                            2, // Spread radius of shadow
                                                        blurRadius:
                                                            5, // Blur radius of shadow
                                                        offset: Offset(0,
                                                            3), // Offset of the shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius:
                                                                  20.0, // Adjust the size as needed
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                '${Constants.AWS_S3_URL}${controller.spPicture.value}', // Replace with dynamic URL
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    8.0), // Space between avatar and text
                                                            Expanded(
                                                              child: Text(
                                                                controller
                                                                        .serviceProviderName
                                                                        .value +
                                                                    "\n" +
                                                                    controller
                                                                        .companyName
                                                                        .value,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.0, // Adjust the font size as needed
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: IconButton(
                                                          icon: Icon(Icons
                                                              .cancel_outlined),
                                                          color: Colors.red,
                                                          iconSize: 20.0,
                                                          tooltip: 'Clear',
                                                          onPressed: () {
                                                            controller
                                                                    .showCancelButton
                                                                    .value =
                                                                false; // Hide the widget
                                                            controller
                                                                .companyName
                                                                .value = "";
                                                            controller
                                                                .serviceProviderName
                                                                .value = "";

                                                            controller
                                                                .spPhoneNumber
                                                                .value = "";
                                                            controller.spPicture
                                                                .value = "";
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(); // Empty container when showCancelButton is false
                                      })
                                    : SizedBox.shrink(),
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
