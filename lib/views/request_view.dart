import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icesspool/widgets/service-widget.dart';

import 'package:icesspool/themes/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';

import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/request_controller.dart';
import '../core/validator.dart';
import '../widgets/dropdown.dart';
import '../widgets/text-box.dart';

class RequestView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final controller = Get.put(RequestController());

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.635264, -0.188335),
    zoom: 12,
    tilt: 59.440717697143555,
    bearing: 12.8334901395799,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  RequestView({Key? key}) : super(key: key);

  void lol() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const InteractiveBottomSheet(
        options: InteractiveBottomSheetOptions(
            expand: false, minimumSize: 0.25, maxSize: 0.5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ServiceWidget(
                    path: "assets/images/toilet-tanker.png",
                    size: 32,
                    title: 'Emptying',
                    subTitle: 'Empty your cesspit',
                  ),
                ),
                Expanded(
                  child: ServiceWidget(
                    path: "assets/images/water-tanker.png",
                    size: 32,
                    title: 'Bulk Water',
                    subTitle: 'Request for water',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ServiceWidget(
                    path: "assets/images/biodigester.png",
                    size: 32,
                    title: 'Biogester',
                    subTitle: 'Service or build',
                    onTap: () {
                      print('Container tapped!');
                    },
                  ),
                ),
                Expanded(
                  child: ServiceWidget(
                    path: "assets/images/more.png",
                    size: 32,
                    title: 'More',
                    subTitle: 'Read more',
                  ),
                ),
              ],
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(
                'Biogester',
                style: TextStyle(fontSize: 12),
              ),
              leading: Icon(Icons.history),
              subtitle: Text(
                'Dansoman - 21/11/2023',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Divider(),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(
                'Bulk Water',
                style: TextStyle(fontSize: 12),
              ),
              leading: Icon(Icons.history),
              subtitle: Text(
                'Sowutuom - 11/01/2023',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        draggableAreaOptions: DraggableAreaOptions(
          //topBorderRadius: 20,
          // height: 75,
          // backgroundColor: Colors.grey,
          indicatorColor: Color.fromARGB(255, 230, 230, 230),
          indicatorWidth: 40,
          indicatorHeight: 5,
          indicatorRadius: 10,
        ),
      ),
      body: GoogleMap(
        mapToolbarEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
        onMapCreated: controller.onMapCreated,
        markers: Set<Marker>.of(controller.markers.values),
      ),
    );

    // GoogleMap(
    //   mapType: MapType.hybrid,
    //   initialCameraPosition: _kGooglePlex,
    //   onMapCreated: (GoogleMapController controller) {
    //     _controller.complete(controller);
    //   },
    // );
  }
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

Widget stepperUI(context) {
  final controller = Get.put(HomeController());
  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();

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
// int currentStep = 0;
// bool completed = false;


