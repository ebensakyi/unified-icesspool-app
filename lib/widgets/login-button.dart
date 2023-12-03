import 'package:flutter/material.dart';

import '../themes/colors.dart';

class LoginButton extends StatelessWidget {
  final onPressed;
  final showLoading;
  const LoginButton(
      {Key? key, required this.onPressed, required this.showLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          // icon: Icon(Icons.send_outlined),
          child: Stack(children: [
            Visibility(
                maintainSize: false,
                visible: !showLoading,
                child: Text("Login")),
            Visibility(
              maintainSize: false,
              visible: showLoading,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          ]),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 1, 121, 105),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }
}
