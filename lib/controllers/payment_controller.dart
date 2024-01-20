import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController {
  final isLoading = false.obs;
  final checkoutUrl = "".obs;
  final newUrl = "".obs;
  var webViewController;
  @override
  void onInit() {
    checkoutUrl.value = Get.arguments[0];

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

  void _handleUrlChanged(String url) {
    // Use Uri to parse the URL and extract query parameters
    Uri uri = Uri.parse(url);
    Map<String, String> queryParams = uri.queryParameters;

    // Print or handle the query parameters as needed
    print('Query Parameters: $queryParams');
    String? code = queryParams['code'];

    inspect("code $code");

    if (code == "000") {
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
}
