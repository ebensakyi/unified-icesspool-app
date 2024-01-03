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
  final GestureTapCallback? onTap;
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
    this.onTap,
    required this.isAvailable,
    required this.activeBgColor,
    required this.inactiveBgColor,
    this.activeTextColor = Colors.black,
    this.inactiveTextColor = Colors.white,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // color: Colors.indigo,
          decoration: BoxDecoration(
            color: isAvailable ? activeBgColor : inactiveBgColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: MyColors.SecondaryColor.asMaterialColor
                  .shade100, // Set the border color here
              width: 2.0, // Set the border width
            ),
          ),

          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(3.0),
                child: ImageView(
                  path: path,
                  size: 60,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: activeTextColor),
                        ),
                        // Icon(
                        //   Icons.info_outline,
                        //   size: 16,
                        // )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: subTitle == "null" ? false : true,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        subTitle,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                            color: activeTextColor),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  // SmallButton2(
                  //     label: "Learn More",
                  //     onPressed: null,
                  //     showLoading: false),
                  // Checkbox(value: true, onChanged: null)
                  Text(
                    price.toString(),
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                        color: activeTextColor),
                  )
                  //   ],
                  // )
                  ,

                  Row(
                    children: [
                      SmallButton2(
                          label: "Learn More",
                          onPressed: null,
                          showLoading: false),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
