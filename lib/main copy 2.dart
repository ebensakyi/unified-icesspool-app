import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'bindings/initial_binding.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    name: "dev project",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final box = GetStorage();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fcmToken = await messaging.getToken();
  if (fcmToken != null) {
    box.write("fcmId", fcmToken);
  }

  bool isFirstTimeOpen = box.read('isFirstTimeOpen') ?? true;
  bool isLogin = box.read('isLogin') ?? false;

  runApp(MyApp(
    isFirstTimeOpen: isFirstTimeOpen,
    isLogin: isLogin,
  ));
}

class MyApp extends StatelessWidget {
  final bool isFirstTimeOpen;
  final bool isLogin;

  const MyApp({
    required this.isFirstTimeOpen,
    required this.isLogin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    inspect(isFirstTimeOpen
        ? AppPages.ONBOARDING
        : (isLogin ? AppPages.HOME : AppPages.INITIAL));
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: InitialBindings(),
        title: 'iCesspool',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        // initialRoute: isFirstTimeOpen
        //     ? AppPages.ONBOARDING
        //     : (isLogin ? AppPages.HOME : AppPages.INITIAL),
        initialRoute: AppPages.HOME,
      );
    });
  }
}
