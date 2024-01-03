import 'package:flutter/material.dart';

class SmallButton2 extends StatelessWidget {
  final onPressed;
  final showLoading;
  final dynamic label;
  final dynamic backgroundColor;
  const SmallButton2(
      {Key? key,
      required this.onPressed,
      required this.showLoading,
      this.label,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 30,
        child: ElevatedButton(
          onPressed: onPressed,
          // icon: Icon(Icons.send_outlined),
          child: Stack(children: [
            Visibility(
                maintainSize: false,
                visible: !showLoading,
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white),
                )),
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
