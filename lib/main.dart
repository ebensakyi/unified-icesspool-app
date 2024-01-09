import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sizer/sizer.dart';
import 'bindings/initial_binding.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';

bool? isViewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  FirebaseMessaging messaging;
  messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) async {
    // print(value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fcmId", value.toString());
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getBool('onBoard');

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
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
          //     .copyWith(secondary: Colors.amber),
          // inputDecorationTheme: const InputDecorationTheme(
          //   enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(width: 3, color: Colors.amberAccent),
          //   ),
          // ),
          primarySwatch: MyColors.MainColor.asMaterialColor,
          // inputDecorationTheme: InputDecorationTheme(
          //   labelStyle: TextStyle(color: Colors.redAccent),
          // ),
        ),
        //home: HomePage(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,

        routes: {"/": (ctx) => LoginView()},

        // {
        //   '/': (context) => isViewed == null
        //       ? OnboardingView()
        //       : isViewed == false
        //           ? OnboardingView()
        //           : LoginView(),
        // },
      );
    });
  }
}
