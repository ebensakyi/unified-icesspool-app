import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:icesspool/contants.dart';

import 'package:icesspool/themes/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:icesspool/views/about_view.dart';
import 'package:icesspool/views/report_history_view.dart';

import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../core/validator.dart';
import '../widgets/button.dart';
import '../widgets/camera-button.dart';
import '../widgets/custom-animated-bottom-bar.dart';
import '../widgets/dropdown.dart';
import '../widgets/text-box.dart';

class ReportView extends StatelessWidget {
  final controller = Get.put(HomeController());
  final loginController = Get.put(LoginController());
  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();

//   PersistentTabController persistentTabController;

// persistentTabController = PersistentTabController(initialIndex: 0);

  ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                                      borderRadius: BorderRadius.circular(6)),
                                  height: 35,
                                  child: TextButton(
                                    onPressed: () {
                                      controller.sendReport();
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
            subtitle: Text('Enter location info here'),
            title: const Text('Location Info'),
            content: Form(
              key: formKey1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  Obx(
                    () => Dropdown(
                      onChangedCallback: (newValue) {
                        controller.selectedReportType.value = newValue;
                        controller.getAddressFromCoords();
                      },
                      value: controller
                          .returnValue(controller.selectedReportType.value),
                      initialValue: controller
                          .returnValue(controller.selectedReportType.value),
                      dropdownItems: [
                        DropdownMenuItem(
                          child: Text("I am at the location"),
                          value: "1",
                        ),
                        DropdownMenuItem(
                          child: Text("I am at a diff. location"),
                          value: "2",
                        ),
                      ],
                      hintText: '',
                      labelText: "Where are you reporting from? *",
                      validator: (value) {
                        return Validator.dropdownValidator(value);
                      },
                    ),
                  ),
                  Obx(() => Visibility(
                        visible: controller.selectedReportType == "1",
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            "${controller.address.value}",
                            style: TextStyle(
                                fontSize: 10, color: Colors.amber.shade700),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 50,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          // errorText: widget.errorText,
                          labelText: 'Search for district *',
                          filled: true,
                          fillColor: MyColors.White,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide.none,
                          ),
                        ),
                        child: Obx(
                          () => DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: controller.districts
                                .map((element) => element.name)
                                .toList(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                labelText: "",
                                hintText: "Select your MMDA",
                              ),
                            ),
                            onChanged: (value) {
                              controller.selectedDistrict.value =
                                  value.toString();
                              controller.selectedDistrictId.value =
                                  controller.getItemId(value);
                            },
                            selectedItem: controller.selectedDistrict.value,
                            validator: (value) {
                              return Validator.dropdownValidator(value!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextBox(
                    controller: controller.communityController,
                    labelText: 'Community & Landmark*',
                    maxLength: 50,
                    validator: (value) {
                      return Validator.textFieldValidator(value);
                    },
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
            title: new Text(
              'Report details',
            ),
            subtitle: Text('Enter report here'),
            content: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey2,
              child: Column(
                children: <Widget>[
                  Obx(
                    () => Dropdown(
                      onChangedCallback: (newValue) {
                        controller.selectedReportCategory.value = newValue;
                      },
                      value: controller
                          .returnValue(controller.selectedReportCategory.value),
                      initialValue: controller
                          .returnValue(controller.selectedReportCategory.value),
                      dropdownItems: controller.reportCategories.map((var obj) {
                        return DropdownMenuItem<String>(
                          child: Text(obj.name.toString()),
                          value: obj.id.toString(),
                        );
                      }).toList(),
                      hintText: '',
                      labelText: "Select category of report *",
                      validator: (value) {
                        return Validator.dropdownValidator(value);
                      },
                    ),
                  ),
                  TextBox(
                      controller: controller.descriptionController,
                      labelText: 'Description of nuisance ',
                      maxLines: 3,
                      // validator: (value) {
                      //   return Validator.textFieldValidator(value);
                      // },
                      maxLength: 120),
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
                Obx(
                  () => Visibility(
                    maintainState: false,
                    visible: controller.selectedReportType.value == "1",
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CameraButton(
                        onPressed: () {
                          controller.getImage(ImageSource.camera);
                        },
                        text: "Capture picture from camera *",
                        icon: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ),
                ),
                Obx(() => Visibility(
                      maintainState: false,
                      visible: controller.selectedReportType.value == "2",
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CameraButton(
                          onPressed: () {
                            controller.getImage(ImageSource.gallery);
                          },
                          text: "Add a picture from gallery *",
                          icon: Icon(Icons.photo),
                        ),
                      ),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Visibility(
                        maintainSize: false,
                        visible: controller.selectedImagePath.value != "",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.file(
                            File(controller.selectedImagePath.value),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            isActive: controller.currentStep >= 0,
            state: controller.currentStep >= 2
                ? StepState.complete
                : StepState.disabled,
          ),
        ],
      ),
    );
  }
}

// int currentStep = 0;
// bool completed = false;
