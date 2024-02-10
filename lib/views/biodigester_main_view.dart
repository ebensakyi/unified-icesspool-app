import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:icesspool/app/modules/services/views/services_view.dart';
import 'package:icesspool/controllers/home_controller.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/progress-button.dart';
import 'package:icesspool/widgets/solid-button.dart';
import 'package:intl/intl.dart';

import '../controllers/biodigester_controller.dart';
import '../core/validator.dart';
import '../widgets/dropdown.dart';
import '../widgets/outline-button.dart';
import '../widgets/small-text-box.dart';
import '../widgets/sub-service-widget2.dart';

class BioDigesterMainView extends StatelessWidget {
  final controller = Get.put(BiodigesterController());
  final homeController = Get.put(HomeController());

  BioDigesterMainView({super.key});

  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();

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
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
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
                                      //First step section
                                      if (formKey1.currentState!.validate()) {
                                        if (controller
                                                .selectedRequestType.value ==
                                            "2") {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              String contentText =
                                                  "How many people will be using the toilet?";
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    title:
                                                        Text("Cancel Request"),
                                                    content: Container(
                                                      height: 250,
                                                      child: Column(
                                                        children: [
                                                          Text(contentText),
                                                          SmallTextBox(
                                                              label:
                                                                  "No. of adults",
                                                              controller: controller
                                                                  .adultsNumber),
                                                          SmallTextBox(
                                                              label:
                                                                  "No. of children",
                                                              controller: controller
                                                                  .childrenNumber)
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          controller
                                                              .calcUsers();
                                                          //  controller.cancelRequest();
                                                          Navigator.pop(
                                                              context);
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
                                        }
                                        controller.getBiodigesterPricing();
                                        controller.continued();
                                      }
                                    },
                                    showLoading: false,
                                    label: Text("Continue"),
                                    buttonColor: Colors.teal,
                                    textColor: Colors.white,
                                  )
                                : controller.currentStep == 1
                                    ? SolidButton(
                                        onPressed: () {
                                          //Second step section

                                          if (controller
                                                  .selectedServices.length ==
                                              0) {
                                            showToast(
                                              backgroundColor:
                                                  Colors.yellow.shade800,
                                              alignment: Alignment.center,
                                              'Please select service',
                                              context: context,
                                              animation:
                                                  StyledToastAnimation.scale,
                                              duration: Duration(seconds: 4),
                                              position:
                                                  StyledToastPosition.center,
                                            );
                                            return;
                                          }
                                          if (formKey2.currentState!.validate())
                                            controller.continued();
                                        },
                                        showLoading: false,
                                        label: Text('Continue'),
                                        buttonColor: Colors.teal,
                                        textColor: Colors.white,
                                      )
                                    : controller.currentStep == 2
                                        ? SolidButton(
                                            onPressed: () {
                                              if (controller.selectedServices
                                                      .length ==
                                                  0) {
                                                return;
                                              }
                                              if (formKey2.currentState!
                                                  .validate())
                                                controller.continued();
                                            },
                                            showLoading: false,
                                            label: Text('Continue'),
                                            buttonColor: Colors.teal,
                                            textColor: Colors.white,
                                          )
                                        : Obx(() => ProgressButton(
                                              onPressed: () {
                                                controller.sendRequest();
                                              },
                                              isLoading:
                                                  controller.isLoading.value,
                                              iconData: Icons.send,
                                              label: 'Submit',
                                              iconColor: Colors.white,
                                              progressColor: Colors.white,
                                              textColor: Colors.white,
                                              backgroundColor:
                                                  controller.isLoading.value
                                                      ? Colors.teal
                                                      : Colors.teal,
                                              borderColor: Colors.teal,
                                            )),
                            SizedBox(
                              width: 20,
                            ),
                            OutlineButton(
                              onPressed: () {
                                controller.cancel();
                              },
                              showLoading: false,
                              borderColor: Colors.teal,
                              textColor: Colors.teal,
                              label: Text("Cancel"),
                              // sho: false,
                              // iconData: Icons.cancel,
                              // label: "Cancel",
                              // iconColor: Colors.white,
                              // progressColor: Colors.white,
                              // textColor: Colors.white,
                              // backgroundColor: Colors.teal,
                              // borderColor: Colors.teal,
                            )
                          ],
                        ),
                      );
                    },
                    steps: <Step>[
                      Step(
                        subtitle: Text('Make a selection here'),
                        title: const Text('Bio-digester needs'),
                        content: Column(
                          children: [
                            Container(
                              color: Colors.yellow
                                  .withOpacity(0.3), // Light yellow background
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
                                        color: Colors
                                            .black), // Adjust text color as needed
                                  ),
                                ),
                              ),
                            ),
                            Form(
                              key: formKey1,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Obx(
                                () => Dropdown(
                                  onChangedCallback: (newValue) {
                                    controller.selectedServices.value = [];

                                    controller.selectedRequestType.value =
                                        newValue;
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
                            ),
                          ],
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
                        isActive: controller.currentStep >= 0,
                        state: controller.currentStep >= 1
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
                                ElevatedButton(
                                  onPressed: () {
                                    controller.selectDate(context);
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
                                ElevatedButton(
                                  onPressed: () {
                                    controller.selectTime(context);
                                  },
                                  child: Text("Pick time"),
                                ),
                                Obx(() {
                                  final selectedTime =
                                      controller.selectedTime.value;

                                  final formattedTime =
                                      _formatTime(selectedTime);

                                  return Text(' ${formattedTime}');
                                }),

                                // DateTimeFormField(
                                //   dateFormat: DateFormat('dd-MM-yyyy'),
                                //   decoration: const InputDecoration(
                                //     hintStyle: TextStyle(color: Colors.black45),
                                //     // errorStyle: TextStyle(color: Colors.redAccent),
                                //     border: OutlineInputBorder(),
                                //     suffixIcon: Icon(Icons.event_note),
                                //     labelText: 'Select date',
                                //   ),
                                //   firstDate: DateTime.now(),
                                //   // initialValue: DateTime.tryParse(controller
                                //   //     .selectedFollowUpDate.value
                                //   //     .toIso8601String()),
                                //   // initialValue: DateTime.now(),
                                //   //initialDate: DateTime.now(),
                                //   // initialDate:
                                //   //     DateTime.now().add(new Duration(days: 7)),
                                //   mode: DateTimeFieldPickerMode.date,
                                //   autovalidateMode: AutovalidateMode.always,
                                //   // validator: FormBuilderValidators.compose([
                                //   //   FormBuilderValidators.required(),
                                //   // ]),
                                //   // onDateSelected: (DateTime value) {
                                //   //   controller.selectedFollowUpDate.value =
                                //   //       value;
                                //   // },
                                //   onChanged: (DateTime? value) {},
                                // ),
                              ],
                            )),
                        isActive: controller.currentStep >= 0,
                        state: controller.currentStep >= 1
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
                        ),
                        isActive: controller.currentStep >= 0,
                        state: controller.currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CarouselSlider(
                    options: CarouselOptions(height: 80.0, autoPlay: true),
                    items: [
                      "assets/images/crs.jpg",
                      "assets/images/ssgl.png",
                      "assets/images/tama.png",
                      "assets/images/espa.png",
                      "assets/images/gama.jpg"
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Image.asset('$i'));
                        },
                      );
                    }).toList(),
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

  Widget biodigesterServicing() {
    final int index1 = controller.getBiodigesterServiceIndex(1);
    final int index2 = controller.getBiodigesterServiceIndex(2);
    final int index3 = controller.getBiodigesterServiceIndex(3);

    return Column(children: [
      controller.biodigesterServicesAvailable.contains(1) && index1 != -1
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title: controller.biodigesterPricings[index1].name,
              subTitle:
                  controller.biodigesterPricings[index1].shortDesc.toString(),
              onPressed: () {
                controller.isSelected1.value = !controller.isSelected1.value;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[index1].biodigesterServiceId
                      .toInt(),
                  "unitCost":
                      controller.biodigesterPricings[index1].cost.toString(),
                  "name":
                      controller.biodigesterPricings[index1].name.toString(),
                });
              },
              price: "GHS " +
                  controller.biodigesterPricings[index1].cost.toString(),
              isSelected: controller.isSelected1.value,
              description: Text(""),
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(2) && index2 != -1
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title: controller.biodigesterPricings[index2].name,
              subTitle:
                  controller.biodigesterPricings[index2].shortDesc.toString(),
              onPressed: () {
                controller.isSelected2.value = !controller.isSelected2.value;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[index2].biodigesterServiceId
                      .toInt(),
                  "unitCost":
                      controller.biodigesterPricings[index2].cost.toString(),
                  "name":
                      controller.biodigesterPricings[index2].name.toString(),
                });
              },
              price: "GHS " +
                  controller.biodigesterPricings[index2].cost.toString(),
              isSelected: controller.isSelected2.value,
              description: Text(""),
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(3) && index3 != -1
          ? SubServiceWidget2(
              activeBgColor: MyColors.DarkBlue,
              inactiveBgColor: MyColors.SubServiceColor2,
              isAvailable: false,
              path: "assets/images/biodigester.png",
              size: 32,
              title: controller.biodigesterPricings[index3].name,
              subTitle:
                  controller.biodigesterPricings[index3].shortDesc.toString(),
              onPressed: () {
                controller.isSelected3.value = !controller.isSelected3.value;

                controller.addOrRemoveItem(controller.selectedServices, {
                  "id": controller
                      .biodigesterPricings[index3].biodigesterServiceId
                      .toInt(),
                  "unitCost":
                      controller.biodigesterPricings[index3].cost.toString(),
                  "name": controller.biodigesterPricings[index3].name.toString()
                });
              },
              price: "GHS " +
                  controller.biodigesterPricings[index3].cost.toString(),
              isSelected: controller.isSelected3.value,
              description: Text(""),
            )
          : SizedBox.shrink(),
    ]);
  }

  Widget biodigesterConstruction() {
    final int index4 = controller.getBiodigesterServiceIndex(4);
    final int index5 = controller.getBiodigesterServiceIndex(5);
    final int index6 = controller.getBiodigesterServiceIndex(6);

    print(controller.biodigesterPricings);

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      controller.biodigesterServicesAvailable.contains(4) && index4 != -1
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubServiceWidget2(
                  activeBgColor: MyColors.DarkBlue,
                  inactiveBgColor: MyColors.SubServiceColor2,
                  isAvailable: false,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: controller.biodigesterPricings[index4].name,
                  subTitle: controller.biodigesterPricings[index4].shortDesc
                      .toString(),
                  onPressed: () {
                    controller.isSelected4.value =
                        !controller.isSelected4.value;

                    controller.addOrRemoveItem(controller.selectedServices, {
                      "id": controller.biodigesterPricings[index4].id.toInt(),
                      "unitCost": controller.isStandard()
                          ? controller.biodigesterPricings[index4].standardCost
                              .toString()
                          : controller.isLarge()
                              ? controller.biodigesterPricings[index4].largeCost
                              : controller
                                  .biodigesterPricings[index4].doubleLargeCost,
                      "name": controller.biodigesterPricings[index4].name
                          .toString(),
                    });
                  },
                  price: controller.isStandard()
                      ? "GHS " +
                          controller.biodigesterPricings[index4].standardCost
                              .toString()
                      : controller.isLarge()
                          ? "GHS " +
                              controller.biodigesterPricings[index4].largeCost
                          : "GHS " +
                              controller
                                  .biodigesterPricings[index4].doubleLargeCost,
                  isSelected: controller.isSelected4.value,
                  description: Column(
                    children: [
                      Obx(() => Visibility(
                            visible: controller.isStandard(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Small digester",
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
                            visible: controller.isDoubleLarge(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Two large digesters",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(5) && index5 != -1
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubServiceWidget2(
                  activeBgColor: MyColors.DarkBlue,
                  inactiveBgColor: MyColors.SubServiceColor2,
                  isAvailable: false,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: controller.biodigesterPricings[index5].name,
                  subTitle: controller.biodigesterPricings[index5].shortDesc
                      .toString(),
                  onPressed: () {
                    controller.isSelected5.value =
                        !controller.isSelected5.value;

                    controller.addOrRemoveItem(controller.selectedServices, {
                      "id": controller.biodigesterPricings[index5].id.toInt(),
                      "unitCost": controller.isStandard()
                          ? controller.biodigesterPricings[index5].standardCost
                              .toString()
                          : controller.isLarge()
                              ? controller.biodigesterPricings[index5].largeCost
                              : controller
                                  .biodigesterPricings[index5].doubleLargeCost,
                      "name": controller.biodigesterPricings[index5].name
                          .toString(),
                    });
                  },
                  price: controller.isStandard()
                      ? "GHS " +
                          controller.biodigesterPricings[index5].standardCost
                              .toString()
                      : controller.isLarge()
                          ? "GHS " +
                              controller.biodigesterPricings[index5].largeCost
                          : "GHS " +
                              controller
                                  .biodigesterPricings[index5].doubleLargeCost,
                  isSelected: controller.isSelected5.value,
                  description: Column(
                    children: [
                      Obx(
                        () => Visibility(
                          visible: controller.totalUsers.value < 15,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "Small digester + seat",
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ),
                      ),
                      Obx(() => Visibility(
                            visible: controller.totalUsers.value > 15 &&
                                controller.totalUsers.value < 25,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Large digesters",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.totalUsers.value > 25,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Two large digesters + seat",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
      controller.biodigesterServicesAvailable.contains(6) && index6 != -1
          ? Column(
              children: [
                SubServiceWidget2(
                  activeBgColor: MyColors.DarkBlue,
                  inactiveBgColor: MyColors.SubServiceColor2,
                  isAvailable: false,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: controller.biodigesterPricings[index6].name,
                  subTitle: controller.biodigesterPricings[index6].shortDesc
                      .toString(),
                  onPressed: () {
                    controller.isSelected6.value =
                        !controller.isSelected6.value;
                    // controller.selectedColor3.value =
                    //     controller.selectedColor3.value == Colors.grey
                    //         ? Colors.teal
                    //         : Colors.grey;

                    controller.addOrRemoveItem(controller.selectedServices, {
                      "id": controller.biodigesterPricings[index6].id.toInt(),
                      "unitCost": controller.isStandard()
                          ? controller.biodigesterPricings[index6].standardCost
                              .toString()
                          : controller.isLarge()
                              ? controller.biodigesterPricings[index6].largeCost
                              : controller
                                  .biodigesterPricings[index6].doubleLargeCost,
                      "name": controller.biodigesterPricings[index6].name
                          .toString(),
                    });
                  },
                  price: controller.isStandard()
                      ? "GHS " +
                          controller.biodigesterPricings[index6].standardCost
                              .toString()
                      : controller.isLarge()
                          ? "GHS " +
                              controller.biodigesterPricings[index6].largeCost
                          : "GHS " +
                              controller
                                  .biodigesterPricings[index6].doubleLargeCost,
                  isSelected: controller.isSelected6.value,
                  description: Column(
                    children: [
                      Obx(() => Visibility(
                            visible: controller.isStandard(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Small Digester + Superstructure + Toilet Seat + Wash hand Basin",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.isLarge(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Large Digester + Superstructure + Toilet Seat + Wash hand basin",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: controller.isDoubleLarge(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Two large Digester + Superstructure + Toilet Seat + Wash hand basin",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
    ]);
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }
}
