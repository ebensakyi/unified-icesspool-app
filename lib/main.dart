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
import 'package:sizer/sizer.dart';
import 'bindings/initial_binding.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';

// bool get isInDebugMode {
//   bool inDebugMode = false;
//   assert(inDebugMode = true);
//   return inDebugMode;
// }
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool onboardingViewed = false;
bool isLogin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  final box = GetStorage();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await Firebase.initializeApp(
      name: "dev project", options: DefaultFirebaseOptions.currentPlatform);

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) async {
    box.write("fcmId", value.toString());
  });
  //isViewed = prefs.getBool('onBoard');

  isLogin = box.read('isLogin') ?? false;
  onboardingViewed = box.read('onboardingViewed') ?? false;

  messaging.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  // Handle incoming FCM messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // var title = message.notification!.title;
    // var body = message.notification!.body;

    // inspect(message);
    // Get.snackbar(
    //   title!,
    //   body!,
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: Colors.black87,
    //   colorText: Colors.white,
    //   duration: Duration(seconds: 8),
    //   borderRadius: 10.0,
    //   margin: EdgeInsets.all(10.0),
    //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    //   isDismissible: true,
    // );
    // print('Received a foreground message:>> ${message}');
    // print('Received a foreground message: ${message.notification?.title}');

    // Display notification using flutter_local_notifications
    await displayNotification(flutterLocalNotificationsPlugin, message);
  });
  runApp(const MyApp());
}

Future<void> displayNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RemoteMessage message) async {
  try {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1',
      'ICESSPOOL',
      importance: Importance.max,
      priority: Priority.high,
    );

    // var iOSPlatformChannelSpecifics = DarwinInitializationSettings();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.show(
      0, // notification id
      message.notification!.title, // title of notification
      message.notification!.body, // body of notification
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  } catch (e) {
    log("displayNotification==> " + e.toString());
  }
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
          primaryColor: Colors.grey.shade800,
          textTheme: TextTheme(
            displaySmall: TextStyle(
              color: Colors.blueGrey.shade700,
            ),
          ),
          // appBarTheme: AppBarTheme(
          //   backgroundColor: Colors.blueGrey.shade800,
          //   elevation: 0,
          //   centerTitle: true,
          // ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade900,
          textTheme: TextTheme(
            displaySmall: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        // theme: ThemeData(
        //     primarySwatch: Colors.indigo,
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //     useMaterial3: true),

        initialRoute: !onboardingViewed
            ? AppPages.ONBOARDING
            : (isLogin ? AppPages.HOME : AppPages.INITIAL),
        getPages: AppPages.routes,

        // routes: {"/": (ctx) => LoginView()},

        // routes: {
        //   '/': (context) => !isLogin! ? LoginView() : HomeView(),
        // },
      );
    });
  }
}
