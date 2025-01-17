import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/image-view.dart';
import 'package:line_icons/line_icons.dart';

import 'small-button.dart';

class ServiceWidget extends StatelessWidget {
  final String path;
  final double size;
  final String title;
  final String subTitle;
  final bool isAvailable;
  final GestureTapCallback? onTap;
  ServiceWidget(
      {super.key,
      required this.path,
      required this.size,
      required this.title,
      required this.subTitle,
      this.onTap,
      required this.isAvailable});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: isAvailable
            ? onTap
            : () {
                Get.dialog(
                  AlertDialog(
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          //child: CircularProgressIndicator(),
                        ),
                        Text("Service unavailable"),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "This service is not available at your location at the moment.\nKindly check back later.\n\n Thank you!"),
                        SizedBox(
                          height: 10.0,
                        ),
                        SmallButton(
                          onPressed: () {
                            Get.back();
                          },
                          showLoading: false,
                          label: Text("OK"),
                        )
                      ],
                    ),
                  ),
                  barrierDismissible: false,
                );
              },
        child: Container(
          // color: Colors.indigo,
          decoration: BoxDecoration(
            // color: isAvailable
            //     ? MyColors.SecondaryColor.asMaterialColor.shade500
            //     : MyColors.SecondaryColor.asMaterialColor.shade50,
            color: isAvailable
                ? MyColors.secondary.asMaterialColor.shade50
                : MyColors.secondary.asMaterialColor.shade50,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            // border: Border.all(
            //   color: MyColors.SecondaryColor.asMaterialColor
            //       .shade100, // Set the border color here
            //   width: 2.0, // Set the border width
            // ),
            border: Border.all(
              color: MyColors.secondary.asMaterialColor
                  .shade200, // Set the border color here
              width: 1.0, // Set the border width
            ),
          ),

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ImageView(
                      path: path,
                      size: 40,
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(4.0),
                  //   child: Visibility(
                  //     visible: !isAvailable,
                  //     child: Icon(
                  //       Icons.lock_outline,
                  //       color: MyColors.primary,
                  //       size: 16,
                  //     ),
                  //   ),
                  // )
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Visibility(
                      visible: !isAvailable,
                      child: Icon(
                        LineIcons.lock,
                        size: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        subTitle,
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
