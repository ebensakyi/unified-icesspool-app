import 'package:flutter/material.dart';

class ProgressTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  // final IconData iconData;
  final String label;

  ProgressTextButton({
    required this.onPressed,
    required this.isLoading,
    // required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.teal),
          ),
          backgroundColor: Colors.teal),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}