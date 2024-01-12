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
  final Color selectedColor;
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
    this.selectedColor = const Color.fromARGB(255, 230, 225, 225),
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
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: selectedColor), // No rounded borders
          ),
          // backgroundColor: this.activeBgColor
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: Colors.black87),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.check_circle_outline_outlined),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    price,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ), // Replace with your desired text
          ],
        ),
      ),
    );
  }
}
