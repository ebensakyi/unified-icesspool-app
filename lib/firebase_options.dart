// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCj0Ln0FUwpX9SmxdM08tqI1FjswmLGVL0',
    appId: '1:314314044157:web:9bc99b749bb1d45d664494',
    messagingSenderId: '314314044157',
    projectId: 'unified-icesspool-app',
    authDomain: 'unified-icesspool-app.firebaseapp.com',
    storageBucket: 'unified-icesspool-app.appspot.com',
    measurementId: 'G-DGZXHZK4E9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZ_Q4dtZahhty9p5C36TCphOUMg31xFZw',
    appId: '1:314314044157:android:b01674239539afdb664494',
    messagingSenderId: '314314044157',
    projectId: 'unified-icesspool-app',
    storageBucket: 'unified-icesspool-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7L2scYGbzAt62rPo9i4F_ais7IGroiV0',
    appId: '1:314314044157:ios:bde500db8c07caae664494',
    messagingSenderId: '314314044157',
    projectId: 'unified-icesspool-app',
    storageBucket: 'unified-icesspool-app.appspot.com',
    iosBundleId: 'com.icesspool.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7L2scYGbzAt62rPo9i4F_ais7IGroiV0',
    appId: '1:314314044157:ios:bde500db8c07caae664494',
    messagingSenderId: '314314044157',
    projectId: 'unified-icesspool-app',
    storageBucket: 'unified-icesspool-app.appspot.com',
    iosBundleId: 'com.icesspool.unified',
  );
}
