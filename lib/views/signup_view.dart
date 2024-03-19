import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icesspool/views/about_view.dart';
import 'package:icesspool/widgets/progress-button.dart';

import '../controllers/signup_controller.dart';
import '../core/mask_formatter.dart';
import '../core/validator.dart';
import '../themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';

import '../widgets/progress-icon-button.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Signup"),
        ),
        body: Container(child: TextField()));
  }
}
