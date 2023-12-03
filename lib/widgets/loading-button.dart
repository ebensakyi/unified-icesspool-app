import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final onPressed;
  final showLoading;
  final label;
  final color;
  const LoadingButton(
      {Key? key,
      required this.onPressed,
      required this.showLoading,
      this.label,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
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
            backgroundColor: color,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
