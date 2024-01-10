import 'package:flutter/material.dart';

class ProgressButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData iconData;
  final String label;
  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final Color progressColor;

  ProgressButton({
    required this.onPressed,
    required this.isLoading,
    required this.iconData,
    required this.label,
    required this.borderColor,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: borderColor),
          ),
          backgroundColor: Colors.teal),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLoading
              ? SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.teal,
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                )
              : Icon(iconData, color: iconColor),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(color: isLoading ? Colors.teal : textColor),
          ),
        ],
      ),
    );
  }
}
