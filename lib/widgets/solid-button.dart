import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final onPressed;
  final showLoading;
  final Color buttonColor;
  final Color textColor;
  final Text label;
  const SolidButton(
      {Key? key,
      required this.onPressed,
      required this.showLoading,
      required this.buttonColor,
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
                backgroundColor: Colors.white,
              ),
            )
          ]),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
