import 'package:flutter/material.dart';

class MyColors {
  static const Cyan1 = Color(0xff2E4D50);
  static const Cyan2 = Color(0xff1A292C);

  static const Orange = Color(0xffFF3E00);

  static const MainColor = Color(0xff9C3848);
  static const SecondaryColor = Color(0xff9C3848);
  static const White = Color(0xfffffffff);
  static const Green = Color.fromARGB(255, 2, 79, 3);

  static const Red = Color.fromARGB(255, 140, 0, 0);
  static const Bg = Color(0xffEEEFFA);
  static const Bg2 = Color(0xffF5F6FB);

  static const DarkBlue = Color(0xff0B276A);
  static const DarkBlue3 = Color.fromARGB(255, 10, 35, 92);

  static const DarkBlue1 = Color(0xff2F358C);
  static const DarkBlue2 = Color(0xff363C9C);
  static const DarkRed = Color.fromARGB(255, 136, 5, 2);
  static const DarkRed1 = Color.fromARGB(255, 90, 3, 1);

  static const DarkTeal = Color(0xff036C79);
  static const DarkTeal1 = Color.fromARGB(255, 0, 58, 66);

  static const NotPink = Color.fromARGB(255, 144, 0, 14);
  static const NotPink1 = Color.fromARGB(255, 204, 36, 53);

  static const AppBarBackgroundColor = Color.fromARGB(255, 255, 255, 255);
  static const AppBarForegroundColor = Color(0xff036C79);

  static const BtnDark = Color(0xff036C79);

  static var Yellow = Color.fromARGB(255, 204, 165, 10);

  static var Yellow2 = Color.fromARGB(255, 154, 124, 3);

  static var Green1 = Color(0xff036C79);

  static var lightColor = Color(0xffE3F0F9);
}

extension ToMaterialColor on Color {
  MaterialColor get asMaterialColor {
    Map<int, Color> shades = [
      50,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900
    ].asMap().map(
        (key, value) => MapEntry(value, withOpacity(1 - (1 - (key + 1) / 10))));

    return MaterialColor(value, shades);
  }
}
