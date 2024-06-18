import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:icesspool/core/notification_service.dart';
import 'package:sizer/sizer.dart';
import 'bindings/initial_binding.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool onboardingViewed = false;
bool isLogin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync<NotificationService>(
      () async => await NotificationService().init());

  await GetStorage.init();

  final box = GetStorage();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await Firebase.initializeApp(
  //     name: "dev project", options: DefaultFirebaseOptions.currentPlatform);

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  //isViewed = prefs.getBool('onBoard');

  isLogin = box.read('isLogin') ?? false;
  onboardingViewed = box.read('onboardingViewed') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: InitialBindings(),
        title: 'iCesspool',
        debugShowCheckedModeBanner: false,
        initialRoute: !onboardingViewed
            ? AppPages.ONBOARDING
            : (isLogin ? AppPages.HOME : AppPages.INITIAL),
        getPages: AppPages.routes,
      );
    });
  }
}
