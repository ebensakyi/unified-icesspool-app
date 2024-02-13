import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final onPressed;
  final showLoading;
  final label;
  final textColor;
  final dynamic backgroundColor;
  const SmallButton(
      {Key? key,
      required this.onPressed,
      required this.showLoading,
      this.label,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
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
                backgroundColor: Colors.white,
              ),
            )
          ]),
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: backgroundColor,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
