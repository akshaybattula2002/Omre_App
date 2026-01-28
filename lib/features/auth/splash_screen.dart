import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF020000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {},
        ),
      )
      ..addJavaScriptChannel(
        'SplashComp',
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == 'completed') {
            // Optional: Keep this if the video finishes early
            Get.offAllNamed('/login');
          }
        },
      )
      ..loadFlutterAsset('assets/html/splash_animation.html');

    // Force navigation after 7 seconds
    Future.delayed(const Duration(seconds: 7), () {
      if (Get.currentRoute == '/splash') {
        Get.offAllNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020000),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
