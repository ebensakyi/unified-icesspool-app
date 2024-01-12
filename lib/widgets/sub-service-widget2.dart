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
  final bool isSelected;
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
    required this.isSelected,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Make the container fill the width of the screen
      padding: EdgeInsets.all(16.0), // Add padding as needed
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide(color: Colors.teal), // No rounded borders
              ),
              backgroundColor: Colors.white,
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                // ImageView(path: path, size: size),
                Icon(Icons.list_alt_sharp),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: TextStyle(color: Colors.black87),
                            ),
                            SizedBox(width: 24.0),
                            Visibility(
                              visible: isSelected,
                              child: Icon(Icons.check_box_outlined),
                            )
                          ],
                        ),
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
        ],
      ),
    );
  }
}
