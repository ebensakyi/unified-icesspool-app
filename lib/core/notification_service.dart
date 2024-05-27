import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'notification_controller.dart';

class NotificationService extends GetxService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationController _notificationController =
      Get.put(NotificationController());

  Future<NotificationService> init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        String? title = message.notification!.title;
        String? imageUrl = message.notification!.android?.imageUrl ??
            message.notification!.apple?.imageUrl;
        _notificationController.updateMessage(
          title ?? 'No title',
          message.notification!.body ?? 'No message',
          newImageUrl: imageUrl,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      String? title = message.notification!.title;
      String? imageUrl = message.notification!.android?.imageUrl ??
          message.notification!.apple?.imageUrl;
      _notificationController.updateMessage(
        title ?? 'No title',
        message.notification!.body ?? 'No message',
        newImageUrl: imageUrl,
      );
    });

    // Handle messages when the app is launched from a terminated state
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      String? title = initialMessage.notification!.title;
      String? imageUrl = initialMessage.notification!.android?.imageUrl ??
          initialMessage.notification!.apple?.imageUrl;
      _notificationController.updateMessage(
        title ?? 'No title',
        initialMessage.notification!.body ?? 'No message',
        newImageUrl: imageUrl,
      );
    }

    return this;
  }
}
