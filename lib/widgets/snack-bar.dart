import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../themes/colors.dart';

class MySnackbar {
  static showError({title, message}) {
    Get.snackbar(title, message,
        backgroundColor: MyColors.Red,
        icon: Icon(Icons.info_outline, color: MyColors.White),
        colorText: MyColors.White);
  }

  static showSuccess({title, message}) {
    Get.snackbar(title, message,
        backgroundColor: MyColors.Green,
        icon: Icon(Icons.info_outline, color: MyColors.White),
        colorText: MyColors.White);
  }
}
