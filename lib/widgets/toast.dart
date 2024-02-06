import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

customToast(context,
    {required message, required Color backgroundColor, required position}) {
  showToast(
    backgroundColor: backgroundColor,
    message,
    context: context,
    animation: StyledToastAnimation.scale,
    duration: Duration(seconds: 4),
    position: position,
  );
}
