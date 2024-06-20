import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Initializing Firebase...");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Get.putAsync<NotificationService>(
      () async => await NotificationService().init());

  await GetStorage.init();

  final box = GetStorage();

  try {
    print("Loading SSL certificate...");
    ByteData data =
        await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(data.buffer.asUint8List());
    print("SSL certificate loaded.");
  } catch (e) {
    print("Error loading SSL certificate: $e");
  }

  isLogin = box.read('isLogin') ?? false;
  onboardingViewed = box.read('onboardingViewed') ?? false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
