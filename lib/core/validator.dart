// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

class Validator {
  static String? textFieldValidator1(String value, String msg) {
    log("textFieldValidator $value");
    if (value == null || value.trim() == "" || value == "null") {
      return msg;
    }
    return null;
  }

  static String? textFieldValidator(String value) {
    log("textFieldValidator $value");
    if (value == null || value.trim() == "" || value == "null") {
      return "Please enter value. Field cannot be empty.";
    }
    return null;
  }

  static String? dropdownValidator(String value) {
    if (value == "null" || value == "" || value == null || value == "0") {
      return "Please select an option.";
    }
    return null;
  }

  static String? multiSelectValidator(value) {
    if (value == null || value.length == 0) {
      return 'Please select one or more options';
    }
    return null;
  }

  static String? phoneValidator(String value) {
    if (value == "") {
      return "Please enter phone number";

      // if (value[1] != "2" && value[1] != "5") {
      //   return "Phone number must have with '2' or '5' in 2nd position ";
      // }
    }
    if ((value.length != 10)) {
      return "Please enter a valid phone number";
    }
    // if ((value != "" && value.length != 10) ||
    //     value[0] != "0" ||
    //     value[1] != "2" ||
    //     value[1] != "5") {
    //   return "Please enter a valid phone number";
    // }

    if (value[0] != "0") {
      return "Phone number must start with '0' ";
    }

    return null;
  }

  static String? passwordValidator(String value) {
    if ((value.trim().length < 8 || value.trim().length == 0)) {
      return "Password should be at least 8 characters";
    }

    return null;
  }

  static String? confirmPasswordValidator(String password, String cpassword) {
    if ((password.trim().length < 8 || password.trim().length == 0)) {
      return "Password should be at least 8 characters";
    }
    if (password != cpassword) {
      return "Passwords do no match";
    }

    return null;
  }
}
