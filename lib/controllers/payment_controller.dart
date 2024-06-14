import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final isLoading = false.obs;
  final checkoutUrl = "".obs;
  final transactionId = "".obs;
  final newUrl = "".obs;
  final show = false.obs;
  var webViewController;
  @override
  void onInit() {
    checkoutUrl.value = Get.arguments[0];
    transactionId.value = Get.arguments[1];

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..clearLocalStorage()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            _handleUrlChanged(url);
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..runJavaScriptReturningResult()
      ..loadRequest(Uri.parse('${checkoutUrl.value}'));

    super.onInit();
  }

  Future<void> _handleUrlChanged(String url) async {
    // Use Uri to parse the URL and extract query parameters
    Uri uri = Uri.parse(url);
    Map<String, String> queryParams = uri.queryParameters;

    // Print or handle the query parameters as needed
    print('Query Parameters: $queryParams');
    String? code = queryParams['code'];

    inspect("code $code");

    if (code == "000") {
      await updateTransactionStatus();
      Get.back();
      inspect("Show a success button. Close it when clicked");
    }

    // // Optionally, you can launch a new URL based on the query parameters
    // // For example, open a new URL when a specific parameter is present
    // if (queryParams.containsKey('openUrl')) {
    //   String newUrl = queryParams['openUrl']!;

    //   print("newUrlnewUrlnewUrlnewUrlnewUrlnewUrlnewUrlnewUrl $newUrl");
    //   // _launchUrl(newUrl);
    // }
  }

  Future updateTransactionStatus() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('transaction');

      // Reference to the specific document using the provided documentId
      DocumentReference documentReference = collection.doc(transactionId.value);

      // Update the specific field in the document
      await documentReference.update({
        'txStatusCode': 3,
        'paymentStatus': 1
        // Add more fields as needed
      });

      print('Document field updated successfully');
    } catch (error) {
      print('Error updating document field: $error');
    }
  }
}
