import 'package:flutter/material.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/image-view.dart';

class PriceItemWidget extends StatelessWidget {
  const PriceItemWidget(
      {super.key,
      required this.path,
      required this.size,
      required this.title,
      required this.subTitle,
      this.onTap});

  final String path;
  final double size;
  final String title;
  final String subTitle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // color: Colors.indigo,
          decoration: BoxDecoration(
              color: MyColors.secondary.asMaterialColor.shade50,
              borderRadius: BorderRadius.all(Radius.circular(8))),
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
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    subTitle,
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
