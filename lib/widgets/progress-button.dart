import 'package:flutter/material.dart';
import 'package:icesspool/themes/colors.dart';

class ProgressButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final Color progressColor;

  ProgressButton({
    required this.onPressed,
    required this.isLoading,
    required this.label,
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: borderColor),
            ),
            backgroundColor: MyColors.primary),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLoading
                ? SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      backgroundColor: MyColors.primary,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                        color: isLoading ? MyColors.primary : textColor),
                  ),
          ],
        ),
      ),
    );
  }
}
