import 'package:flutter/material.dart';

import '../themes/colors.dart';

class OutlineButton extends StatelessWidget {
  final onPressed;
  final showLoading;
  final borderColor;
  final textColor;
  final label;
  const OutlineButton(
      {Key? key,
      required this.onPressed,
      required this.showLoading,
      required this.borderColor,
      required this.textColor,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // height: 50,
        // width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,

          // icon: Icon(Icons.send_outlined),
          child: Stack(children: [
            Visibility(
                maintainSize: false, visible: !showLoading, child: label),
            Visibility(
              maintainSize: false,
              visible: showLoading,
              child: CircularProgressIndicator(
                backgroundColor: borderColor,
              ),
            )
          ]),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: borderColor),
            ),
          ),
        ),
      ),
    );
  }
}
