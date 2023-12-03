import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final onPressed;
  const CaptureButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.camera_alt_outlined),
        onPressed: onPressed,
      ),
    );
  }
}
