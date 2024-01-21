import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_page_controller.dart';

class LoginPageView extends GetView<AuthPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginViewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LoginViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
