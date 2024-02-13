import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/small-button.dart';
import '../controllers/auth_page_controller.dart';

// MediaQuery.of(context).size.height -    kToolbarHeight -
//   MediaQuery.of(context).padding.top -
//   kBottomNavigationBarHeight
class RegisterSelectionPageView extends GetView<AuthPageController> {
  RegisterSelectionPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select User Type'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.teal,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image.asset("assets/images/regular_user.png",
                              width: 100),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Click on the button below to request our service"),
                          ),
                          SmallButton(
                            backgroundColor: Colors.teal,
                            onPressed: () {
                              // Get.toNamed(Routes.REGISTER_REGULAR_USER_PAGE);
                            },
                            showLoading: false,
                            label: "Request our services",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image.asset("assets/images/tanker.png", width: 100),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Click on the button below to become a service provider"),
                          ),
                          SmallButton(
                            backgroundColor: Colors.teal,
                            onPressed: () {
                              // Get.toNamed(
                              //     Routes.REGISTER_SERVICE_PROVIDER_PAGE);
                            },
                            showLoading: false,
                            label: "Become a service provider",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
