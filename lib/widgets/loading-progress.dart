// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class LoadingProgress extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var brightness =
//         MediaQuery.of(context).platformBrightness == Brightness.light;
//     ;
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(
//           valueColor: new AlwaysStoppedAnimation<Color>(
//               Color.fromARGB(255, 177, 121, 10)),
//         ),
//       ),
//       backgroundColor: brightness
//           ? Colors.white.withOpacity(0.70)
//           : Colors.black.withOpacity(
//               0.70), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
//     );
//   }
// }
