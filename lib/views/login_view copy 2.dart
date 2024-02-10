// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import '../controllers/login_controller.dart';
// import '../core/authentication_service.dart';

// class LoginView extends StatelessWidget {
//   final controller = Get.put(LoginController());

//   LoginView({Key? key}) : super(key: key);

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final _minimumPadding = 2.0;
//   final maxLines = 5;

//   final ButtonStyle btnStyle1 = ElevatedButton.styleFrom(
//       textStyle: const TextStyle(fontSize: 18),
//       backgroundColor: Colors.white,
//       elevation: 5,
//       padding: const EdgeInsets.all(0.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5.0),
//       ));

//   final ButtonStyle btnStyle2 = ElevatedButton.styleFrom(
//       textStyle: const TextStyle(fontSize: 18),
//       backgroundColor: Colors.amber[900],
//       elevation: 5,
//       padding: const EdgeInsets.all(0.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5.0),
//       ));

//   final ButtonStyle flatBtnStyle1 = ElevatedButton.styleFrom(
//       textStyle: const TextStyle(fontSize: 18),
//       backgroundColor: const Color.fromARGB(255, 195, 229, 252),
//       elevation: 0,
//       padding: const EdgeInsets.all(0.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ));
//   final ButtonStyle flatBtnStyle2 = ElevatedButton.styleFrom(
//       textStyle: const TextStyle(fontSize: 18),
//       backgroundColor: const Color.fromARGB(255, 5, 84, 136),
//       elevation: 0,
//       padding: const EdgeInsets.all(10.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ));
//   @override
//   Widget build(BuildContext context) {
//     var _formKey = GlobalKey<FormState>();
//     const _minimumPadding = 5.0;

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: const Color(0xFFFFFFFF),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           forceMaterialTransparency: true,
//           elevation: 0,
//           title: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   onTap: () {
//                    // Get.off(() => RequestView());
//                   },
//                   child: Text(
//                     "Skip",
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: Form(
//           key: _formKey,
//           child: Padding(
//               padding: const EdgeInsets.all(_minimumPadding * 8),
//               child: ListView(
//                 children: <Widget>[
//                   Container(
//                     height: 10.0,
//                   ),
//                   Container(
//                     height: 40.w,
//                     color: const Color(0xFFFFFFFF),
//                     child: Column(
//                       children: <Widget>[
//                         getImageAsset("assets/images/logo.png", 150.0),
//                         const Padding(
//                           padding: EdgeInsets.only(
//                               top: _minimumPadding, bottom: _minimumPadding),
//                           // child: Center(
//                           //   child: Text("Point-2-Point",
//                           //       style: TextStyle(
//                           //           color: Colors.white,
//                           //           fontWeight: FontWeight.bold,
//                           //           fontSize: 30)),
//                           // ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   // const Padding(
//                   //   padding: EdgeInsets.only(
//                   //       top: _minimumPadding * 0, bottom: _minimumPadding),
//                   //   child: Align(
//                   //     alignment: Alignment.center,
//                   //     child: Text(
//                   //       "SANITATION REPORTER",
//                   //       style: TextStyle(
//                   //         color: Colors.black,
//                   //         fontWeight: FontWeight.bold,
//                   //         fontSize: 20,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   Container(
//                     child: const Padding(
//                       padding: EdgeInsets.only(
//                           top: _minimumPadding, bottom: _minimumPadding * 5),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Report nuisances directly to your MMDA",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
//                         height: maxLines * 8.0,
//                         child: TextField(
//                           controller: emailController,
//                           maxLines: maxLines,
//                           decoration: InputDecoration(
//                             hintText: "Enter your email",
//                             fillColor: Colors.grey[300],
//                             filled: false,
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 20.0),
//                             border: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 2, 88, 128),
//                                   width: 1.0),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 2, 88, 128),
//                                   width: 2.0),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
//                         height: maxLines * 8.0,
//                         child: TextField(
//                           controller: passwordController,
//                           maxLines: maxLines,
//                           decoration: InputDecoration(
//                             hintText: "Enter your passwoord",
//                             fillColor: Colors.grey[300],
//                             filled: false,
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 20.0),
//                             border: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 2, 88, 128),
//                                   width: 1.0),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 2, 88, 128),
//                                   width: 2.0),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
//                         child: ElevatedButton(
//                             child: Row(
//                               children: const [
//                                 // getSmallImageAsset(
//                                 //     "assets/images/google.png", 24.0),
//                                 Expanded(
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "Sign up",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 14),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             style: flatBtnStyle2,
//                             onPressed: () {
//                               context.read<AuthenticationService>().signUp(
//                                   email: emailController.text,
//                                   password: passwordController.text);
//                             }),
//                       ),
//                       Container(
//                         alignment: Alignment.center,
//                         child: const Text("OR"),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: _minimumPadding, bottom: _minimumPadding),
//                         child: ElevatedButton(
//                             child: Row(
//                               children: [
//                                 getSmallImageAsset(
//                                     "assets/images/google.png", 24.0),
//                                 const Expanded(
//                                   child: Text("Sign up with Google",
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 14)),
//                                 ),
//                               ],
//                             ),
//                             style: flatBtnStyle1,
//                             onPressed: () {
//                               controller.loginWithGoogle();
//                               // context
//                               //     .read<AuthenticationService>()
//                               //     .signUpWithGoogle();
//                             }),
//                       ),
//                     ],
//                   ),

//                   // Padding(
//                   //   padding: const EdgeInsets.only(
//                   //       top: _minimumPadding, bottom: _minimumPadding),
//                   //   child: ElevatedButton(
//                   //     child: Row(
//                   //       children: [
//                   //         getSmallImageAsset(
//                   //             "assets/images/facebook.png", 24.0),
//                   //         const Text("Continue with Facebook",
//                   //             style: TextStyle(
//                   //                 color: Colors.black,
//                   //                 fontWeight: FontWeight.w600,
//                   //                 fontSize: 14)),
//                   //       ],
//                   //     ),
//                   //     style: flatBtnStyle1,
//                   //     onPressed: () {
//                   //       controller.loginWithFacebook();
//                   //       // context
//                   //       //     .read<AuthenticationService>()
//                   //       //     .signUpWithFacebook();
//                   //     },
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         top: _minimumPadding, bottom: _minimumPadding),
//                     child: Row(
//                       children: <Widget>[
//                         // Expanded(
//                         //   child: TextFormField(
//                         //     keyboardType: TextInputType.number,
//                         //     style: textStyle,
//                         //     controller: termController,
//                         //      validator: (String? value) {
//                         //   if (value!.isEmpty) {
//                         //     return 'Please enter term';
//                         //   }
//                         // },
//                         //     decoration: InputDecoration(
//                         //       labelText: 'Term',
//                         //       hintText: 'In years',
//                         //       labelStyle: textStyle,
//                         //       border: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(5.0),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ), 4839  13
//                         Container(
//                           width: _minimumPadding * 5,
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Padding(
//                   //   padding: EdgeInsets.all(_minimumPadding * 2),
//                   //   child: Text(this.displayResult),
//                   // )
//                 ],
//               )),
//         ),
//       ),
//     );
//   }

//   Widget getImageAsset(path, size) {
//     AssetImage assetImage = AssetImage(path);
//     Image image = Image(
//       image: assetImage,
//       width: size,
//       height: size,
//     );
//     return Container(
//       child: image,
//       margin: EdgeInsets.all(_minimumPadding * 1),
//     );
//   }

//   Widget getSmallImageAsset(path, size) {
//     AssetImage assetImage = AssetImage(path);
//     Image image = Image(
//       image: assetImage,
//       width: size,
//       height: size,
//     );
//     return Container(
//       child: image,
//       margin: const EdgeInsets.fromLTRB(20.0, 10.0, 15.0, 10.0),
//     );
//   }

//   // void _googleSignin() {
//   //   FirebaseAuth auth = FirebaseAuth.instance;
//   //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//   //     if (user == null) {
//   //       print('User is currently signed out!');
//   //     } else {
//   //       print('User is signed in!');
//   //     }
//   //   });
//   //}
// }
