// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:video_player/video_player.dart';

// import '../controllers/report_controller.dart';
// import '../controllers/login_controller.dart';

// class LoginView extends GetView<LoginController> {
//   final LoginController _controller = Get.put(LoginController());
//   var _formKey = GlobalKey<FormState>();
//   final _minimumPadding = 5.0;
//   bool _checkBoxValue = false;
//   bool _passwordVisible = false;

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   LoginView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextStyle? largeTextStyle = Theme.of(context).textTheme.headline4;
//     TextStyle? smallTextStyle = Theme.of(context).textTheme.headline6;

//     final ButtonStyle btnStyle1 = ElevatedButton.styleFrom(
//         textStyle: const TextStyle(fontSize: 20),
//         primary: Colors.blue[900],
//         elevation: 0,
//         padding: EdgeInsets.all(15.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ));
//     final ButtonStyle btnStyle2 = ElevatedButton.styleFrom(
//       textStyle: const TextStyle(
//         fontSize: 20,
//       ),
//       primary: Theme.of(context).primaryColorDark,
//       onPrimary: Theme.of(context).primaryColorLight,
//     );

//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text("Long List"),
//       // ),
//       body: Form(
//         key: _controller.loginFormKey,
//         child: Padding(
//             padding: EdgeInsets.all(_minimumPadding * 8),
//             child: ListView(
//               children: <Widget>[
//                 Container(
//                   height: 40.0,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: _minimumPadding, bottom: _minimumPadding),
//                   child: Text("Register!",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 40)),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: _minimumPadding, bottom: _minimumPadding),
//                   child: Text(
//                     "Enter your details to continue",
//                     style: TextStyle(
//                         color: Colors.grey[500],
//                         fontWeight: FontWeight.normal,
//                         fontSize: 20),
//                   ),
//                 ),
//                 Container(
//                   height: 50.0,
//                 ),

//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: _minimumPadding, bottom: _minimumPadding),
//                   child: TextFormField(
//                       keyboardType: TextInputType.number,
//                       style: smallTextStyle,
//                       controller: emailController,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                       },
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.person_outlined),
//                         labelText: 'Name',
//                         //hintText: 'Enter email',
//                         labelStyle: smallTextStyle,
//                         // border: OutlineInputBorder(
//                         //   borderRadius: BorderRadius.circular(5.0),
//                         // ),
//                       )),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: _minimumPadding, bottom: _minimumPadding),
//                   child: TextFormField(
//                       keyboardType: TextInputType.emailAddress,
//                       style: smallTextStyle,
//                       controller: emailController,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter email';
//                         }
//                       },
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.alternate_email_outlined),
//                         labelText: 'Email',
//                         //hintText: 'Enter email',
//                         labelStyle: smallTextStyle,
//                         // border: OutlineInputBorder(
//                         //   borderRadius: BorderRadius.circular(5.0),
//                         // ),
//                       )),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: _minimumPadding, bottom: _minimumPadding),
//                   child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       style: smallTextStyle,
//                       controller: emailController,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter phone';
//                         }
//                       },
//                       decoration: InputDecoration(
//                         icon: Icon(Icons.phone_android_outlined),
//                         labelText: 'Phone number',
//                         //hintText: 'Enter email',
//                         labelStyle: smallTextStyle,
//                         // border: OutlineInputBorder(
//                         //   borderRadius: BorderRadius.circular(5.0),
//                         // ),
//                       )),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: _minimumPadding, bottom: _minimumPadding),
//                   child: TextFormField(
//                     obscureText: _passwordVisible,
//                     style: smallTextStyle,
//                     controller: passwordController,
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter password';
//                       }
//                     },
//                     decoration: InputDecoration(
//                       //prefixIcon: Icon(Icons.lock_open_outlined),
//                       suffixIcon: IconButton(
//                           onPressed: () {
//                             //debugPrint(_passwordVisible);
//                             _passwordVisible = !_passwordVisible;
//                           },
//                           icon: Icon(
//                             // Based on passwordVisible state choose the icon
//                             _passwordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                             color: Theme.of(context).primaryColorDark,
//                           )),
//                       icon: Icon(Icons.lock_open_outlined),
//                       labelText: 'Password',
//                       //hintText: 'Enter password',
//                       labelStyle: smallTextStyle,

//                       // border: OutlineInputBorder(
//                       //   borderRadius: BorderRadius.circular(5.0),
//                       // ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: _minimumPadding, bottom: _minimumPadding),
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         width: _minimumPadding * 5,
//                       ),
//                       Expanded(
//                         child: CheckboxListTile(
//                             title: Text('Remember me'),
//                             // secondary: Icon(Icons.email_outlined),
//                             controlAffinity: ListTileControlAffinity.trailing,
//                             value: _checkBoxValue,
//                             onChanged: (newValue) {
//                               // setState(() {
//                               debugPrint("New val is :$newValue");
//                               _checkBoxValue = !_checkBoxValue;
//                               // });
//                             },
//                             activeColor: Colors.blue,
//                             checkColor: Colors.black12),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       bottom: _minimumPadding, top: _minimumPadding),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           child: ElevatedButton(
//                         style: btnStyle1,
//                         child: Text(
//                           "Login",
//                         ),
//                         onPressed: () {
//                           // setState(() {
//                           if (_formKey.currentState!.validate()) {
//                             // this.displayResult = _calculateTotalReturns();
//                           }
//                           // });
//                         },
//                       )),
//                     ],
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: EdgeInsets.all(_minimumPadding * 2),
//                 //   child: Text(this.displayResult),
//                 // )
//               ],
//             )),
//       ),
//     );
//   }
// }
