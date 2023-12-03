import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final onPressed;
  final showLoading;
  final dynamic label;
  final dynamic backgroundColor;
  const SmallButton(
      {Key? key,
      required this.onPressed,
      required this.showLoading,
      this.label = "OK",
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 30,
        width: 80,
        child: ElevatedButton(
          onPressed: onPressed,
          // icon: Icon(Icons.send_outlined),
          child: Stack(children: [
            Visibility(
                maintainSize: false, visible: !showLoading, child: Text(label)),
            Visibility(
              maintainSize: false,
              visible: showLoading,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          ]),
          style: ElevatedButton.styleFrom(
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
