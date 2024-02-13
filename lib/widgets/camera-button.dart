// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CameraButton extends StatefulWidget {
  final onPressed;
  final text;
  dynamic icon;
  CameraButton({Key? key, this.onPressed, this.text, this.icon})
      : super(key: key);

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton.icon(
          onPressed: widget.onPressed,
          icon: widget.icon,
          label: Text(widget.text),
        ),
      ),
    );
  }
}
