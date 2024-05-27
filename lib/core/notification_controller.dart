import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var title = ''.obs;
  var message = ''.obs;
  var imageUrl = ''.obs;

  void updateMessage(String newTitle, String newMessage,
      {String? newImageUrl}) {
    title.value = newTitle;
    message.value = newMessage;
    imageUrl.value = newImageUrl ?? '';
    _showDialog(newTitle, newMessage, newImageUrl);
  }

  void _showDialog(String newTitle, String newMessage, String? newImageUrl) {
    Get.dialog(
      AlertDialog(
        title: Text(newTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(newMessage),
            if (newImageUrl != null && newImageUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.network(newImageUrl),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible:
          false, // Prevent dialog from closing when clicking outside
    );
  }
}
