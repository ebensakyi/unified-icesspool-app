import 'package:flutter/material.dart';

import '../themes/colors.dart';

class SubmitButton extends StatelessWidget {
  final onPressed;
  const SubmitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(Icons.send_outlined),
          label: Text("Submit"),
          style: ElevatedButton.styleFrom(
            primary: MyColors.BtnDark,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0),
            ),
          ),
        ),
      ),
    );
  }
}
