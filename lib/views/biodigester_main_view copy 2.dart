import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icesspool/model/biodigester_pricing.dart';
import 'package:icesspool/themes/colors.dart';

import '../controllers/biodigester_controller.dart';
import '../core/validator.dart';
import '../widgets/dropdown.dart';
import '../widgets/sub-service-widget.dart';
import '../widgets/sub-service-widget2.dart';

class BioDigesterMainView extends StatelessWidget {
  final controller = Get.put(BiodigesterController());

  BioDigesterMainView({super.key});

  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    inspect("controller.biodigesterPricings");
    return Scaffold(
        appBar: AppBar(
          title: Text("Bio-digester"),
        ),
        body: Obx(
          () => Stepper(
            type: MediaQuery.of(context).orientation == Orientation.portrait
                ? StepperType.vertical
                : StepperType.horizontal,
            physics: const ScrollPhysics(),
            currentStep: controller.currentStep.value,
            onStepTapped: (step) => controller.tapped(step),
            onStepContinue: controller.continued,
            onStepCancel: controller.cancel,
            controlsBuilder: (context, _) {
              return Row(
                children: <Widget>[
                  controller.currentStep == 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: MyColors.MainColor,
                                borderRadius: BorderRadius.circular(6)),
                            height: 35,
                            child: TextButton(
                              onPressed: () {
                                if (formKey1.currentState!.validate())
                                  controller.continued();
                              },
                              child: Text(
                                'Continue',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : controller.currentStep == 1
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyColors.MainColor,
                                    borderRadius: BorderRadius.circular(6)),
                                height: 35,
                                child: TextButton(
                                  onPressed: () {
                                    if (formKey2.currentState!.validate())
                                      controller.continued();
                                  },
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : controller.isLoading.value
                              ? Obx(() => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Visibility(
                                      visible: controller.isLoading.value,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ))
                              : Obx(() => Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: MyColors.MainColor,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      height: 35,
                                      child: TextButton(
                                        onPressed: () {
                                          controller.send();
                                        },
                                        child: Text(
                                          'Submit Report',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                  Container(
                    decoration: BoxDecoration(
                        // color: Colors.indigo,
                        border: Border.all(color: MyColors.SecondaryColor),
                        borderRadius: BorderRadius.circular(6)),
                    height: 34,
                    child: TextButton(
                      onPressed: () {
                        controller.cancel();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: MyColors.SecondaryColor),
                      ),
                    ),
                  ),
                ],
              );
            },
            steps: <Step>[
              Step(
                subtitle: Text('Make a selection here'),
                title: const Text('Bio-digester needs'),
                content: Form(
                  key: formKey1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: <Widget>[
                      Obx(
                        () => Dropdown(
                          onChangedCallback: (newValue) {
                            controller.selectedRequestType.value = newValue;
                          },
                          value: controller.returnValue(
                              controller.selectedRequestType.value),
                          initialValue: controller.returnValue(
                              controller.selectedRequestType.value),
                          dropdownItems: [
                            DropdownMenuItem(
                              child: Text("Biodigester Maintenance"),
                              value: "1",
                            ),
                            DropdownMenuItem(
                              child: Text("New Toilet Construction"),
                              value: "2",
                            ),
                          ],
                          hintText: '',
                          labelText: "What is your need? *",
                          validator: (value) {
                            return Validator.dropdownValidator(value);
                          },
                        ),
                      ),
                      // Obx(() => Visibility(
                      //       visible: controller.selectedReportType == "1",
                      //       child: Padding(
                      //         padding:
                      //             const EdgeInsets.only(left: 16, right: 16),
                      //         child: Text(
                      //           "${controller.address.value}",
                      //           style: TextStyle(
                      //               fontSize: 10, color: Colors.amber.shade700),
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
                isActive: controller.currentStep >= 0,
                state: controller.currentStep >= 0
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: new Text(
                  'Details',
                ),
                subtitle: Text('Select service'),
                content: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey2,
                  child: Column(
                    children: <Widget>[
                      controller.selectedRequestType.value == "1"
                          ? biodigesterServicing()
                          : biodigesterConstruction()
                      // Obx(
                      //   () => Dropdown(
                      //     onChangedCallback: (newValue) {
                      //       controller.selectedReportCategory.value = newValue;
                      //     },
                      //     value: controller
                      //         .returnValue(controller.selectedReportCategory.value),
                      //     initialValue: controller
                      //         .returnValue(controller.selectedReportCategory.value),
                      //     dropdownItems: controller.reportCategories.map((var obj) {
                      //       return DropdownMenuItem<String>(
                      //         child: Text(obj.name.toString()),
                      //         value: obj.id.toString(),
                      //       );
                      //     }).toList(),
                      //     hintText: '',
                      //     labelText: "Select category of report *",
                      //     validator: (value) {
                      //       return Validator.dropdownValidator(value);
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
                isActive: controller.currentStep >= 0,
                state: controller.currentStep >= 1
                    ? StepState.complete
                    : StepState.disabled,
              ),
              // Step(
              //   title: new Text('Item & other detais'),
              //   content: Column(
              //     children: <Widget>[

              //     ],
              //   ),
              //   isActive: _currentStep >= 0,
              //   state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
              // ),
              Step(
                title: new Text('Choose Picture'),
                subtitle: Text('Capture or select image here'),
                content: Column(
                  children: [
                    // Obx(
                    //   () => Visibility(
                    //     maintainState: false,
                    //     visible: controller.selectedReportType.value == "1",
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: CameraButton(
                    //         onPressed: () {
                    //           controller.getImage(ImageSource.camera);
                    //         },
                    //         text: "Capture picture from camera *",
                    //         icon: Icon(Icons.camera_alt_outlined),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Obx(() => Visibility(
                    //       maintainState: false,
                    //       visible: controller.selectedReportType.value == "2",
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(16.0),
                    //         child: CameraButton(
                    //           onPressed: () {
                    //             controller.getImage(ImageSource.gallery);
                    //           },
                    //           text: "Add a picture from gallery *",
                    //           icon: Icon(Icons.photo),
                    //         ),
                    //       ),
                    //     )),
                  ],
                ),
                isActive: controller.currentStep >= 0,
                state: controller.currentStep >= 2
                    ? StepState.complete
                    : StepState.disabled,
              ),
            ],
          ),
        )

// int currentStep = 0;
// bool completed = false;

        );
  }

  // Widget biodigesterServicing() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       // Padding(
  //       //   padding: const EdgeInsets.all(8.0),
  //       //   child: Expanded(
  //       //     child: Container(
  //       //       child: Text("SERVICE YOUR BIODIGESTER TOILET"),
  //       //     ),
  //       //   ),
  //       // ),
  //       SubServiceWidget2(
  //         activeBgColor: MyColors.DarkBlue,
  //         inactiveBgColor: MyColors.SubServiceColor2,
  //         activeTextColor: Colors.white,
  //         isAvailable: controller.digesterEmptyingAvailable.value,
  //         path: "assets/images/biodigester.png",
  //         size: 32,
  //         title: 'Biodigester Emptying',
  //         subTitle: 'Service or build',
  //         onTap: null,
  //       ),
  //       SubServiceWidget2(
  //         activeTextColor: Colors.white,
  //         activeBgColor: MyColors.DarkBlue,
  //         inactiveBgColor: MyColors.SubServiceColor2,
  //         isAvailable: controller.soakawayServicingAvailable.value,
  //         path: "assets/images/biodigester.png",
  //         size: 32,
  //         title: 'Soakaway Servicing',
  //         subTitle: 'Service or build',
  //         onTap: null,
  //       ),
  //       SubServiceWidget2(
  //         activeTextColor: Colors.white,
  //         activeBgColor: MyColors.DarkBlue,
  //         inactiveBgColor: MyColors.SubServiceColor2,
  //         isAvailable: controller.drainfieldServicingAvailable.value,
  //         path: "assets/images/biodigester.png",
  //         size: 32,
  //         title: 'Drainfield Servicing',
  //         subTitle: 'Service or build',
  //         onTap: null, price: null,
  //       ),
  //       // SubServiceWidget2(
  //       //   activeTextColor: Colors.white,
  //       //   activeBgColor: MyColors.SubServiceColor1,
  //       //   inactiveBgColor: MyColors.DarkBlue,
  //       //   isAvailable: true,
  //       //   path: "assets/images/vidmore.png",
  //       //   size: 32,
  //       //   title: 'Learn More',
  //       //   subTitle: 'Read & watch videos',
  //       //   onTap: null,
  //       // ),
  //     ],
  //   );
  // }

  Widget biodigesterServicing() {
    // List<Widget> wd = [];
    // for (BiodigesterPricing obj in controller.biodigesterPricings) {
    //   wd.add(
    //     SubServiceWidget2(
    //       activeBgColor: MyColors.DarkBlue,
    //       inactiveBgColor: MyColors.SubServiceColor2,
    //       activeTextColor: Colors.white,
    //       isAvailable: false,
    //       path: "assets/images/biodigester.png",
    //       size: 32,
    //       title: obj.name,
    //       subTitle: obj.shortDesc.toString(),
    //       onTap: () {
    //         print(obj.cost.toString());

    //       },
    //       price: "GHS " + obj.cost.toString(), selectedBgColor: null,
    //     ),
    //   );
    // }
    // return Column(children: wd);

    return Column(children: [
      Obx(() => SubServiceWidget2(
            activeBgColor: MyColors.DarkBlue,
            inactiveBgColor: MyColors.SubServiceColor2,
            selectedColor: controller.selectedColor1.value,
            isAvailable: false,
            path: "assets/images/biodigester.png",
            size: 32,
            title: controller.biodigesterPricings[0].name,
            subTitle: controller.biodigesterPricings[0].shortDesc.toString(),
            onPressed: () {
              controller.selectedColor1.value =
                  controller.selectedColor1.value == Colors.grey
                      ? Colors.teal
                      : Colors.grey;

              addOrRemoveItem(controller.selectedServices,
                  controller.biodigesterPricings[0].id.toString());
            },
            price: "GHS " + controller.biodigesterPricings[0].cost.toString(),
          )),
      Obx(() => SubServiceWidget2(
            activeBgColor: MyColors.DarkBlue,
            inactiveBgColor: MyColors.SubServiceColor2,
            selectedColor: controller.selectedColor2.value,
            isAvailable: false,
            path: "assets/images/biodigester.png",
            size: 32,
            title: controller.biodigesterPricings[1].name,
            subTitle: controller.biodigesterPricings[1].shortDesc.toString(),
            onPressed: () {
              controller.selectedColor2.value =
                  controller.selectedColor2.value == Colors.grey
                      ? Colors.teal
                      : Colors.grey;

              addOrRemoveItem(controller.selectedServices,
                  controller.biodigesterPricings[1].id.toString());

              // controller.selectedServices.value
              //     .add(controller.biodigesterPricings[1].id);
            },
            price: "GHS " + controller.biodigesterPricings[1].cost.toString(),
          )),
    ]);
  }

  Widget biodigesterConstruction() {
    List<Widget> wd = [];
    for (BiodigesterPricing obj in controller.biodigesterPricings) {
      wd.add(
        SubServiceWidget2(
          activeBgColor: MyColors.DarkBlue,
          inactiveBgColor: MyColors.SubServiceColor2,
          activeTextColor: Colors.white,
          isAvailable: false,
          path: "assets/images/biodigester.png",
          size: 32,
          title: obj.name,
          subTitle: obj.shortDesc.toString(),
          onPressed: () {},
          price: "GHS " + obj.cost.toString(),
        ),
      );
    }

    // controller.biodigesterPricings.map((element) => {
    //       wd.add(
    //         SubServiceWidget2(
    //           activeBgColor: MyColors.DarkBlue,
    //           inactiveBgColor: MyColors.SubServiceColor2,
    //           activeTextColor: Colors.white,
    //           isAvailable: false,
    //           path: "assets/images/biodigester.png",
    //           size: 32,
    //           title: element.name,
    //           subTitle: 'Service or build',
    //           onTap: null,
    //         ),
    //       )
    //     });

    return Column(children: wd);

    // SubServiceWidget2(
    //   activeBgColor: MyColors.DarkBlue,
    //   inactiveBgColor: MyColors.SubServiceColor2,
    //   activeTextColor: Colors.white,
    //   isAvailable: controller.biodigesterAvailable.value,
    //   path: "assets/images/biodigester.png",
    //   size: 32,
    //   title: 'Biodigester Only',
    //   subTitle: 'Service or build',
    //   onTap: null,
    // ),
    // SubServiceWidget2(
    //   activeTextColor: Colors.white,
    //   activeBgColor: MyColors.DarkBlue,
    //   inactiveBgColor: MyColors.SubServiceColor2,
    //   isAvailable: controller.biodigesterWithSeatAvailable.value,
    //   path: "assets/images/biodigester.png",
    //   size: 32,
    //   title: 'Biodigester With Seat',
    //   subTitle: 'Service or build',
    //   onTap: null,
    // ),
    // SubServiceWidget2(
    //   activeTextColor: Colors.white,
    //   activeBgColor: MyColors.DarkBlue,
    //   inactiveBgColor: MyColors.SubServiceColor2,
    //   isAvailable: controller.standaloneAvailable.value,
    //   path: "assets/images/biodigester.png",
    //   size: 32,
    //   title: 'Standalone Toilet',
    //   subTitle: 'Service or build',
    //   onTap: null,
    // ),
    // SubServiceWidget2(
    //   activeTextColor: Colors.white,
    //   activeBgColor: MyColors.SubServiceColor1,
    //   inactiveBgColor: MyColors.DarkBlue,
    //   isAvailable: true,
    //   path: "assets/images/vidmore.png",
    //   size: 32,
    //   title: 'Learn More',
    //   subTitle: 'Read & watch videos',
    //   onTap: null,
    // ),
    //   ],
    // );
  }

  void addOrRemoveItem(
    myArray,
    String newItem,
  ) {
    if (myArray.contains(newItem)) {
      myArray.remove(newItem);
      print("Removed: $newItem");
    } else {
      myArray.add(newItem);
      print("Added: $newItem");
    }
  }
}
