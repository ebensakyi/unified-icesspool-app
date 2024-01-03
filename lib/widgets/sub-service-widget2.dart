import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/image-view.dart';

import 'small-button2.dart';

class SubServiceWidget2 extends StatelessWidget {
  final String path;
  final double size;
  final String price;
  final String title;
  final String subTitle;
  final bool isAvailable;
  final VoidCallback? onPressed;
  final Color activeBgColor;
  final Color inactiveBgColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  SubServiceWidget2({
    super.key,
    required this.path,
    required this.size,
    required this.title,
    required this.subTitle,
    this.onPressed,
    required this.isAvailable,
    required this.activeBgColor,
    required this.inactiveBgColor,
    this.activeTextColor = Colors.black,
    this.inactiveTextColor = Colors.white,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make the container fill the width of the screen
      padding: EdgeInsets.all(16.0), // Add padding as needed
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(10)), // No rounded borders
          ),
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            ImageView(path: path, size: size),
            // Icon(Icons.add), // Replace with your desired icon
            SizedBox(width: 8), // Adjust the spacing between icon and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(price),
                ),
              ],
            ), // Replace with your desired text
          ],
        ),
      ),
    );
  }
}
