import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sizer/sizer.dart';
import 'bindings/initial_binding.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

// bool? isViewed;
bool isLogin = false;
void main() async {
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   // Log the error details
  //   print('Caught an error: ${details.exception}\n${details.stack}');

  //   // Optionally, rethrow the exception for debugging in debug mode
  //   if (isInDebugMode) {
  //     FlutterError.dumpErrorToConsole(details);
  //   } else {
  //     // Handle the error in your release build, e.g., report to analytics
  //     // or show a user-friendly error message
  //     // handleReleaseError(details);
  //   }
  // };
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await Firebase.initializeApp(
      name: "dev project", options: DefaultFirebaseOptions.currentPlatform);

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  FirebaseMessaging messaging;
  messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) async {
    // print(value);
    prefs.setString("fcmId", value.toString());
  });
  //isViewed = prefs.getBool('onBoard');

  isLogin = prefs.getBool('isLogin') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: InitialBindings(),
        title: 'iCesspool',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true),

        // theme: ThemeData(
        //   // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
        //   //     .copyWith(secondary: Colors.amber),
        //   // inputDecorationTheme: const InputDecorationTheme(
        //   //   enabledBorder: OutlineInputBorder(
        //   //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
        //   //   ),
        //   //   focusedBorder: OutlineInputBorder(
        //   //     borderSide: BorderSide(width: 3, color: Colors.amberAccent),
        //   //   ),
        //   // ),
        //   primarySwatch: MyColors.MainColor.asMaterialColor,
        //   // inputDecorationTheme: InputDecorationTheme(
        //   //   labelStyle: TextStyle(color: Colors.redAccent),
        //   // ),
        // ),
        //home: HomePage(),
        // initialRoute: AppPages.INITIAL,

        // initialRoute: isLogin ? AppPages.HOME : AppPages.INITIAL,

        initialRoute: AppPages.ONBOARDING,
        getPages: AppPages.routes,

        // routes: {"/": (ctx) => LoginView()},

        // routes: {
        //   '/': (context) => !isLogin! ? LoginView() : HomeView(),
        // },
      );
    });
  }
}
