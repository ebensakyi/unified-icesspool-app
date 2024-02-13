import 'package:flutter/material.dart';
import 'package:icesspool/themes/colors.dart';

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
  final Widget description;

  SubServiceWidget2({
    Key? key,
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
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.primary, // Border color
              width: 2.0, // Border width
            ),
            color: MyColors.primary.withOpacity(0.1), // Background color
            borderRadius: BorderRadius.circular(12.0), // Border radius
          ),
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  backgroundColor: Colors.transparent, // Transparent background
                ),
                child: Row(
                  children: [
                    Icon(Icons.list_alt_sharp),
                    SizedBox(width: 8),
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
                              SizedBox(width: 24.0),
                              Visibility(
                                visible: isSelected,
                                child: Icon(Icons.check_box_outlined),
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
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: description, // Align description to the left
              ),
            ],
          ),
        ),
      ),
    );
  }
}
