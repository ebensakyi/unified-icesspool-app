import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/progress-button.dart';

import '../controllers/biodigester_controller.dart';
import '../core/validator.dart';
import '../widgets/dropdown.dart';
import '../widgets/sub-service-widget2.dart';
import '../widgets/text-button.dart';

class BioDigesterMainView extends StatelessWidget {
  final controller = Get.put(BiodigesterController());

  BioDigesterMainView({super.key});

  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bio-digester"),
        ),
        body: Obx(
          () => Theme(
            data: ThemeData(
                // accentColor: Colors.orange,
                primarySwatch: Colors.teal,
                colorScheme: ColorScheme.light(primary: Colors.teal)),
            child: Stepper(
              type: MediaQuery.of(context).orientation == Orientation.portrait
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
                          // ? Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //           color: MyColors.MainColor,
                          //           borderRadius: BorderRadius.circular(6)),
                          //       height: 35,
                          //       child: TextButton(
                          //         onPressed: () {
                          //           if (formKey1.currentState!.validate())
                          //             controller.continued();
                          //         },
                          //         child: Text(
                          //           'Continue',
                          //           style: TextStyle(color: Colors.white),
                          //         ),
                          //       ),
                          //     ),
                          //   )
                          ? ProgressTextButton(
                              onPressed: () {
                                if (formKey1.currentState!.validate())
                                  controller.continued();
                              },
                              isLoading: false,
                              label: 'Continue')
                          : controller.currentStep == 1
                              ? ProgressTextButton(
                                  onPressed: () {
                                    controller.continued();
                                  },
                                  isLoading: false,
                                  label: 'Continue',
                                )
                              // ? Padding(
                              //     padding: const EdgeInsets.all(10.0),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           color: MyColors.MainColor,
                              //           borderRadius: BorderRadius.circular(6)),
                              //       height: 35,
                              //       child: TextButton(
                              //         onPressed: () {
                              //           if (formKey2.currentState!.validate())
                              //             controller.continued();
                              //         },
                              //         child: Text(
                              //           'Continue',
                              //           style: TextStyle(color: Colors.white),
                              //         ),
                              //       ),
                              //     ),
                              //   )
                              : Obx(() => ProgressButton(
                                    onPressed: () {
                                      controller.sendRequest();
                                    },
                                    isLoading: controller.isLoading.value,
                                    iconData: Icons.send,
                                    label: 'Submit',
                                    iconColor: Colors.white,
                                    progressColor: Colors.white,
                                    textColor: Colors.white,
                                    backgroundColor: controller.isLoading.value
                                        ? Colors.teal
                                        : Colors.teal,
                                    borderColor: Colors.teal,
                                  )),
                      SizedBox(
                        width: 20,
                      ),
                      ProgressButton(
                        onPressed: () {
                          controller.cancel();
                        },
                        isLoading: false,
                        iconData: Icons.cancel,
                        label: "Cancel",
                        iconColor: Colors.white,
                        progressColor: Colors.white,
                        textColor: Colors.white,
                        backgroundColor: Colors.teal,
                        borderColor: Colors.teal,
                      )
                      // Container(
                      //   decoration: BoxDecoration(
                      //       // color: Colors.indigo,
                      //       border: Border.all(color: MyColors.SecondaryColor),
                      //       borderRadius: BorderRadius.circular(6)),
                      //   height: 34,
                      //   child: TextButton(
                      //     onPressed: () {
                      //       controller.cancel();
                      //     },
                      //     child: const Text(
                      //       'Cancel',
                      //       style: TextStyle(color: MyColors.SecondaryColor),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
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
                  title: new Text('Submit'),
                  subtitle: Text('Submit request'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoice for Selected Services',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Use ListView.builder to loop through myArray and display in a Column
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.selectedServices.length,
                        itemBuilder: (context, index) {
                          final item = controller.selectedServices[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text('${item["name"]}'),
                                subtitle: Text('GHS ${item["unitCost"]}'),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Total Bill: GHS ${controller.calculateTotalCost(controller.selectedServices)}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                  isActive: controller.currentStep >= 0,
                  state: controller.currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
        )

// int currentStep = 0;
// bool completed = false;

        );
  }

  Widget biodigesterServicing() {
    return Column(children: [
      controller.biodigesterServicesAvailable.contains(1)
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              selectedColor: controller.selectedColor1.value,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title:
                  controller.biodigesterPricings[controller.getIndex(1)].name,
              subTitle: controller
                  .biodigesterPricings[controller.getIndex(1)].shortDesc
                  .toString(),
              onPressed: () {
                controller.selectedColor1.value =
                    controller.selectedColor1.value == Colors.grey
                        ? Colors.teal
                        : Colors.grey;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[controller.getIndex(1)].id
                      .toInt(),
                  "unitCost": controller
                      .biodigesterPricings[controller.getIndex(1)].cost
                      .toString(),
                  "name": controller
                      .biodigesterPricings[controller.getIndex(1)].name
                      .toString(),
                });
              },
              price: "GHS " + controller.biodigesterPricings[0].cost.toString(),
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(2)
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              selectedColor: controller.selectedColor2.value,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title:
                  controller.biodigesterPricings[controller.getIndex(2)].name,
              subTitle: controller
                  .biodigesterPricings[controller.getIndex(2)].shortDesc
                  .toString(),
              onPressed: () {
                controller.selectedColor2.value =
                    controller.selectedColor2.value == Colors.grey
                        ? Colors.teal
                        : Colors.grey;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[controller.getIndex(2)].id
                      .toInt(),
                  "unitCost": controller
                      .biodigesterPricings[controller.getIndex(2)].cost
                      .toString(),
                  "name": controller
                      .biodigesterPricings[controller.getIndex(2)].name
                      .toString(),
                });
              },
              price: "GHS " + controller.biodigesterPricings[1].cost.toString(),
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(3)
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              selectedColor: controller.selectedColor3.value,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title:
                  controller.biodigesterPricings[controller.getIndex(3)].name,
              subTitle: controller
                  .biodigesterPricings[controller.getIndex(3)].shortDesc
                  .toString(),
              onPressed: () {
                controller.selectedColor3.value =
                    controller.selectedColor3.value == Colors.grey
                        ? Colors.teal
                        : Colors.grey;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[controller.getIndex(3)].id
                      .toInt(),
                  "unitCost": controller
                      .biodigesterPricings[controller.getIndex(3)].cost
                      .toString(),
                  "name": controller
                      .biodigesterPricings[controller.getIndex(3)].name
                      .toString()
                });
              },
              price: "GHS " +
                  controller.biodigesterPricings[controller.getIndex(3)].cost
                      .toString(),
            )
          : SizedBox.shrink(),
    ]);
  }

  Widget biodigesterConstruction() {
    return Column(children: [
      controller.biodigesterServicesAvailable.contains(4)
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              selectedColor: controller.selectedColor1.value,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title:
                  controller.biodigesterPricings[controller.getIndex(1)].name,
              subTitle: controller
                  .biodigesterPricings[controller.getIndex(1)].shortDesc
                  .toString(),
              onPressed: () {
                controller.selectedColor1.value =
                    controller.selectedColor1.value == Colors.grey
                        ? Colors.teal
                        : Colors.grey;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[controller.getIndex(1)].id
                      .toInt(),
                  "unitCost": controller
                      .biodigesterPricings[controller.getIndex(1)].cost
                      .toString(),
                  "name": controller
                      .biodigesterPricings[controller.getIndex(1)].name
                      .toString(),
                });
              },
              price: "GHS " + controller.biodigesterPricings[0].cost.toString(),
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(5)
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              selectedColor: controller.selectedColor2.value,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title:
                  controller.biodigesterPricings[controller.getIndex(2)].name,
              subTitle: controller
                  .biodigesterPricings[controller.getIndex(2)].shortDesc
                  .toString(),
              onPressed: () {
                controller.selectedColor2.value =
                    controller.selectedColor2.value == Colors.grey
                        ? Colors.teal
                        : Colors.grey;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[controller.getIndex(2)].id
                      .toInt(),
                  "unitCost": controller
                      .biodigesterPricings[controller.getIndex(2)].cost
                      .toString(),
                  "name": controller
                      .biodigesterPricings[controller.getIndex(2)].name
                      .toString(),
                });
              },
              price: "GHS " + controller.biodigesterPricings[1].cost.toString(),
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(6)
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              selectedColor: controller.selectedColor3.value,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title:
                  controller.biodigesterPricings[controller.getIndex(3)].name,
              subTitle: controller
                  .biodigesterPricings[controller.getIndex(3)].shortDesc
                  .toString(),
              onPressed: () {
                controller.selectedColor3.value =
                    controller.selectedColor3.value == Colors.grey
                        ? Colors.teal
                        : Colors.grey;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[controller.getIndex(3)].id
                      .toInt(),
                  "unitCost": controller
                      .biodigesterPricings[controller.getIndex(3)].cost
                      .toString(),
                  "name": controller
                      .biodigesterPricings[controller.getIndex(3)].name
                      .toString()
                });
              },
              price: "GHS " +
                  controller.biodigesterPricings[controller.getIndex(3)].cost
                      .toString(),
            )
          : SizedBox.shrink(),
    ]);
  }

//   Widget biodigesterConstruction() {
//     List<Widget> wd = [];
//     for (BiodigesterPricing obj in controller.biodigesterPricings) {
//       wd.add(
//         SubServiceWidget2(
//           activeBgColor: MyColors.DarkBlue,
//           inactiveBgColor: MyColors.SubServiceColor2,
//           activeTextColor: Colors.white,
//           isAvailable: false,
//           path: "assets/images/biodigester.png",
//           size: 32,
//           title: obj.name,
//           subTitle: obj.shortDesc.toString(),
//           onPressed: () {
//             print(obj.cost.toString());
//           },
//           price: "GHS " + obj.cost.toString(),
//         ),
//       );
//     }

//     return Column(children: wd);
//   }
}
