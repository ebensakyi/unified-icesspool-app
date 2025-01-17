import 'package:flutter/material.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/image-view.dart';

class ServiceWidget2 extends StatelessWidget {
  final String path;
  final double size;
  final String title;
  final String subTitle;
  final bool isAvailable;
  final GestureTapCallback? onTap;
  ServiceWidget2(
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
        onTap: isAvailable ? onTap : null,
        child: Container(
          // color: Colors.indigo,
          decoration: BoxDecoration(
            color: isAvailable
                ? MyColors.secondary.asMaterialColor.shade500
                : MyColors.secondary.asMaterialColor.shade50,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: MyColors.secondary.asMaterialColor
                  .shade100, // Set the border color here
              width: 2.0, // Set the border width
            ),
          ),

          child: Row(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ImageView(
                path: path,
                size: 48,
              ),
            ),
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
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Visibility(
                          visible: !isAvailable,
                          child: Icon(
                            Icons.lock_outline,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    subTitle,
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
