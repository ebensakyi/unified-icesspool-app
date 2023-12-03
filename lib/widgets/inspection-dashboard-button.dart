import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/insets.dart';

class DashboardBtn extends StatelessWidget {
  final String title;
  final String description;
  final Color color1, color2;
  final IconData icon;

  const DashboardBtn(
      {required this.title,
      required this.description,
      required this.color1,
      required this.color2,
      Key? key,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color1,
            color2,
          ],
        )),
        // height: MediaQuery.of(context).size.height * 0.40,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Padding(
          padding: EdgeInsets.all(MyInsets.sx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: MyInsets.ms,
                        color: MyColors.White,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(icon, size: 30, color: MyColors.White)
                ],
              ),
              Text(
                description,
                style: TextStyle(fontSize: MyInsets.s, color: MyColors.White),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
