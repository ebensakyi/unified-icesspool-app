// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:onboarding/onboarding.dart';
// import 'package:icesspool/views/login_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OnboardingView extends StatefulWidget {
//   const OnboardingView({Key? key}) : super(key: key);

//   @override
//   State<OnboardingView> createState() => _OnboardingViewState();
// }

// class _OnboardingViewState extends State<OnboardingView> {
//   late Material materialButton;
//   late int index;
//   final onboardingPagesList = [
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.indigo.shade800,
//           border: Border.all(
//             width: 0.0,
//             color: background,
//           ),
//         ),
//         child: SingleChildScrollView(
//           controller: ScrollController(),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 45.0,
//                   vertical: 90.0,
//                 ),
//                 child: Image.asset('assets/images/camera.png',
//                     width: 200.0, height: 200.0),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'LIVE REPORT',
//                     style: pageTitleStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 50.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Send report right from the location of the nuisance with your camera.\nChoose Live Repoort at the report type for this',
//                     style: pageInfoStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//               // const Padding(
//               //   padding:
//               //       EdgeInsets.symmetric(horizontal: 45.0, vertical: 100.0),
//               //   child: Align(
//               //     alignment: Alignment.centerLeft,
//               //     child: Text(
//               //       'Choose Live Repoort at the report type for this',
//               //       style: pageInfoStyle,
//               //       textAlign: TextAlign.left,
//               //     ),
//               //   ),
//               // ),
//               // const Padding(
//               //   padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
//               //   child: Align(
//               //     alignment: Alignment.centerLeft,
//               //     child: Text(
//               //       'Keep your files in closed safe so you can\'t lose them. Consider TrueNAS.',
//               //       style: pageInfoStyle,
//               //       textAlign: TextAlign.left,
//               //     ),
//               //   ),
//               // ),
//               // const Padding(
//               //   padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
//               //   child: Align(
//               //     alignment: Alignment.centerLeft,
//               //     child: Text(
//               //       'Keep your files in closed safe so you can\'t lose them. Consider TrueNAS.',
//               //       style: pageInfoStyle,
//               //       textAlign: TextAlign.left,
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.amber.shade800,
//           border: Border.all(
//             width: 0.0,
//             color: background,
//           ),
//         ),
//         child: SingleChildScrollView(
//           controller: ScrollController(),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 45.0,
//                   vertical: 90.0,
//                 ),
//                 child: Image.asset('assets/images/gallery.png',
//                     width: 200.0, height: 200.0),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'LATE REPORT',
//                     style: pageTitleStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 60.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Send report from your gallery. This applies if you have the picture the nuisance in your gallery',
//                     style: pageInfoStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.green.shade800,
//           border: Border.all(
//             width: 0.0,
//             color: background,
//           ),
//         ),
//         child: SingleChildScrollView(
//           controller: ScrollController(),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 45.0,
//                   vertical: 90.0,
//                 ),
//                 child: Image.asset(
//                   'assets/images/submit.png',
//                   width: 120,
//                   height: 120,
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'SUBMIT',
//                     style: pageTitleStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 80.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'After filling the single form and uploading the picture, hit on the submiit button.\nYour MMDA would attend to it as soon as possible',
//                     style: pageInfoStyle,
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     materialButton = _skipButton();
//     index = 0;
//   }

//   Material _skipButton({void Function(int)? setIndex}) {
//     return Material(
//       borderRadius: defaultSkipButtonBorderRadius,
//       color: defaultSkipButtonColor,
//       child: InkWell(
//         borderRadius: defaultSkipButtonBorderRadius,
//         onTap: () {
//           if (setIndex != null) {
//             index = 2;
//             setIndex(2);
//           }
//         },
//         child: const Padding(
//           padding: defaultSkipButtonPadding,
//           child: Text(
//             'Skip',
//             style: defaultSkipButtonTextStyle,
//           ),
//         ),
//       ),
//     );
//   }

//   Material get _signupButton {
//     return Material(
//       borderRadius: defaultProceedButtonBorderRadius,
//       color: Colors.blue,
//       child: InkWell(
//         borderRadius: defaultProceedButtonBorderRadius,
//         onTap: () async {
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           prefs.setBool('onBoard', true);
//           Get.off(() => LoginView());
//         },
//         child: const Padding(
//           padding: defaultProceedButtonPadding,
//           child: Text(
//             'Enter',
//             style: defaultProceedButtonTextStyle,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Sanitation Reporter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         body: Onboarding(
//           pages: onboardingPagesList,
//           onPageChange: (int pageIndex) {
//             index = pageIndex;
//           },
//           startPageIndex: 0,
//           footerBuilder: (context, dragDistance, pagesLength, setIndex) {
//             return DecoratedBox(
//               decoration: BoxDecoration(
//                 color: background,
//                 border: Border.all(
//                   width: 0.0,
//                   color: background,
//                 ),
//               ),
//               child: ColoredBox(
//                 color: background,
//                 child: Padding(
//                   padding: const EdgeInsets.all(45.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomIndicator(
//                           netDragPercent: dragDistance,
//                           pagesLength: pagesLength,
//                           indicator: Indicator(
//                             indicatorDesign: IndicatorDesign.line(
//                               lineDesign: LineDesign(
//                                 lineType: DesignType.line_nonuniform,
//                               ),
//                             ),
//                           )),
//                       index == pagesLength - 1
//                           ? _signupButton
//                           : _skipButton(setIndex: setIndex)
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
